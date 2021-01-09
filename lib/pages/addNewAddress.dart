import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';


class AddAddress extends StatefulWidget {
  String userid;
  AddAddress({this.userid});
  @override
  _AddAddressState createState() => _AddAddressState();
}

class _AddAddressState extends State<AddAddress> {
  TextEditingController _addNameController = TextEditingController();
  TextEditingController _nameController = TextEditingController();
  TextEditingController _phoneController = TextEditingController();
  TextEditingController _pinController = TextEditingController();
  TextEditingController _cityController = TextEditingController();
  TextEditingController _housenoController = TextEditingController();
  TextEditingController _extraController = TextEditingController();
  // String name;
  // String phone;
  // String pincode;
  // String city;
  // String extra;
  
  @override
  void dispose() {
    _addNameController.dispose();
    _cityController.dispose();
    _extraController.dispose();
    _pinController.dispose();
    _extraController.dispose();
    _nameController.dispose();
    _housenoController.dispose();
    // TODO: implement dispose
    super.dispose();
  }

   final GlobalKey<FormState> _formkey = GlobalKey<FormState>();
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
                  onPressed: (){
                   
                  }
                ),
        //        IconButton(
        //          icon: Icon(Icons.shopping_cart,
        //        color: Colors.white,
        //       ),
        //     onPressed: (){
        //        Navigator.push(context, CupertinoPageRoute(builder: (context)=> Cart()));
        //     }
        //  )
        ],
      ),
      body: SingleChildScrollView(
              child: Column(children: [
          Form(
              key: _formkey,
             child: SingleChildScrollView(
                 child: Column(
                 children: <Widget>[
                   Padding(
                     padding: const EdgeInsets.fromLTRB(15.0,10.0,15.0,0.0),
                     child: TextFormField(
                       controller: _addNameController,
                       decoration: InputDecoration(
                         border:OutlineInputBorder(),
                         hintText: 'Address Name(example:home,office)(*Required)',
                         labelStyle: TextStyle(
                           color: Colors.black
                         ),
                       ),
                       onSaved: (value){
                         setState(() {
                           
                         });
                       },
                     ),
                   ),
                   Padding(
                     padding: const EdgeInsets.fromLTRB(15.0,10.0,15.0,0.0),
                     child: TextFormField(
                       controller: _nameController,
                       decoration: InputDecoration(
                         border:OutlineInputBorder(),
                         hintText: 'Full Name(*Required)',
                         labelStyle: TextStyle(
                           color: Colors.black
                         ),
                       ),
                       onSaved: (value){
                         setState(() {
                           
                         });
                       },
                     ),
                   ),
                   Padding(
                 padding: const EdgeInsets.fromLTRB(15.0,10.0,15.0,0.0),
                 child: TextFormField(
                   controller: _phoneController,
                   keyboardType: TextInputType.number,
                   inputFormatters: <TextInputFormatter>[WhitelistingTextInputFormatter.digitsOnly],
                   decoration: InputDecoration(
                     border:OutlineInputBorder(),
                     hintText: 'Phone number(*Required)',
                     labelStyle: TextStyle(
                       color: Colors.black
                     ),
                   ),
                   validator: (value){
                     if(value.runtimeType != int && value.isEmpty &&value.length==10){
                       return 'Give a valid phone number';
                     }
                     return null;
                   },
                    ),
                  ),

                 ],
               ),
             ),
           ),
           Row(
             children: [
               Container(
                 width: MediaQuery.of(context).size.width/2,
                 child: Form(
                   child: Padding(
                     padding: const EdgeInsets.fromLTRB(15.0,10.0,15.0,0.0),
                     child: TextFormField(
                      inputFormatters: <TextInputFormatter>[WhitelistingTextInputFormatter.digitsOnly],
                       keyboardType: TextInputType.number,
                       controller: _pinController,
                       decoration: InputDecoration(
                         border:OutlineInputBorder(),
                         hintText: 'Pincode(*Required)',
                         labelStyle: TextStyle(
                           color: Colors.black
                         ),
                       ),
                       validator: (value){
                         if(value.isEmpty){
                           return 'Enter Some Text';
                         }
                         return null;
                       },
                     ),
                   ),
                 ),
               ),
               Container(
                 width: MediaQuery.of(context).size.width/2,
                 child: Form(
                   child: Padding(
                     padding: const EdgeInsets.fromLTRB(15.0,10.0,15.0,0.0),
                     child: TextFormField(
                       controller: _cityController,
                       decoration: InputDecoration(
                         border:OutlineInputBorder(),
                         hintText: 'City(*Required)',
                         labelStyle: TextStyle(
                           color: Colors.black
                         ),
                       ),
                       validator: (value){
                         if(value.isEmpty){
                           return 'Enter Some Text';
                         }
                         return null;
                       },
                     ),
                   ),
                 ),
               ),
             ],
           ),
           Padding(
                   padding: const EdgeInsets.fromLTRB(15.0,10.0,15.0,0.0),
                     child: TextFormField(
                       controller: _housenoController,
                       decoration: InputDecoration(
                         border:OutlineInputBorder(),
                         hintText: 'House NO., Buildin Name(*Required)',
                         labelStyle: TextStyle(
                           color: Colors.black
                         ),
                       ),
                       onSaved: (value){
                         setState(() {
                           
                         });
                       },
                     ),
                   ),
                   Padding(
                     padding: const EdgeInsets.fromLTRB(15.0,10.0,15.0,0.0),
                     child: TextFormField(
                       controller: _extraController,
                       decoration: InputDecoration(
                         border:OutlineInputBorder(),
                         hintText: 'Road name, Area, Colony(*Required)',
                         labelStyle: TextStyle(
                           color: Colors.black
                         ),
                       ),
                     ),
                   ),
                   MaterialButton(
                     onPressed: (){

                   },child: Row(
                     mainAxisSize: MainAxisSize.min,
                     children: [
                       Icon(Icons.location_on),
                       Text("Use my location"),
                     ],
                   ))
        ],),
      ),
      bottomNavigationBar: Container(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: MaterialButton(child: Text('Save'),onPressed: (){
                if(_nameController.text!=null&&
                _addNameController.text!=null&&
                _cityController.text!=null&&
                _housenoController.text!=null&&
                _phoneController.text!=null&&
                _pinController.text!=null){
                FirebaseFirestore.instance.collection("users/${widget.userid}/addresses").doc("${_addNameController.text}").set({
                                  "full_name": _nameController.text,
                                  "add_name": _addNameController.text,
                                  "phone": _phoneController.text,
                                  "pincode": _pinController.text,
                                  "city": _cityController.text,
                                  "houseNoect": _housenoController.text,
                                  "extraDetails": _extraController.text
                                }).then((value){
                                  FirebaseFirestore.instance.doc("users/${widget.userid}").update({
                                    "addresses": FieldValue.arrayUnion([_addNameController.text])
                                  });
                                });
                }else{
                  return;
                }
               
              },color: Color(0xFAB30000),),
            )
        ],),
      ),
      );
  }
}