import 'package:flutter/cupertino.dart';

class UserC with ChangeNotifier{
  final String username;
  final String email;
  final String dp;
  final String id;
  final List<String> wishlist;
  final List<String> address;
  UserC(this.username, this.email, this.dp, this.id, this.address,[this.wishlist]);
  factory UserC.fromMap(Map data){
    return UserC(data["username"]??"", data["email"]??'', data["dp"]??"", data["id"]??"",data['addresses']??[],data['wishlist']??[]);
  }
}

class ProductC with ChangeNotifier{
  final String name;
  final int old_price;
  final String description;
  final String imageUrl;
  final int price;
  final String categories;
  final String id;
  final List<String> addresses;
  final bool instock;
  final bool cutomisable;
  ProductC(this.old_price, this.cutomisable, this.addresses, {this.id,this.name,this.instock, this.description, this.imageUrl, this.price, this.categories,});
  factory ProductC.fromMap(Map data){
    return ProductC(data['old_price'],data['customisable'],data['addresses'],name: data['name'],instock: data['inStock'],id: data['id'],description: data['description'],imageUrl: data['imageUrl'],price: data['price'],categories: data['categories'],);
  }
}