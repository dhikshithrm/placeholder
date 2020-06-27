import 'package:flutter/material.dart';

class ProductDetails extends StatefulWidget {
  final prod_name;
  final prod_new_price;
  final prod_old_price;
  final prod_picture;
  bool like = false;

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
              title: Image(image: AssetImage('assets/new.png'),
                width: 105,
                height: 110,
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
            onPressed: (){}
         )
        ],
      ),
      body: ListView(
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
                        color: Colors.red,decoration: TextDecoration.lineThrough
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
                child: MaterialButton(onPressed: (){},
                color: Colors.white,
                textColor: Colors.grey,
                 elevation: 0.2,
                child: Row(
                  children: <Widget>[
                    Expanded(child: Text("Size")),
                    Expanded(child: Icon(Icons.arrow_drop_down),)
                  ],
                ),
                ),
              ),
              Expanded(
                child: MaterialButton(onPressed: (){},
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
                child: MaterialButton(onPressed: (){},
                color: Colors.white,
                textColor: Colors.grey,
                 elevation: 0.2,
                child: Row(
                  children: <Widget>[
                    Expanded(child: Text("Quantity",maxLines: 1,)),
                    Expanded(child: Icon(Icons.arrow_drop_down),)
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
                color: Colors.red,
                textColor: Colors.white,
                elevation: 0.2,
                child: Text("Buy Now"),
                ),
              ),
              IconButton(icon: Icon(Icons.add_shopping_cart), onPressed: (){},color: Colors.red,),
              IconButton(icon: Icon(widget.like?Icons.favorite:Icons.favorite_border), onPressed: (){setState(() {
                widget.like = !widget.like;
              });},color: Colors.red,)
            ],
          )
        ],
      ),
    );
  }
}