import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:url_launcher/url_launcher.dart';
import '../homepage.dart';


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
            padding: const EdgeInsets.all(10),
            child: Text('Customer Service',
            style: TextStyle(
              fontSize:30,
              fontWeight: FontWeight.w700
            )
            ),
          ),
          
             Padding(
               padding: const EdgeInsets.all(5.0),
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
               padding: const EdgeInsets.all(5.0),
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
             
          
          
        ],
      
      )
      )
    );
  }
}
