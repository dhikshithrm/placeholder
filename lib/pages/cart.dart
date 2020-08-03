import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:its12/items/cart_products.dart';

import '../homepage.dart';
class Cart extends StatefulWidget {
  @override
  _CartState createState() => _CartState();
}

class _CartState extends State<Cart> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.black),
              title: InkWell(
                onTap: () => Navigator.of(context).push(CupertinoPageRoute(builder: (context) => HomePage())),
                  child: Image(image: AssetImage('assets/new.png'),
                  width: 105,
                  height: 110,
                 ),
              ),
                elevation: 0.0,
                flexibleSpace: Container(
                  height: 90,
                  width: double.infinity,
                  color: Colors.black26.withOpacity(0.2),
                ),
                backgroundColor: Colors.transparent,
                actions: <Widget>[
            IconButton(
              icon: Icon(Icons.search,
                  color: Colors.black,
                  size: 30.0,
                  ),
                  onPressed: (){}
              ),
        ],
      ),
      bottomNavigationBar: Container(
        color: Colors.white,
        child: Row(
          children: <Widget>[
            Expanded(child: ListTile(
              title: Text("Total:"),
              subtitle: Text("₹3756"),
            ),),
            Expanded(child: MaterialButton(onPressed: (){},
            color: Color(0xFAB30000),
            child: Text("Check Out",style: TextStyle(color: Colors.white,),),
            ),  
            ),
            SizedBox(width:10.0)
          ],
        ),
      ),
      body: Container(
        child: Cart_products(),
      ),
    );
  }
}