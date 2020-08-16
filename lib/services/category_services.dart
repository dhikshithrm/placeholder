import 'package:cloud_firestore/cloud_firestore.dart';

class Category_services{
  Future<List<Map<String,dynamic>>> getCategories()async{
    List<Map<String,dynamic>> categories = [];
     await Firestore.instance
           .collection('categories')
           .getDocuments().then((value){
             value.documents.forEach((e) {
               categories.add(e.data);
             });
           });
    return categories;
  }
    Future<List<Map<String, dynamic>>> getItemsWithCategory(category)async{
    List<Map<String, dynamic>> citems = [];
     await Firestore.instance
              .collection("items")
              .where("category",isEqualTo: category)
              .getDocuments().then((value){
                value.documents.forEach((e) {
                  citems.add(e.data);
                });
             });
             return citems;
  }
}