import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:its12/pages/myAddresses.dart';
import 'package:its12/services/models_Provider.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';
import 'package:uuid/uuid.dart';
class PurchasePage extends StatefulWidget {
  String userId;
  List<ProductC> products;
  PurchasePage({this.products,this.userId});
  @override
  _PurchasePageState createState() => _PurchasePageState();
}

class _PurchasePageState extends State<PurchasePage> {
  
  int total=0;
  bool addressComplete=false;
  String defaultAddName='';
  final razorpay = Razorpay();
  @override
  void initState() {
    razorpay.on(Razorpay.EVENT_EXTERNAL_WALLET, externalWallet);
    razorpay.on(Razorpay.EVENT_PAYMENT_SUCCESS, paymentSuccess);
    razorpay.on(Razorpay.EVENT_PAYMENT_ERROR, paymentFailure);
    
  widget.products.forEach((element){
    setState(() {
      total+=element.price;
    });
    });
    FirebaseFirestore.instance.collection("users/${widget.userId}/addresses").get().then((value){
                                      if(value.docs.length!=0){
                                        setState(() {
                                          addressComplete=true;
                                        });
                                        value.docs.forEach((element) {
                                          if(element.data()["isDefault"]==true){
                                            setState(() {
                                              defaultAddName = element.data()["add_name"];
                                            });
                                          }
                                        });
                                        
                                      }
                                    });
                                    print(addressComplete);
    // TODO: implement initState
    super.initState();
  }

  void externalWallet() {
          
          }
        
      void paymentSuccess(PaymentSuccessResponse response) {
          var uuid = Uuid().v4();
          FirebaseFirestore.instance.collection("orders").doc(uuid).set({
            "status": "payment suceess",
            "paymentId": response.paymentId,
            "orderId": uuid,
            "signature": response.signature, 
            "userId": widget.userId,
            "productId": widget.products[0].id,
            "shipping_address": defaultAddName
           });
           Fluttertoast.showToast(msg: "Purchase of ${widget.products[0].name} Success");
           }
    
      void paymentFailure(PaymentFailureResponse response) {
          var uuid = Uuid().v4(); 
          FirebaseFirestore.instance.collection("orders").doc(uuid).set({
            "status": "check out success,payment failed",
            "userId": widget.userId,
            "orderId": uuid,
            "productId": widget.products[0].id,
            "statusCode": response.code,
            "message": response.message
          });
          Fluttertoast.showToast(msg: "${response.code} Purchase Failed ${response.message}");
        }

