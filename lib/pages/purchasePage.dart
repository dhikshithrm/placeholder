import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:its12/pages/myAddresses.dart';
import 'package:its12/services/models_Provider.dart';

import 'cart.dart';
class PurchasePage extends StatefulWidget {
  List<ProductC> products;
  PurchasePage({this.products});
  @override
  _PurchasePageState createState() => _PurchasePageState();
}
enum Page{address,order_summary,payment}

class _PurchasePageState extends State<PurchasePage> {
  
  int total=0;
  Page _selectedPage = Page.order_summary;
  @override
  void initState() {
  widget.products.forEach((element){
    setState(() {
      total+=element.price;
    });
    });
    // TODO: implement initState
    super.initState();
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
                              _selectedPage=Page.address;
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
                                     Text("this is the address item has to be delivered"),
                                     
                                     MaterialButton(
                                       onPressed: (){
                                         Navigator.of(context).push(CupertinoPageRoute(builder: (BuildContext context){
                                            return MyAddresses();
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
                            Expanded(child: MaterialButton(onPressed: (){},
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
