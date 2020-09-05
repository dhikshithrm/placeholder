import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:its12/pages/profile.dart';
import 'package:url_launcher/url_launcher.dart';
import '../homepage.dart';
import 'package:flutter/src/painting/box_border.dart';


class CustomerServicepage extends StatefulWidget {
  @override
   _CustomerServicepageState createState() => _CustomerServicepageState();
}

class _CustomerServicepageState extends State<CustomerServicepage> {
  void _launchURL() async {
  const url = 'tel://+918688336248';
  if (await canLaunch(url)) {
    await launch(url);
  } else {
    throw 'Could not launch $url';
  }
}
   @override
   Widget build(BuildContext context){
    return Scaffold(
      appBar: PreferredSize(
             preferredSize: Size.fromHeight(60.0),
            child: AppBar(
          title: Center(
            child: InkWell(
               onTap: () => Navigator.of(context).push(CupertinoPageRoute(builder: (context) => HomePage())),
               child: Image(image: AssetImage('assets/new.png'),
                 width: 105,
                 height: 120,
            ),
          ),
            ),
          backgroundColor: Colors.black,
        ),
      
       
    ),
    body: Container(
      

      child:ListView(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text('Customer Service',
            style: TextStyle(
               fontFamily: 'Montserrat',foreground:Paint()..shader =LinearGradient(colors: [Color(0xFAA80000),Colors.redAccent]).createShader(Rect.fromLTWH(0.0, 0.0, 150.0, 50.0)),fontSize: 30.0,fontWeight: FontWeight.w700,),
            )
            
          ),
          
             Padding(
               padding: const EdgeInsets.all(3.0),
               child: Card(elevation: 5,
                                child: ListTile(
                   title: Text('chat with us',
                   style: TextStyle(
                     fontSize: 25,
                     fontWeight:FontWeight.w400
                   ),),
                 

                 ),
               )
               ),
             Padding(
               padding: const EdgeInsets.all(3.0),
               child:Card(
                 elevation: 5,
                                child: ListTile(
                    onTap: _launchURL,              
                   title: Text('call us',
                   style: TextStyle(
                     fontSize: 25,
                     fontWeight:FontWeight.w400,
                   )
                   ,),
                 

                 ),
               )
               ),  
        Padding(padding: const EdgeInsets.all(15.0),
        child:Text('Need more help? ',
        style: TextStyle(
          fontSize: 25,
          fontWeight: FontWeight.w700,
          fontStyle: FontStyle.italic
        ),)
        ),
       Padding(padding: const EdgeInsets.all(10.0),
       child:Container(
         width: double.infinity,
         child: Column(
           children:[
             Container(
               width:double.infinity,
               decoration: BoxDecoration(
                 borderRadius:BorderRadius.circular(7.0),
                 
               ),
               child:Column(
                 children: [
                   ListTile(
                      leading: Icon(Icons.card_giftcard),
                     title:Text('Your orders',
                     style: TextStyle(
                       fontSize: 20
                     ),
                     ),
                     trailing: Icon(Icons.keyboard_arrow_right),
                   ),
                   Divider(thickness:2.0),
                   ListTile(
                      leading: Icon(Icons.repeat),
                     title:Text('Returns and Refunds',
                     style: TextStyle(
                       fontSize: 20
                     ),
                     ),
                     trailing: Icon(Icons.keyboard_arrow_right),
                   ),
                   Divider(thickness:2.0),
                   ListTile(
                      leading: Icon(Icons.format_line_spacing),
                     title:Text('Transactions',
                     style: TextStyle(
                       fontSize: 20
                     ),
                     ),
                     trailing: Icon(Icons.keyboard_arrow_right),
                   ),
                   Divider(thickness:2.0),
                   ListTile(
                     leading: Icon(Icons.person_pin),
                     title:Text('Account Settings',
                     style: TextStyle(
                       fontSize: 20
                     ),
                     ),
                     onTap:() => Navigator.of(context).push(CupertinoPageRoute(builder: (context) => ProfilePage())),
                     trailing: Icon(Icons.keyboard_arrow_right),
                   ),
                   Divider(thickness:2.0),
                 ],
               )
             )
           ]
         ),
       )) 
      
          
        
        ]
      ),
      
      )
    );
  }
}
