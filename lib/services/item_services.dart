import 'package:cloud_firestore/cloud_firestore.dart';

class Item_services{
  Future<List<Map<String,dynamic>>> getItems()async{
    List<Map<String,dynamic>> items = [];
     await Firestore.instance
             .collection('items')
             .getDocuments().then((value){
               value.documents.forEach((e) {
                 items.add(e.data);
               });
             });
      return items;
  }
  Future<QuerySnapshot> getItemWithName(String name)async{
   return await Firestore.instance
              .collection('items')
              .where('name', isEqualTo: name)
              .getDocuments();
   }
  }