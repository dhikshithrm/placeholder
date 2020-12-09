import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';

class Category_services{
  Future<QuerySnapshot> getCategories()async{
    await Firebase.initializeApp();
     return FirebaseFirestore.instance
           .collection('categories')
           .get();
  }
    Future<List<Map<String, dynamic>>> getItemsWithCategory(category)async{
    await Firebase.initializeApp();
    List<Map<String, dynamic>> citems = [];
     await FirebaseFirestore.instance
              .collection("items")
              .where("category",isEqualTo: category)
              .get().then((value){
                value.docs.forEach((e) {
                  citems.add(e.data());
                });
             });
             return citems;
  }
}