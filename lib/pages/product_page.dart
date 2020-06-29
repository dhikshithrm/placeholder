import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:its12/homepage.dart';
import 'package:its12/pages/cart.dart';
import 'package:its12/items/cart_products.dart';

class ProductDetails extends StatefulWidget {
  final prod_name;
  final prod_new_price;
  final prod_old_price;
  final prod_picture;
  bool like = false;
  int qnt = 1;
  ProductDetails({this.prod_name,
                  this.prod_picture,
                  this.prod_new_price,
                  this.prod_old_price
                  });

  @override
  _ProductDetailsState createState() => _ProductDetailsState();
}

class _ProductDetailsState extends State<ProductDetails> {
  
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
                  onPressed: (){}
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
      body: ListView(
        shrinkWrap: true,
        children: <Widget>[
          Container(
            height: 300.0,
            child: GridTile(
              child: Container(
                color: Colors.white70,
                child: Image.asset(widget.prod_picture,),
              ),
              footer: Container(
                color: Colors.white70,
                child: ListTile(
                  leading: Text(widget.prod_name,style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 15.0,
                  ),),
                  title: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                       Text("₹${widget.prod_old_price}",style: TextStyle(
                        color: Color(0xFAB30000),decoration: TextDecoration.lineThrough
                      ),),
                      SizedBox(width:10.0),
                      Text("₹${widget.prod_new_price}",),
                    ],
                  ),
                ),
              ),  
            ),
          ),
          Row(
            children: <Widget>[
                Expanded(
                     child: MaterialButton(onPressed: (){
                      showDialog(context: context,builder: 
                      (context){
                        return AlertDialog(
                          title: Text("Size"),
                          content: Text("Choose The Size"),
                          actions: <Widget>[
                            MaterialButton(
                              onPressed: (){
                                Navigator.of(context).pop();
                              },
                              child:  Text("close"),
                             )
                          ],
                        );
                      }
                      );
                    },
                    color: Colors.white,
                    textColor: Colors.grey,
                     elevation: 0.2,
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                        Expanded(child: Text("Size")),
                        Expanded(child: Icon(Icons.arrow_drop_down)),
                      ],
                    ),
                    ),
                ),
                  Expanded(
                   child: MaterialButton(onPressed: (){
                      showDialog(context: context,builder: 
                      (context){
                        return AlertDialog(
                          title: Text("Color"),
                          content: Text("Choose The Color"),
                          actions: <Widget>[
                            MaterialButton(
                              onPressed: (){
                                Navigator.of(context).pop();
                              },
                              child:  Text("close"),
                             )
                          ],
                        );
                      }
                      );
                  },
                  color: Colors.white,
                  textColor: Colors.grey,
                     elevation: 0.2,
                  child: Row(
                      children: <Widget>[
                        Expanded(child: Text("Color")),
                        Expanded(child: Icon(Icons.arrow_drop_down),)
                      ],
                  ),
                  ),
                   ),
              Expanded(
                child: MaterialButton(onPressed: (){
                      showDialog(context: context,builder: 
                      (context){
                        return AlertDialog(
                          title: Text("Quantity"),
                          content: Container(
                            height: 150,
                            child: Column(
                              children: <Widget>[
                                IconButton(icon: Icon(Icons.arrow_drop_up), onPressed: (){
                                  setState(() {
                                    widget.qnt++;
                                  });
                                }),
                                IconButton(icon: Icon(Icons.arrow_drop_down), onPressed: (){
                                  if(widget.qnt>0){
                                  setState(() {
                                    widget.qnt--;
                                  });
                                  }
                                }),
                              ],
                            ),
                          ),
                          actions: <Widget>[
                            MaterialButton(
                              onPressed: (){
                                Navigator.of(context).pop();
                              },
                              child:  Text("close"),
                             )
                          ],
                        );
                      }
                    );
                },
                color: Colors.white,
                textColor: Colors.grey,
                 elevation: 0.2,
                child: Row(
                  children: <Widget>[
                     Text("Qunt ${widget.qnt}"),
                     Icon(Icons.arrow_drop_down),
                  ],
                ),
                ),
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: <Widget>[
              SizedBox(width: 8.0),
              Expanded(child: MaterialButton(
                onPressed: (){},
                color: Color(0xFAB30000),
                textColor: Colors.white,
                elevation: 0.2,
                child: Text("Buy Now"),
                ),
              ),
              IconButton(icon: Icon(Icons.add_shopping_cart), onPressed: (){
                setState(() {
                  
                });
              },color: Color(0xFAB30000),),
              IconButton(icon: Icon(widget.like?Icons.favorite:Icons.favorite_border), onPressed: (){setState(() {
                widget.like = !widget.like;
              });},color: Color(0xFAB30000),)
            ],
          ),
          Divider(thickness: 2.0,),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text("Product Details",style: GoogleFonts.b612(
              fontSize: 32.0,
              fontWeight: FontWeight.bold
            ),),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text("It is a long established fact that a reader will be distracted by the readable content of a page when looking at its layout. The point of using Lorem Ipsum is that it has a more-or-less normal distribution of letters, as opposed to using 'Content here, content here', making it look like readable English. Many desktop publishing packages and web page editors now use Lorem Ipsum as their default model text, and a search for 'lorem ipsum' will uncover many web sites still in their infancy. Various versions have evolved over the years, sometimes by accident, sometimes on purpose (injected humour and the like)."),
          ),
          Divider(thickness: 2.0,),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text("Similar Products",style: GoogleFonts.b612(
              fontSize: 32.0,
              fontWeight: FontWeight.bold
            ),),),
          Container(
            height: 350.0,
            child: Similar_products(),
          )
        ],
      ),
    );
  }
}
class Similar_products extends StatefulWidget {
  @override
  _Similar_productsState createState() => _Similar_productsState();
}

