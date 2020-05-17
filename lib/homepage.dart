
import 'package:carousel_pro/carousel_pro.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter/widgets.dart';
class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int photoIndex = 0;

  List<String> photos = [
    'assets/images/bouquets.png',
    'assets/images/cakes.png',
    'assets/images/gifts.png',
    'assets/images/teddys.png',
    'assets/images/watches.png'
  ];

  void nextSet(){
    setState(() {
      photoIndex= (photoIndex+1)%3;
    });
  }

  void prevSet(){
    setState(() {
      photoIndex = photoIndex>0?photoIndex-1:photoIndex+1;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: Drawer(
        child: ListView(
          children: <Widget>[
            Container(
              height: 84.0,
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
          dotSize: 5.0,
          images: [Container(
            width:MediaQuery.of(context).size.width,
            height: 200.0,
            decoration: BoxDecoration(
              image: DecorationImage(fit: BoxFit.fill,image: AssetImage('assets/jns1.jpg'))
            ),
           ),
           Stack(
              children:<Widget>[ Container(
              width:MediaQuery.of(context).size.width,
              height: 200.0,
              decoration: BoxDecoration(
                image: DecorationImage(fit: BoxFit.fill,image: AssetImage('assets/gift.jpg')),
              ),
             ),
             Text(' Free \n Delivery \n On \n All \n Products',
             style: TextStyle(fontFamily: 'Montserrat',fontSize: 30.0,fontWeight: FontWeight.w600,color: Colors.black.withOpacity(0.556)),
             )
            ]
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
             child: IconButton(icon: Icon(Icons.arrow_left), onPressed: prevSet,splashColor: Colors.transparent)
            ),
          Container(
            height: 71.5,
            child: Row(
              children: photos.sublist(photoIndex,photoIndex+3).map((e) => Container(
              child: Image.asset('$e',width:MediaQuery.of(context).size.width/3 - 32.0,)
              )).toList()                 
              )
            ),
           Container(
            height: 71.5,
            color: Colors.white,
            child: IconButton(icon:Icon(Icons.arrow_right), onPressed: nextSet,splashColor: Colors.transparent)
           )
          ]
        )
       ]
      )
    );
  }
}
