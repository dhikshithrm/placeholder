import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:its12/pages/addNewAddress.dart';

import 'package:flutter/material.dart';
class MyAddresses extends StatefulWidget {
  bool addressComplete;
  String userId;
  MyAddresses(this.userId,{this.addressComplete});
  @override
  _MyAddressesState createState() => _MyAddressesState();
}

class _MyAddressesState extends State<MyAddresses> {
  @override
  void initState() { 
    super.initState();
    FirebaseFirestore.instance.collection("users/${widget.userId}/addresses").get().then((value){
      if(value.docs.length!=0){
        setState(() {
          widget.addressComplete = true;
        });
      }

    });
  }
 bool isDefault=false;
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
        //        IconButton(
        //          icon: Icon(Icons.shopping_cart,
        //        color: Colors.white,
        //       ),
        //     onPressed: (){
        //        Navigator.push(context, CupertinoPageRoute(builder: (context)=> Cart()));
        //     }
        //  )
        ],
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: GestureDetector(
                onTap: (){
                   Navigator.of(context).push(CupertinoPageRoute(builder: (context){
                     return AddAddress(userid: widget.userId,);
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
            child: FutureBuilder(
              future: FirebaseFirestore.instance.collection("users/${widget.userId}/addresses").get(),
              builder: (context, snapshot){
                if(snapshot.connectionState==ConnectionState.done){
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Container(
                    width: double.infinity,
                    height: 120,
                    decoration: BoxDecoration(border: Border.all(width: 1.0),),
                    child: Column(children: [
                      Expanded(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(widget.addressComplete?"${snapshot.data.docs[0].data()["full_name"]}[${snapshot.data.docs[0].data()["add_name"]}] default":"",style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),),
                            Visibility(
                              visible: widget.addressComplete,
                              child: Switch(value: isDefault, onChanged: (b)async{
                                if(b){
                                  setState(() {
                                    isDefault=b;
                                  });
                                  await Future.delayed(Duration(milliseconds: 200));
                                  FirebaseFirestore.instance.doc("users/${widget.userId}/addresses/${snapshot.data.docs[0].data()["add_name"]}").update({
                                    "isDefault": true
                                  });
                                }
                              }),
                            )
                          ],
                        ),
                      ),
                      Expanded(
                        child: Text(widget.addressComplete?"${snapshot.data.docs[0].data()["houseNoect"]}, ${snapshot.data.docs[0].data()["city"]}, ${snapshot.data.docs[0].data()["extraDetails"]}, ${snapshot.data.docs[0].data()["pincode"]}":""),
                      ),
                      Expanded(
                        child: Text(widget.addressComplete?"${snapshot.data.docs[0].data()["phone"]}":""),
                      )
                    ],),
                    ),
                  ],
                );
                }
                else{
                  return CircularProgressIndicator();
                }
              },
            ),
          )
        ],
      ),
      );
  }
}