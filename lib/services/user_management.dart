import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:firebase_database/firebase_database.dart';

class UserManagemenent {
  Firestore db = Firestore.instance;
  FirebaseDatabase _database = FirebaseDatabase.instance;
  String ref =  "users";
  Future createUser(context,{String name,String id,String email,String imageUrl}){
    db.collection(ref).document(id).setData({
      'username': name,
      'id': id,
      'email': email,
      'dp': imageUrl,
    });
    Navigator.of(context).pop();
    }
  }