import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:google_sign_in/google_sign_in.dart';


class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {

  String _email;
  String _password;

  final GoogleSignIn googleSignIn = GoogleSignIn();
  final FirebaseAuth firebaseAuth = FirebaseAuth.instance;
  SharedPreferences preferences;
  bool loading = false;
  bool isLogedin_wg = false;
  bool isLogedin_r = false;
  
  @override
  void initState() {

    isSignedIn();
        super.initState();
      }
 void isSignedIn() async{
        
        preferences = await SharedPreferences.getInstance();
        if(FirebaseAuth.instance.currentUser!=null){
          setState(() {
              isLogedin_r = true;
            });
        } 
        isLogedin_wg = await googleSignIn.isSignedIn();
        if(isLogedin_wg || isLogedin_r){
            Navigator.pushReplacementNamed(context, '/home');
          setState(() {
            isLogedin_wg = false;
            isLogedin_r = false;
          });
        }
      }

      Future handleSignIn() async{
        preferences = await SharedPreferences.getInstance();
        setState(() {
          loading = true;
        });

        GoogleSignInAccount googleUser = await googleSignIn.signIn();
        GoogleSignInAuthentication googleSignInAuthentication = await googleUser.authentication;
        final AuthCredential credential = GoogleAuthProvider.credential(idToken: googleSignInAuthentication.idToken, accessToken: googleSignInAuthentication.accessToken);
        User firebaseUser = (await firebaseAuth.signInWithCredential(credential)).user;

        if(firebaseUser != null){
          final QuerySnapshot result = await FirebaseFirestore.instance.collection('users').where("id", isEqualTo: firebaseUser.uid).get();
          final List<DocumentSnapshot> documents = result.docs;
          if(documents.length == 0){
            FirebaseFirestore.instance
            .collection('users')
            .doc(firebaseUser.uid)
            .set({
              "id" : firebaseUser.uid,
              "username" : firebaseUser.displayName,
              "dp" : firebaseUser.photoURL
            });
            await preferences.setString("id", firebaseUser.uid);
            await preferences.setString("username", firebaseUser.displayName);
            await preferences.setString("photoUrl", firebaseUser.photoURL);
          }else{
            await preferences.setString("id", documents[0]['id']);
            await preferences.setString("username", documents[0]['username']);
            await preferences.setString("dp", documents[0]['dp']);
          }
          Fluttertoast.showToast(msg: "Loggedin as ${firebaseUser.displayName}");
          setState(() {
            loading = false;
          });
          if(firebaseUser.displayName!=null && firebaseUser.photoURL!=null){
            Navigator.of(context).pushReplacementNamed('/home');
          }
        } 
        else{
          
        }
      }
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
                     border: OutlineInputBorder(),
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
                  decoration: InputDecoration(
                    hintText: "Password",
                    border: OutlineInputBorder(),
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
                  child: Text("Login",style: GoogleFonts.fredokaOne(fontSize: 20.0,),),
                  color: Colors.black,
                  textColor: Colors.white,
                  elevation: 7.0,
                  onPressed: (){
                    FirebaseAuth.instance.signInWithEmailAndPassword(
                      email: _email, password: _password
                    ).then((user) {
                      Navigator.of(context).pushReplacementNamed('/home');
                    });
                  },
                ),
                SizedBox(height: 15.0,),
                RaisedButton(onPressed: (){
                  handleSignIn();
                },
                color: Colors.black,
                  child: Row(children: <Widget>[
                    Image.asset("assets/glogo.png",height: 50,width: 50,),
                    SizedBox(width:6.0),
                    Text("Sign in with Google",style: GoogleFonts.fredokaOne(color: Colors.white,fontSize: 20.0),)
                  ],)
                ),
                SizedBox(height: 15.0,),
                Text('Don\'t have an account?'),
                SizedBox(height: 10.0,),
                RaisedButton(
                  child: Text("Sign Up",style: GoogleFonts.fredokaOne(color: Colors.white,fontSize: 20.0),),
                  color: Colors.black,
                  elevation: 7.0,
                  onPressed: (){
                    Navigator.of(context).pushNamed('/signuppage');
                  },
                ),
                Visibility(
                  visible: loading??true,
                  child: Container(
                    child: CircularProgressIndicator()
                  ),
                )
               ],
             ),
           ),
         ),
        );
      }
}