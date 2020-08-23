import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';
import 'package:its12/services/user_management.dart';
import 'package:path/path.dart' as Path;
import 'package:image_cropper/image_cropper.dart';

class Signup extends StatefulWidget {
  @override
  _SignupState createState() => _SignupState();
}

class _SignupState extends State<Signup> {
  File image;
  String _name;
  String _email;
  String _password;
  String _phone;
  String _uploadUrl;
  StorageReference storageReference;
  UserManagemenent _userManagemenent = UserManagemenent();

  Future getImage()async{
    final pickedFile = await ImagePicker.pickImage(source: ImageSource.gallery);
    File cropped = await ImageCropper.cropImage(
      sourcePath: pickedFile.path,
      aspectRatio: CropAspectRatio(ratioX: 1,ratioY: 1),
      compressQuality: 100,
      maxHeight: 200,
      maxWidth: 200,
      androidUiSettings: AndroidUiSettings(
        toolbarColor: Colors.black87,
        toolbarTitle: "Cropper",
        statusBarColor: Colors.redAccent,
        backgroundColor: Colors.white
      ));
    setState(() {
      image = cropped;
    });
    storageReference = FirebaseStorage.instance.ref()
    .child('users/${Path.basename(image.path)}');
   }
      @override
      Widget build(BuildContext context) {
        return Scaffold(
         body: Center(
           child: Container(
             padding: EdgeInsets.all(25.0),
             child: SingleChildScrollView(
                 child: Column(
                 mainAxisAlignment: MainAxisAlignment.center,
                 children: <Widget>[
                   Padding(
                     padding: const EdgeInsets.all(20.0),
                     child:  Container(
                         height: 200,
                         width: 200,
                         decoration: BoxDecoration(
                           color: Colors.black26,
                           borderRadius: BorderRadius.circular(7.0)
                         ),
                         child: Center(
                            child: image == null? IconButton(
                            icon: Icon(Icons.add_a_photo),
                            onPressed: getImage,
                          ): Image.file(image,fit: BoxFit.cover,),
                        ),
                       ),
                     ),
                   TextField(
                     decoration: InputDecoration(
                       hoverColor: Colors.black26,
                       border: OutlineInputBorder(),
                       hintText: 'Full Name'
                     ),
                     onChanged: (value){
                       setState(() {
                         _name = value;
                       });
                     },
                   ),
                  SizedBox(height: 15.0),
                   TextField(
                     decoration: InputDecoration(
                       border: OutlineInputBorder(),
                       hintText: 'Email'
                     ),
                     onChanged: (value){
                       setState(() {
                         _email = value;
                       });
                     },
                   ),
                  SizedBox(height: 20.0,),
                  TextField(
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      hintText: "Password",
                      ),
                    onChanged: (value){
                      setState(() {
                        _password = value;
                      });
                    },
                    obscureText: true,
                  ),
                  SizedBox(height: 20.0,),
                  RaisedButton(
                    child: Text("Sign Up",style: TextStyle(color: Colors.white),),
                    color: Colors.black,
                    elevation: 7.0,
                    onPressed: ()async{
                     if(image!=null){
                      StorageUploadTask uploadTask = storageReference.putFile(image);
                        await uploadTask.onComplete;
                        Fluttertoast.showToast(msg: "Account Created");
                        storageReference.getDownloadURL().then(
                          (fileUrl){
                            setState(() {
                              _uploadUrl = fileUrl;
                            });
                          }); 
                       }
                      FirebaseAuth.instance.createUserWithEmailAndPassword(
                        email: _email,
                        password: _password,
                        ).then((signedInUser){
                          UserUpdateInfo updateuser =UserUpdateInfo();
                          updateuser.displayName = _name;
                          updateuser.photoUrl = _uploadUrl;
                          signedInUser.user.updateProfile(updateuser);
                          _userManagemenent.createUser(
                            context,
                            name: _name,
                            email: _email,
                            id: signedInUser.user.uid
                          );
                        }).catchError((e){
                          AlertDialog(
                            title: Text("Error"),
                            content: Text(e),
                            actions: <Widget>[
                              MaterialButton(onPressed: (){
                                Navigator.of(context).pop();
                              },child: Text("Close"),)
                            ],
                          );
                        });
                    },
                  )
                 ],
               ),
             ),
           ),
         ),
        );
      }
  }
