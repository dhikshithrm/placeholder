import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:its12/pages/product_page.dart';

class Singel_prod extends StatelessWidget {
  final prod_name;
  final prod_picture;
  final old_price;
  final price;
  final description;

  Singel_prod({this.old_price,this.price,this.prod_name,this.prod_picture,this.description});
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Card(
          color: Colors.white,
          elevation: 5.0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10.0)
          ),
          child: InkWell(
              onTap: ()=> Navigator.of(context).push(CupertinoPageRoute(builder: (context) => ProductDetails(prod_name: prod_name,
                  prod_picture: prod_picture,
                  prod_new_price: price,
                  prod_old_price: old_price,
                  prod_description: description,
              ),)),
              child: GridTile(
              footer: Container(
                color: Colors.white,
                child: Padding(
                  padding: const EdgeInsets.all(3.0),
                  child: Column(
                    children: <Widget>[
                      Text(
                        prod_name,style: TextStyle(fontWeight: FontWeight.bold),
                        overflow: TextOverflow.ellipsis,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Text("₹$old_price",style: TextStyle(
                            fontWeight: FontWeight.w400,
                            color: Color(0xFAB30000),decoration: TextDecoration.lineThrough
                           ),
                          ),
                          SizedBox(width: 5.0,),
                          Text(price.runtimeType == int?"$price":"$price['500g']",
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.black54,
                          ),
                         ),
                        ],
                      )
                    ],
                  ),
                ),
              ),
              child:Image(image: NetworkImage(prod_picture),fit: BoxFit.contain,)
            ),
          ),
      ),
    );
  }
 }