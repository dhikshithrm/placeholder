import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:its12/pages/product_page.dart';
import 'package:its12/services/item_services.dart';
import 'package:its12/services/user_management.dart';

class Wishlist_Items extends StatefulWidget {
  final String userId;
  final List<Map<String,dynamic>> wishlistItems;
  Wishlist_Items({this.userId, this.wishlistItems});
  @override
  _Wishlist_ItemsState createState() => _Wishlist_ItemsState();
}

// ignore: camel_case_types
class _Wishlist_ItemsState extends State<Wishlist_Items> {
  @override
  void initState() {
    print(widget.wishlistItems);
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return ListView.builder(itemBuilder: (context,index){
      return Single_Cart_prod(
        cart_prod_name: widget.wishlistItems[index]['name'],
        cart_prod_price: widget.wishlistItems[index]['price'],
        cart_prod_pricture: widget.wishlistItems[index]['imageUrl'],
        cart_prod_description: widget.wishlistItems[index]['description'],
        cart_prod_diffVariants: widget.wishlistItems[index]['customisable'],
        cart_prod_old_price: widget.wishlistItems[index]['old_price'],
      );
    },itemCount: widget.wishlistItems.length,);
            }}
class Single_Cart_prod extends StatelessWidget {
  final cart_prod_name;
  final cart_prod_pricture;
  final cart_prod_old_price;
  final cart_prod_price;
  final cart_prod_qnt;
  final cart_prod_description;
  final cart_prod_diffVariants;

const Single_Cart_prod({
  this.cart_prod_name,
  this.cart_prod_pricture, 
  this.cart_prod_old_price, 
  this.cart_prod_price, 
  this.cart_prod_qnt, 
  this.cart_prod_description,
  this.cart_prod_diffVariants,
  
  });
  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        leading: Image.network(cart_prod_pricture),
        onTap: (){Navigator.of(context).pushReplacement(CupertinoPageRoute(
         builder: (context)=> ProductDetails(
              prod_name: cart_prod_name,
              prod_new_price: cart_prod_price,
              prod_old_price: cart_prod_old_price,
              prod_picture: cart_prod_pricture,
              prod_description: cart_prod_description,
              prod_diffVariants: cart_prod_diffVariants,
          )
         )
        );
       },
      title: Text(cart_prod_name,style: TextStyle(
        fontSize: 17.0
      ),),
        subtitle: Column(
          children: <Widget>[
            Row(
              children: <Widget>[
              Padding(padding: EdgeInsets.all(0.0),child: Text("Size:")),
              Padding(padding: EdgeInsets.all(4.0),child: Text("Color: ")),
              ],
            ),
            Container(
              alignment: Alignment.topLeft,
              child: Text("₹$cart_prod_price",
              style: TextStyle(
                fontSize: 15.0,
                fontWeight: FontWeight.bold
              ),
              ),
            )
          ],
        ),
      ),
    );
  }
 }
