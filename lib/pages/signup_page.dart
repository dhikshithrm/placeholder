import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:its12/services/user_management.dart';

class Signup extends StatefulWidget {
  @override
  _SignupState createState() => _SignupState();
}

class _SignupState extends State<Signup> {

  String _email;
  String _password;

  
      @override
      Widget build(BuildContext context) {
        return Scaffold(
         body: Center(
           child: Container(
             padding: EdgeInsets.all(25.0),
             child: Column(
               mainAxisAlignment: MainAxisAlignment.center,
               children: <Widget>[
                 TextField(
                   decoration: InputDecoration(
                     hintText: 'Email'
                   ),
                   onChanged: (value){
                     setState(() {
                       _email = value;
                     });
                   },
                 ),
                SizedBox(height: 15.0),
                TextField(
                  decoration: InputDecoration(hintText: "Password"),
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
                  onPressed: (){
                    FirebaseAuth.instance.createUserWithEmailAndPassword(
                      email: _email,
                      password: _password,
                      ).then((signedInUser){
                        UserManagemenent().storeNewUser(signedInUser, context);
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
        );
      }
}