class _Similar_productsState extends State<Similar_products> {
  var item_list = [
   {
     "name":"Butterscotch Cake(Eggless)",
     "picture": "assets/Products/cakes2.jpg",
     "old_price": 399,
     "price": 339,
   },
   {
     "name":"Flower Bouquet",
     "picture": "assets/Products/flowerbouquet.jpg",
     "old_price": 450,
     "price": 399
   },
   {
     "name":"Chocolate",
     "picture": "assets/Products/silkoreo.jpg",
     "old_price": 450,
     "price": 399
   },
   {
     "name":"Customized Printed t-shirt",
     "picture": "assets/Products/tshirt.jpg",
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
        return Similar_Singel_prod(
          prod_name: item_list[index]['name'],
          prod_picture: item_list[index]['picture'],
          old_price: item_list[index]['old_price'],
          price: item_list[index]['price'],
        );
      });
  }
}
class Similar_Singel_prod extends StatelessWidget {
  final prod_name;
  final prod_picture;
  final old_price;
  final price;

  Similar_Singel_prod({this.old_price,this.price,this.prod_name,this.prod_picture});
  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.white,
      elevation: 5.0,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
      child: InkWell(
          onTap: ()=> Navigator.of(context).push(CupertinoPageRoute(builder: (context) => ProductDetails(prod_name: prod_name,
          prod_picture: prod_picture,
          prod_new_price: price,
          prod_old_price: old_price,
          ),)),
          child: GridTile(
          footer: Container(
            color: Colors.white,
            child: Padding(
              padding: const EdgeInsets.all(3.0),
              child: Column(
                children: <Widget>[
                  Text(prod_name,style: TextStyle(fontWeight: FontWeight.bold),
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
                      Text("₹$price",style: TextStyle(
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
          child: Image(image: AssetImage(
            prod_picture,
          ),fit: BoxFit.contain,),
        ),
      ),
    );
  }
 }