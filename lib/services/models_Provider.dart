import 'package:flutter/cupertino.dart';

class User with ChangeNotifier{
  final String username;
  final String email;
  final String dp;
  final String id;
  List<String> wishlist;
  User(this.username, this.email, this.dp, this.id,[this.wishlist]);
  factory User.fromMap(Map data){
    return User(data["username"]??"", data["email"]??'', data["dp"]??"", data["id"]??"",data['wishlist']);
  }
}