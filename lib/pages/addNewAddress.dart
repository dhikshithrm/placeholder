import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'cart.dart';
class AddAddress extends StatefulWidget {
  @override
  _AddAddressState createState() => _AddAddressState();
}

class _AddAddressState extends State<AddAddress> {
  TextEditingController _nameController = TextEditingController();
   final GlobalKey<FormState> _formkey = GlobalKey<FormState>();
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
      body: Column(children: [
        Form(
            key: _formkey,
           child: SingleChildScrollView(
               child: Column(
               children: <Widget>[
                 Padding(
                   padding: const EdgeInsets.fromLTRB(15.0,10.0,15.0,0.0),
                   child: TextFormField(
                     inputFormatters: <TextInputFormatter>[WhitelistingTextInputFormatter.digitsOnly],
                     keyboardType: TextInputType.number,
                     decoration: InputDecoration(
                       border:OutlineInputBorder(),
                       hintText: 'Old Price',
                       labelStyle: TextStyle(
                         color: Colors.black
                       ),
                     ),
                     validator: (value){
                   if(value.runtimeType != int && value.isEmpty){
                     return 'It Must Be an Integer And Not Null';
                   }
                   return null;
                 },
                     onSaved: (value){
                       setState(() {
                         
                       });
                     },
                   ),
                 ),
                 Padding(
               padding: const EdgeInsets.fromLTRB(15.0,10.0,15.0,0.0),
               child: TextFormField(
                 keyboardType: TextInputType.number,
                 inputFormatters: <TextInputFormatter>[WhitelistingTextInputFormatter.digitsOnly],
                 decoration: InputDecoration(
                   border:OutlineInputBorder(),
                   hintText: 'New Price',
                   labelStyle: TextStyle(
                     color: Colors.black
                   ),
                 ),
                 validator: (value){
                   if(value.runtimeType != int && value.isEmpty){
                     return 'It Must Be an Integer And Not Null';
                   }
                   return null;
                 },
                 onSaved: (value){
                   setState(() {
                     
                      });
                    },
                  ),
                ),

               ],
             ),
           ),
         ),
         Form(
           child: Padding(
             padding: const EdgeInsets.fromLTRB(15.0,10.0,15.0,0.0),
             child: TextFormField(
               maxLines:  10,
               keyboardType: TextInputType.multiline,
               controller: _nameController,
               decoration: InputDecoration(
                 border:OutlineInputBorder(),
                 hintText: 'Description',
                 labelStyle: TextStyle(
                   color: Colors.black
                 ),
               ),
               validator: (value){
                 if(value.isEmpty){
                   return 'Enter Some Text';
                 }
                 return null;
               },
             ),
           ),
         ),
      ],),
      );
  }
}