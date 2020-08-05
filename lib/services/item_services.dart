import 'package:cloud_firestore/cloud_firestore.dart';

class Item_services{
  List<Map<String,dynamic>> getItems(){
    List<Map<String,dynamic>> items = [];
    Firestore.instance
             .collection('items')
             .getDocuments().then((value){
               value.documents.forEach((e) {
                 items.add(e.data);
               });
             });
      return items;
  }
  getItemWithName(String name){
    Firestore.instance
              .collection('items')
              .where('name', isEqualTo: name)
              .getDocuments();
  }
  }