import 'package:flutter/cupertino.dart';

class User with ChangeNotifier{
  final String username;
  final String email;
  final String dp;
  final String id;
  final List<String> wishlist;
  User(this.username, this.email, this.dp, this.id,[this.wishlist]);
  factory User.fromMap(Map data){
    return User(data["username"]??"", data["email"]??'', data["dp"]??"", data["id"]??"",data['wishlist']??[]);
  }
}

class Product with ChangeNotifier{
  final String name;
  final String old_price;
  final String description;
  final String imageUrl;
  final String price;
  final String categories;
  final String id;
  final bool instock;
  final bool cutomisable;
  Product(this.old_price, this.cutomisable, {this.id,this.name,this.instock, this.description, this.imageUrl, this.price, this.categories,});
  factory Product.fromMap(Map data){
    return Product(data['old_price'],data['customisable'],name: data['name'],instock: data['inStock'],id: data['id'],description: data['description'],imageUrl: data['imageUrl'],price: data['price'],categories: data['categories'],);
  }
}