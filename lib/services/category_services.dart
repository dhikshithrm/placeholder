import 'package:cloud_firestore/cloud_firestore.dart';

class Category_services{
  Future<List<Map<String,dynamic>>> getCategories()async{
    List<Map<String, dynamic>> categories = [];
    await Firestore.instance
           .collection('categories')
           .getDocuments().then((value){
             value.documents.forEach((e) {
               categories.add(e.data);
             });
           });
    return categories;
  }
}