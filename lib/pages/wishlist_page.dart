import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:its12/items/wishlistItems.dart';
import 'package:its12/services/models_Provider.dart';
import 'package:its12/services/user_management.dart';
import 'package:provider/provider.dart';

import '../homepage.dart';
class Wishlist  extends StatefulWidget {
  String userId;
  Wishlist({this.userId});
  @override
  _WishlistState createState() => _WishlistState();
}

class _WishlistState extends State<Wishlist> {
  List<Map<String,dynamic>> wishlistItems=[];
  @override
  void initState() { 
    super.initState();
    print(widget.userId);
  }
  Stream<List<Map<String,dynamic>>> getWishlist(){
    return Firestore.instance.collection('users/${widget.userId}/wishlist').snapshots().map((event) => event.documents.map((e) => e.data).toList());
  }
  
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
              title: InkWell(
                onTap: () => Navigator.of(context).push(CupertinoPageRoute(builder: (context) => HomePage())),
                  child: Image(image: AssetImage('assets/new.png'),
                  width: 105,
                  height: 110,
                 ),
              ),
                elevation: 0.0,
                backgroundColor: Colors.black,
                actions: <Widget>[
            IconButton(
              icon: Icon(Icons.search,
                  color: Colors.white,
                  size: 30.0,
                  ),
                  onPressed: (){}
              ),
        ],
      ),
      body: StreamProvider<List<Map<String,dynamic>>>.value(
         initialData: [{"name":'dhikshith'}],
         value: getWishlist(),
          child: Container(
           child: Consumer<List<Map<String,dynamic>>>(builder: (context,wishlist,child){
             return Wishlist_Items(userId: widget.userId,wishlistItems: wishlist,);
           })
          ),
       ),
    );
  }
}