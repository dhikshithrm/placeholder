import 'package:cloud_firestore/cloud_firestore.dart';

class Category_services{
  List<Map<String, dynamic>> getCategories(){
    List<Map<String, dynamic>> categories = [];
    Firestore.instance
           .collection('categories')
           .getDocuments().then((value){
             value.documents.forEach((e) {
               categories.add(e.data);
             });
           });
    return categories;
  }
}