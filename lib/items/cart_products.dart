import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:its12/pages/product_page.dart';

class Cart_products extends StatefulWidget {
  @override
  _Cart_productsState createState() => _Cart_productsState();
}

class _Cart_productsState extends State<Cart_products> {
  var items_inCart = [{
     "name":"Butterscotch Cake(Eggless)",
     "picture": "assets/Products/cakes2.jpg",
     "old_price": 399,
     "price": 339,
     "size": "500g",
     "quantity" : 1,
     'color' : null,
   },
   {
     "name":"Flower Bouquet",
     "picture": "assets/Products/flowerbouquet.jpg",
     "old_price": 450,
     "price": 399,
     "color": "red",
     "size" : null,
     "quantity": 1
   },
   {
     "name":"Chocolate",
     "picture": "assets/Products/silkoreo.jpg",
     "old_price": 450,
     "price": 399,
     "color" : null,
     "size" : null,
     "quantity": 1
   },];
   
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: 3,
      itemBuilder: (context,index){
        return Single_Cart_prod(
          cart_prod_color: items_inCart[index]["color"],
          cart_prod_name: items_inCart[index]["name"],
          cart_prod_old_price: items_inCart[index]["old_price"],
          cart_prod_price: items_inCart[index]["price"],
          cart_prod_pricture: items_inCart[index]["picture"],
          cart_prod_qnt: items_inCart[index]["qauntity"],
          cart_prod_size: items_inCart[index]["size"],
          );
      }
    );
  }
}
class Single_Cart_prod extends StatelessWidget {
  final cart_prod_name;
  final cart_prod_pricture;
  final cart_prod_old_price;
  final cart_prod_price;
  final cart_prod_qnt;
  final cart_prod_size;
  final cart_prod_color;
const Single_Cart_prod({this.cart_prod_name, this.cart_prod_pricture, this.cart_prod_old_price, this.cart_prod_price, this.cart_prod_qnt, this.cart_prod_size, this.cart_prod_color});
  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        leading: Image.asset(cart_prod_pricture),
        onTap: (){Navigator.of(context).pushReplacement(CupertinoPageRoute(
         builder: (context)=> ProductDetails(
          prod_name: cart_prod_name,
          prod_new_price: cart_prod_price,
          prod_old_price: cart_prod_old_price,
          prod_picture: cart_prod_pricture,
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
        trailing: Column(
          
        )
      ),
    );
  }
 }
 void addQuantity(int cart_prod_qnt){
   cart_prod_qnt++;
 }