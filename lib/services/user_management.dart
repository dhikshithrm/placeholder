import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:its12/homepage.dart';
class UserManagemenent {
  storeNewUser(user,context){
    Firestore.instance.collection('users').add({
      'uid' : user.uid,
      'email': user.email,
    }).then((value) {
      Navigator.of(context).pop();
      Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context)=> HomePage()));
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
  }
}