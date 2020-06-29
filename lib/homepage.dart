import 'package:carousel_pro/carousel_pro.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter/widgets.dart';
import 'package:its12/items/item_class.dart';
class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int photoIndex = 0;
  static List photos = [
    'assets/images/bouquets.png',
    'assets/images/cakes.png',
    'assets/images/gifts.png',
    'assets/images/teddys.png',
    'assets/images/watches.png',
    'assets/images/bouquets.png',
    'assets/images/cakes.png',
    'assets/images/gifts.png',
    'assets/images/teddys.png',
    'assets/images/watches.png',];

  List<String> tile = ['Home','Shop By Category','Your Orders','Wishlist','Best Sellers','My Coupons','Profile','Sign Out','About Us','Contact Us'
  ,'Customer Service',
  ];

  void nextSet(){
    setState(() {if (photoIndex == 0 || photoIndex == 5){ photoIndex++;}
      photoIndex= (photoIndex+1)%6;
    });
  }

  void prevSet(){
    setState(() {if (photoIndex == 0 ||photoIndex == 5 ){ photoIndex--;}
      photoIndex = (photoIndex-1)%6;
    });
  }
  
    Widget _myAnimatedWidget(BuildContext context, {key}){
      return Container(
       key: ValueKey(photoIndex), 
       color: Colors.white,
       height: 71.5,
        child: Row(
        children: photos.sublist(photoIndex,photoIndex+3).map((e) => Container(
        child: Image.asset('$e',width:MediaQuery.of(context).size.width/3 - 32.0,)
         )).toList()                 
         )
        );
    }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: Drawer(
        child: ListView(
          children: <Widget>[
            Container(
              height: 78.0,
              decoration: BoxDecoration(
                gradient: LinearGradient(colors: [Color(0xFAA80000),Colors.redAccent])
              ),
              padding: EdgeInsets.fromLTRB(0.0, 13.0, 0.0, 8.0),
              child: ListTile(
                title: Text('Hello,Dhikshith',
                style: GoogleFonts.lato(
                        textStyle: Theme.of(context).textTheme.display1,
                        fontSize: 22,
                        fontWeight: FontWeight.w700,
                        fontStyle: FontStyle.italic,
                      ),
                    ),
                    leading:
                        CircleAvatar(
                        radius: 30.0,
                        backgroundColor: Colors.black,
                        child: Text('DR',
                          style: TextStyle(
                            color: Colors.orangeAccent
                            ),
                           ),
                         ),
                       ),
                      ),
                      Container(
                        // decoration: BoxDecoration(
                        //   image: DecorationImage(image: AssetImage('assets/images/tilebg.jpg'),fit: BoxFit.fitHeight)
                        // ),
                        child: Column(
                         children: tile.map((e) => Padding(
                           padding: const EdgeInsets.fromLTRB(0.0,4.5,0.0,4.5),
                           child: ListTile(
                              onTap: (){},
                              title: Text('$e',
                              style: GoogleFonts.cabin(
                                textStyle: Theme.of(context).textTheme.display1,
                                fontSize: 20,
                                // color: Colors.white70,
                                fontWeight: FontWeight.w500,
                              )
                              )
                             ),
                           ),
                         ).toList())
                        )
                      ],
                     )
                    ),
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
        height: 200,
        child: Carousel(
          animationCurve: Curves.elasticIn,
          autoplay: false,
          overlayShadow: false,
          dotBgColor: Colors.transparent,
          indicatorBgPadding: 5.0,
          dotSize: 3.5,
          images: [Container(
            width:MediaQuery.of(context).size.width,
            height: 200.0,
            decoration: BoxDecoration(
              image: DecorationImage(fit: BoxFit.fill,image: AssetImage('assets/jns2.jpg'))
            ),
           ),
           Stack(
              children:<Widget>[ Container(
              width:MediaQuery.of(context).size.width,
              height: 200.0,
              decoration: BoxDecoration(
                image: DecorationImage(fit: BoxFit.fill,image: AssetImage('assets/images/gift.jpg')), 
              ),
             ),
             Text(' Free \n Delivery \n On \n All \n Products',
             style: TextStyle(fontFamily: 'Montserrat',foreground:Paint()..shader = LinearGradient(colors: [Colors.blueAccent[400],Colors.black.withOpacity(0.556)]).createShader(Rect.fromLTWH(0.0, 0.0, 150.0, 50.0)),fontSize: 30.0,fontWeight: FontWeight.w600,),
             )
            ]
           ),
           Container(
            width:MediaQuery.of(context).size.width,
            height: 200.0,
            decoration: BoxDecoration(
              image: DecorationImage(fit: BoxFit.fill,image: NetworkImage("https://images.unsplash.com/photo-1464349153735-7db50ed83c84?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=500&q=60"))
            ),
           ),
           Container(
            width:MediaQuery.of(context).size.width,
            height: 200.0,
            decoration: BoxDecoration(
              image: DecorationImage(fit: BoxFit.fill,image: NetworkImage("https://images.unsplash.com/photo-1565608444338-315d5fbaeb5e?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=1355&q=80"))
            ),
           ),
          ]
          )
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Container(
               height: 71.5,
               color: Colors.white,
               child: IconButton(icon: Icon(Icons.arrow_left),
               onPressed: prevSet,splashColor: Colors.transparent)
              ),
            AnimatedSwitcher(
              // transitionBuilder: ,
              duration: Duration(milliseconds: 400),
                child: _myAnimatedWidget(context)
            ),
             Container(
              height: 71.5,
              color: Colors.white,
              child: IconButton(icon:Icon(Icons.arrow_right),
              onPressed: nextSet,splashColor: Colors.transparent)
             )
            ]
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text("They Might Love",
            style: GoogleFonts.lobster(
              fontSize: 20.0,
              fontWeight: FontWeight.w400
             ),
            ),
          ),
         Container(
           height: 380,
           child: Items(),
         ),
       ]
      )
    );
  }
}


