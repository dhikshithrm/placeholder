
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:google_fonts/google_fonts.dart';
import '../homepage.dart';


class AboutUspage extends StatefulWidget {
  
    @override
     _AboutUspageState createState() => _AboutUspageState();
  
     
}

class _AboutUspageState extends State<AboutUspage> {
  

   

   @override
   Widget build(BuildContext context){
    return Scaffold( appBar: PreferredSize(
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
      child:Column(
        mainAxisAlignment: MainAxisAlignment.start,
      
          children:[Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text('About Us',
            style:TextStyle(
              fontFamily: 'Montserrat',foreground:Paint()..shader =LinearGradient(colors: [Color(0xFAA80000),Colors.redAccent]).createShader(Rect.fromLTWH(0.0, 0.0, 150.0, 50.0)),fontSize: 30.0,fontWeight: FontWeight.w600,),           ),
        ),
          
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Image(image: AssetImage('assets/images/us.jpg')),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text('Who We Are',
            style: GoogleFonts.lato(
                        fontSize:25,
                        fontWeight: FontWeight.w700,
                        fontStyle: FontStyle.italic,)
          ),           
          ) ,              
           Padding(padding:const EdgeInsets.all(10.0),
           child:
           Text('          We are a Group of friends launched this \nstartup to deliver a joy of surprise to our customers\n      when the day actually starts @ 12AM.',
           style: TextStyle(
             fontSize: 15,
             fontWeight: FontWeight.w400,
             fontFamily: 'Quicksand'
           ),),
           
           )  ,
           Padding(padding:const EdgeInsets.all(10.0),
           child:
           Text('         We as a team aimed to provide our valued customers an outstanding platform to gift their loved\n              ones at their desired time.',
           style: TextStyle(
             fontSize: 15,
             fontWeight: FontWeight.w400,
              fontFamily: 'Quicksand'
           ),),
           
           )                            
      
          
          ]
                )
          
            ),
            );
          }
         }
        

