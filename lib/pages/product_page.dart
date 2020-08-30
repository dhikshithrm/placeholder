import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:its12/homepage.dart';
import 'package:its12/pages/cart.dart';
import 'package:its12/items/cart_products.dart';
import 'package:its12/services/category_services.dart';
import 'package:its12/services/item_services.dart';
import 'package:its12/services/models_Provider.dart';
import 'package:provider/provider.dart';
import 'package:uuid/uuid.dart';

class ProductDetails extends StatefulWidget {
  final prod_name;
  final prod_new_price;
  final prod_old_price;
  final prod_picture;
  final prod_description;
  final prod_category;
  final bool prod_diffVariants;
  bool like = false; 
  List<Map<String,int>> variants;
  List<Map<String,dynamic>> similar_items;
  String defVariant;
  int qnt = 1;
  String useruid;
  ProductDetails({this.prod_name,
                  this.prod_picture,
                  this.prod_new_price,
                  this.prod_old_price,
                  this.prod_description,
                  this.prod_diffVariants,
                  this.prod_category
                  });

  @override
  _ProductDetailsState createState() => _ProductDetailsState();
}

class _ProductDetailsState extends State<ProductDetails> {
  Future getUser()async{
    FirebaseAuth.instance.currentUser().then((value){setState(() {
      widget.useruid = value.uid;
    });});
    
  }
  @override
  void initState() {
    getUser();
    Item_services().getItemWithName(widget.prod_name).then((value){
      setState(() {
        widget.variants = value.documents[0]["diffVariants"];
        widget.defVariant = value.documents[0]["defVariant"];
      });
    });
    Category_services().getItemsWithCategory(widget.prod_category).then((value){
      setState(() {
        widget.similar_items = value;
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
              IconButton(icon: Icon(widget.like?Icons.favorite:Icons.favorite_border), onPressed: (){
                DocumentReference _users = Firestore.instance.collection("users").document(Provider.of<FirebaseUser>(context).uid);
                setState(() {
                widget.like = !widget.like;
              });
              
               }
              ,color: Color(0xFAB30000),)
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
            child: Text("Delivery Details",style: GoogleFonts.b612(
              fontSize: 32.0,
              fontWeight: FontWeight.bold
            ),),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 5.0),
                  child: Text("*Offers are not valid on chocolates if any.",
                  style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 10.0),
                  child: Text(
                    "*Please order at least 4-5 hours befor ordering cakes and chocolates,1 day befor for personalized products,gifts(teddy's,cases,mugs,pillows,t-shirts,flowers) category",
                    style: TextStyle(fontWeight: FontWeight.bold)
                    ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 10.0),
                  child: Text("*we deliver urgent orders(within two hours) for some products like cakes.\n Please feel free to contact us in contact us section",
                  style: TextStyle(fontWeight: FontWeight.bold)
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 10.0),
                  child: Text("*extra charges may applicable for some products on urgent orders",
                  style: TextStyle(fontWeight: FontWeight.bold)
                  ),
                )
              ],
            )
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
            child: Similar_products(similar_items: widget.similar_items,prod_name: widget.prod_name,),
          )
        ],
      ),
    );
  }
}
class Similar_products extends StatefulWidget {
  List<Map<String,dynamic>>similar_items;
  String prod_name;
  Similar_products({this.similar_items,this.prod_name});
  @override
  _Similar_productsState createState() => _Similar_productsState();
}

class _Similar_productsState extends State<Similar_products> {
  void delProduct(List<Map<String,dynamic>>prod_name){
    prod_name.removeWhere((element) => element['name']==widget.prod_name);
    widget.similar_items = prod_name.sublist(0,4);
  }
  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      primary: false,
      itemCount: widget.similar_items.length>=4?4:widget.similar_items.length,
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
      itemBuilder: (BuildContext context,index){
        delProduct(widget.similar_items);
            return Similar_Singel_prod(
                      prod_name: widget.similar_items[index]['name'],
                      prod_picture: widget.similar_items[index]['imageUrl'],
                      old_price: widget.similar_items[index]['old_price'],
                      price: widget.similar_items[index]['price'],
                        );
         });
  }
}
class Similar_Singel_prod extends StatelessWidget {
  final prod_name;
  final prod_picture;
  final old_price;
  final price;
  Map<String,dynamic> simlar_prod;
  Similar_Singel_prod({this.old_price,this.price,this.prod_name,this.prod_picture});
  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.white,
      elevation: 5.0,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
      child: InkWell(
          onTap: (){
            Item_services().getItemWithName(this.prod_name).then((value){
              Navigator.of(context).push(CupertinoPageRoute(builder: (context) => 
                ProductDetails(prod_name: value.documents[0].data['name'],
                    prod_picture: value.documents[0].data['imageUrl'],
                    prod_new_price: value.documents[0].data['price'],
                    prod_old_price: value.documents[0].data['old_price'],
                    prod_description: value.documents[0].data['description'],
                    prod_diffVariants: value.documents[0].data['customisable'],
                    prod_category: value.documents[0].data['category'],
                )));
                });
             },
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
          child: Image(image: NetworkImage(prod_picture),fit: BoxFit.contain,),
        ),
      ),
    );
  }
 }