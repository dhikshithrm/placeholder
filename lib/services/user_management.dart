import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:its12/homepage.dart';
import 'package:firebase_database/firebase_database.dart';

class UserManagemenent {
  Firestore db = Firestore.instance;
  FirebaseDatabase _database = FirebaseDatabase.instance;
  String ref =  "users";
  createUser(String uid,Map value,context)async{
    _database.reference().child("$ref/$uid").set(value).catchError((e){
      AlertDialog(
           title: Text("Error"),
           content: Text(e),
           actions: <Widget>[
            MaterialButton(onPressed: (){
                     Navigator.of(context).pop();
           },child: Text("Close"),)
         ],
       );
    }
    );
    Navigator.of(context).pop();
    Navigator.of(context).pushReplacementNamed('/home');
  }
  }