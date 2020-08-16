import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:its12/homepage.dart';
import 'package:its12/pages/cart.dart';
import 'package:its12/items/cart_products.dart';
import 'package:its12/services/item_services.dart';

class ProductDetails extends StatefulWidget {
  final prod_name;
  final prod_new_price;
  final prod_old_price;
  final prod_picture;
  final prod_description;
  final bool prod_diffVariants;
  bool like = false; 
  List<Map<String,int>> variants;
  String defVariant;
  int qnt = 1;
  ProductDetails({this.prod_name,
                  this.prod_picture,
                  this.prod_new_price,
                  this.prod_old_price,
                  this.prod_description,
                  this.prod_diffVariants
                  });

  @override
  _ProductDetailsState createState() => _ProductDetailsState();
}

class _ProductDetailsState extends State<ProductDetails> {
 
  @override
  void initState() {
    Item_services().getItemWithName(widget.prod_name).then((value){
      setState(() {
        widget.variants = value.documents[0]["diffVariants"];
        widget.defVariant = value.documents[0]["defVariant"];
      });
    });
    print(widget.defVariant);
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
                child: Image.network(widget.prod_picture,),
              ),
              footer: Container(
                color: Colors.white70,
                child: Column(
                  children: <Widget>[
                      Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(widget.prod_name,
                          style: TextStyle(
                            fontSize: 18.0,
                          ),
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Text("₹${widget.prod_old_price}",
                        style: TextStyle(
                          decoration: TextDecoration.lineThrough,
                          color: Colors.red,
                          fontSize: 18,
                        ),
                        ),
                        SizedBox(width:10),
                        Text("₹${widget.prod_new_price}",
                        style: TextStyle(
                          fontSize: 18,
                        ),
                        )
                      ],
                    )
                  ],
                ),
              ),  
            ),
          ),
          Visibility(
            visible: widget.prod_diffVariants,
            child: Padding(padding: EdgeInsets.all(15.0),
            child: GestureDetector(
              onTap: () {
                showDialog(context: context,builder: (BuildContext context){
                      return Dialog(
                        shape: RoundedRectangleBorder(
                            borderRadius:
                                BorderRadius.circular(7.0)), //this right here
                        child: Container(
                          height: 350,
                          child:  Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Container(
                                  height: 50,
                                  width: double.infinity,
                                  decoration: BoxDecoration(
                                    color: Color(0xFAB30000),
                                    borderRadius: BorderRadius.only(topLeft: Radius.circular(7.0),topRight: Radius.circular(7.0))
                                  ),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                                    children: <Widget>[
                                      Text("Choose Variant",style: TextStyle(fontSize: 22),),
                                      IconButton(icon: Icon(Icons.cancel), onPressed: (){Navigator.of(context).pop();},splashColor: Colors.transparent,)
                                    ],
                                     ),
                                    ),
                                    
                                  ],
                                ),
                              ),
                          );
                        });
                      },
                 child: Container(
                decoration: BoxDecoration(
                color: Colors.black12,  
                border: Border.all(width:1.0,color:Colors.black38),
                borderRadius: BorderRadius.circular(7.0)
                ),
                child: ListTile(
                  title: Text(widget.defVariant??"1/2KG",style:TextStyle(fontSize: 18.0)),
                  subtitle: Text(widget.prod_name,overflow: TextOverflow.ellipsis,),
                  trailing: Icon(Icons.navigate_next,size: 40.0,),
                )
              ),
            ),
            ),
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
            child: Text(widget.prod_description)
          ),
          Divider(thickness: 2.0,),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text("Similar Products",style: GoogleFonts.b612(
              fontSize: 32.0,
              fontWeight: FontWeight.bold
            ),),),
          Container(
            height: 500,
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
      primary: false,
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