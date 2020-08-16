import 'package:flutter/material.dart';
class Profilepage extends StatefulWidget {
  String name;
  String photoUrl;
  String email;
  Profilepage({
    this.email,this.name,this.photoUrl
  });
  @override
  _ProfilepageState createState() => _ProfilepageState();
}

class _ProfilepageState extends State<Profilepage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
             preferredSize: Size.fromHeight(60.0),
            child: AppBar(
          title: Center(
               child: Image(image: AssetImage('assets/new.png'),
                 width: 105,
                 height: 120,
            ),
          ),
          backgroundColor: Colors.black,
        )
       ),
       body: SingleChildScrollView(
         child: Column(
           children: [
             Padding(
               padding: const EdgeInsets.all(8.0),
               child:
                    Container(
                   height: 300,
                   width: 300,
                   child: CircleAvatar(
                     backgroundColor: Colors.deepOrange[600],
                     backgroundImage: NetworkImage(widget.photoUrl),
                   )
                 ),
             ),
             Padding(
               padding: EdgeInsets.fromLTRB(15.0,0.0,15.0,15.0),
               child: GestureDetector(
                 onTap: (){

                 },
                    child: Container(
                  decoration: BoxDecoration(
                  color: Colors.black12,  
                  border: Border.all(width:1.0,color:Colors.black38),
                  borderRadius: BorderRadius.circular(7.0)
                  ),
                  child: ListTile(
                    leading: Text("Name"),
                    title: Text(widget.name,style:TextStyle(fontSize: 18.0)),
                  )
                ),
               ),
             ),
             Padding(
               padding: EdgeInsets.fromLTRB(15.0,0.0,15.0,15.0),
               child: GestureDetector(
                 onTap: (){

                 },
                    child: Container(
                  decoration: BoxDecoration(
                  color: Colors.black12,  
                  border: Border.all(width:1.0,color:Colors.black38),
                  borderRadius: BorderRadius.circular(7.0)
                  ),
                  child: ListTile(
                    leading: Text("Email"),
                    title: Text(widget.email,style:TextStyle(fontSize: 18.0)),
                  )
                ),
               ),
             )
           ],
         ),
       ),
    );
  }
}