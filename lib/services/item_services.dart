import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';

class Item_services{
  Future<List<Map<String,dynamic>>> getItems()async{
    await Firebase.initializeApp();
    List<Map<String,dynamic>> items = [];
     await FirebaseFirestore.instance
             .collection('items')
             .get().then((value){
               value.docs.forEach((e) {
                 items.add(e.data());
               });
             });
      return items;
  }
  Future<QuerySnapshot> getItemWithName(String name)async{
    await Firebase.initializeApp();
   return  FirebaseFirestore.instance
              .collection('items')
              .where('name', isEqualTo: name)
              .get();
   }
  Future<QuerySnapshot> getWishlistItem(id)async{
    await Firebase.initializeApp();
     return FirebaseFirestore.instance
            .collection("items")
            .where('id', isEqualTo: id)
            .get();
   }
  }