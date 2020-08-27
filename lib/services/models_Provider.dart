import 'package:flutter/cupertino.dart';

class User with ChangeNotifier{
  final String username;
  final String email;
  final String dp;
  final String id;
  User(this.username, this.email, this.dp, this.id);
  factory User.fromMap(Map data){
    return User(data["username"]??"", data["email"]??'', data["dp"]??"", data["id"]??"");
  }
}