      getPayment(int amount,String orderName, String orderId, ){
        var option = {
          'key': 'rzp_live_0FNc41rv0ThfLL',
          'amount': amount*100,
          'name': orderName,
          'orderId': orderId,
          'contact': {'contact': '+919515677044','email':'dhikshithreddy12@gmail.com'}
        };
        try {
          razorpay.open(option);
        } catch (e) {
          print('error $e');
        }

      }
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
             child: Container(height: 70,width: double.infinity,decoration: BoxDecoration(border: Border.all(width:1.0),borderRadius: BorderRadius.circular(8.0)),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    height: 45,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children:[
                        SizedBox(
                        width: 20,
                        height: 20,
                        child: GestureDetector(
                          onTap: (){
                            setState(() {
                              
                            });
                          },
                            child: CustomPaint(
                            painter: CirclePainter(),
                                          ),
                                          ),),
                                        Text("Address")
                                          ]
                                        ),
                                      ),
                                      ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    height: 45,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children:[
                        SizedBox(
                        width: 20,
                        height: 20,
                        child: CustomPaint(
                          painter: CirclePainter(),
                                        ),),
                                        Text("Order Summary")
                                          ]
                                        ),
                                      ),
                                      ),Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    height: 45,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children:[
                        SizedBox(
                        width: 20,
                        height: 20,
                        child: CustomPaint(
                          painter: CirclePainter(),
                                        ),),
                                        Text("Payment")
                                          ]
                                        ),
                                      ),
                                      ),
                                  ],),
                                 ),
                               ),
                               Padding(
                                 padding: const EdgeInsets.only(left:8.0,right: 8.0,bottom: 8.0),
                                 child: Container(
                                   decoration: BoxDecoration(color: Colors.black45.withOpacity(0.2),border:  Border.all(width:1.0),borderRadius: BorderRadius.circular(8.0)),
                                   width: double.infinity,
                                   height: 150,
                                   child: Column(
                                     mainAxisAlignment: MainAxisAlignment.end,
                                     children: [
                                    FutureBuilder(
                                    future: FirebaseFirestore.instance.collection("users/${widget.userId}/addresses").get(),
                                    builder: (context, snapshot){
                                      if(snapshot.connectionState==ConnectionState.done){
                                        
                                        return Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          mainAxisAlignment: MainAxisAlignment.start,
                                        children: [
                                            Container(
                                          width: double.infinity,
                                          height: 100,
                                          child: Column(children: [
                                            Expanded(
                                              child: Row(
                                                mainAxisAlignment: MainAxisAlignment.center,
                                                children: [
                                                  Text(addressComplete?"${snapshot.data.docs[0].data()["full_name"]}[${snapshot.data.docs[0].data()["add_name"]}] default":"Add Address",style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),),
                                                  
                                                ],
                                              ),
                                            ),
                                            Expanded(
                                              child: Text(addressComplete?"${snapshot.data.docs[0].data()["houseNoect"]}, ${snapshot.data.docs[0].data()["city"]}, ${snapshot.data.docs[0].data()["extraDetails"]}, ${snapshot.data.docs[0].data()["pincode"]}":""),
                                                ),
                                                Expanded(
                                                  child: Text(addressComplete?"${snapshot.data.docs[0].data()["phone"]}":""),
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
                                                              
                                     MaterialButton(
                                       onPressed: (){
                                         Navigator.of(context).push(CupertinoPageRoute(builder: (BuildContext context){
                                            return MyAddresses(widget.userId,addressComplete: addressComplete,);
                                         }));
                                                  // var orderId = Uuid().v4();
                                                  // getPayment(widget.prod_new_price, "its12order "+ widget.prod_name, orderId);
                                                },
                                      color: Color(0xFAB30000),
                                      textColor: Colors.white,
                                      elevation: 0.2,
                                      child: Text("Change or Add Address"),
                                    ),
                                   ],
                                   )
                                   
                                 ),
                               ),
                               Padding(
                                 padding: const EdgeInsets.only(left:8.0,right: 8.0,bottom: 8.0),
                                 child: Container(
                                   decoration: BoxDecoration(color: Colors.black45.withOpacity(0.2),border:  Border.all(width:1.0),borderRadius: BorderRadius.circular(8.0)),
                                   width: double.infinity,
                                   height: 150,
                                   child: Row(
                                     crossAxisAlignment: CrossAxisAlignment.start,
                                     children: [
                                       Column(children: [
                                         Padding(
                                               padding: const EdgeInsets.only(left:8.0,top: 8.0),
                                               child: Container(child: Text(widget.products[0].name,style:TextStyle(fontSize: 16,fontWeight: FontWeight.bold),overflow: TextOverflow.ellipsis,),width: MediaQuery.of(context).size.width*(2/3),),
                                             ),
                                        Padding(
                                               padding: const EdgeInsets.only(left:8.0,top: 8.0),
                                               child: Container(child: Text("₹${widget.products[0].price}",style:TextStyle(fontSize: 16,fontWeight: FontWeight.bold),overflow: TextOverflow.ellipsis,),width: MediaQuery.of(context).size.width*(2/3),),
                                             ),
                                       ],
                                       ),
                                       Column(
                                         children: [
                                           Padding(
                                               padding: const EdgeInsets.only(top:8.0),
                                               child: Image(image: NetworkImage(widget.products[0].imageUrl),width: MediaQuery.of(context).size.width*(1/4),height: 100,),
                                             ),
                                            
                                         ],
                                       )
                                     ],
                                   )
                                   
                                 ),
                               ),
                               
                              
                            ]
                          ),
                          bottomNavigationBar: Container(
                        color: Colors.white,
                        child: Row(
                          children: <Widget>[
                            Expanded(child: ListTile(
                              title: Text("Total:"),
                              subtitle: Text("₹$total"),
                            ),),
                            Expanded(child: MaterialButton(onPressed: (){
                              if(addressComplete){
                                var orderId = Uuid().v4();
                                FirebaseFirestore.instance.collection("orders").doc(orderId).set({
                                  "status":"initiated and address added",
                                  "userId": widget.userId,
                                  "productIds": widget.products[0].id
                                }).then((value){
                                  getPayment(total, widget.products.map((e) => e.name).join(), orderId);
                                });
                              }else{
                                Fluttertoast.showToast(msg: "Add Address");
                              }
                            },
                            color: Color(0xFAB30000),
                            child: Text("Check Out",style: TextStyle(color: Colors.white,),),
                            ),  
                            ),
                            SizedBox(width:10.0)
                          ],
                        ),
                      ),
                     );
                    }
                   }
                    
class CirclePainter extends CustomPainter {
  final _paint = Paint()
    ..color = Color(0xFAB30000)
    ..strokeWidth = 2
    // Use [PaintingStyle.fill] if you want the circle to be filled.
    ..style = PaintingStyle.stroke;

  @override
  void paint(Canvas canvas, Size size) {
    canvas.drawOval(
      Rect.fromLTWH(0, 0, size.width, size.height),
      _paint,
    );
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;
}
