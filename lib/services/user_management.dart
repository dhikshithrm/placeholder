import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:its12/services/models_Provider.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UserManagemenent {
  Firestore db = Firestore.instance;
  FirebaseDatabase _database = FirebaseDatabase.instance;
  String ref =  "users";
  Future<void> createUser(context,{String name,String id,String email,String imageUrl}){
    db.collection(ref).document(id).setData({
      'username': name,
      'id': id,
      'email': email,
      'dp': imageUrl,
    });
    Navigator.of(context).pop();
    }
      Stream<User> getUserStream(String id,[context]) {
       return db.collection("users")
               .document(id)
               .snapshots()
               .map((event) => User.fromMap(event.data??{'email':'','dp':'','username':Provider.of<FirebaseUser>(context).displayName,'id':''}));
      }
      Stream<List<String>> getUserWishlist(String id){
        return db.collection("users")
                .document(id)
                .snapshots()
                .map((event) => event.data['wishlist']);
      }
}