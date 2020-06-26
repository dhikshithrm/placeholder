import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:its12/pages/product_page.dart';
class Items extends StatefulWidget {
  @override
  _ItemsState createState() => _ItemsState();
}

class _ItemsState extends State<Items> {
  var item_list = [
   {
     "name":"Heart Cake(Eggless)",
     "picture": "assets/Products/cakes1.jpg",
     "old_price": 399,
     "price": 359,
   },
   {
     "name":"Butterscotch Cake(Eggless)",
     "picture": "assets/Products/cakes2.jpg",
     "old_price": 399,
     "price": 339,
   },
   {
     "name":"Customized Printed Pillow",
     "picture": "assets/Products/pillow.jpg",
     "old_price": 450,
     "price": 399,
   },
   {
     "name":"Customized Printed Pillow",
     "picture": "assets/Products/pillow.jpg",
     "old_price": 450,
     "price": 399
   },
  ];
  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      primary: true,
      itemCount: item_list.length,
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
      itemBuilder: (BuildContext context,index){
        return Singel_prod(
          prod_name: item_list[index]['name'],
          prod_picture: item_list[index]['picture'],
          old_price: item_list[index]['old_price'],
          price: item_list[index]['price'],
        );
      });
  }
}

class Singel_prod extends StatelessWidget {
  final prod_name;
  final prod_picture;
  final old_price;
  final price;

  Singel_prod({this.old_price,this.price,this.prod_name,this.prod_picture});
  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.white,
      elevation: 5.0,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
      child: InkWell(
          onTap: ()=> Navigator.of(context).push(MaterialPageRoute(builder: (context) => ProductDetails())),
          child: GridTile(
          footer: Container(
            color: Colors.white,
            child: Padding(
              padding: const EdgeInsets.all(3.0),
              child: Column(
                children: <Widget>[
                  Text(prod_name,maxLines: 1,style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Text("₹$old_price",style: TextStyle(
                        fontWeight: FontWeight.w400,
                        color: Colors.red,decoration: TextDecoration.lineThrough
                       ),
                      ),
                      SizedBox(width: 5.0,),
                      Text("₹$price",style: TextStyle(
                        fontWeight: FontWeight.w400,
                        color: Colors.black54,
                      ),
                     ),
                    ],
                  )
                ],
              ),
            ),
          ),
          child: Image(image: AssetImage(
            prod_picture,
          ),fit: BoxFit.contain,),
        ),
      ),
    );
  }
 }