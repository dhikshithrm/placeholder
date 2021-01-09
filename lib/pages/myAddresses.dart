import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:its12/pages/addNewAddress.dart';

import 'cart.dart';
class MyAddresses extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
       appBar: AppBar(
              title: InkWell(
                onTap: () => Navigator.of(context).pushReplacementNamed('/home'),
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
                  onPressed: (){
                   
                  }
                ),
               IconButton(
                 icon: Icon(Icons.shopping_cart,
               color: Colors.white,
              ),
            onPressed: (){
               Navigator.push(context, CupertinoPageRoute(builder: (context)=> Cart()));
            }
         )
        ],
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: GestureDetector(
                onTap: (){
                   Navigator.of(context).push(CupertinoPageRoute(builder: (context){
                     return AddAddress();
                   }));
                },
                child: Container(
                width: double.infinity,
                height: 50,
                decoration: BoxDecoration( border: Border.all(width:1.0),),
                child: Center(child: Text("+ Add New Address",style: TextStyle(fontSize: 15,fontWeight: FontWeight.bold),),),
                
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              width: double.infinity,
              height: 120,
              decoration: BoxDecoration(border: Border.all(width: 1.0),),
              child: Column(children: [
                Text("Dhikshith"),
                Text("2-47,Lokeshwaram,Near Shivalayam")
              ],),
            ),
          )
        ],
      ),
      );
  }
 }