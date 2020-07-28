import 'package:cloud_firestore/cloud_firestore.dart';

class Category_services{
  Future<QuerySnapshot> getCategories(){
    return Firestore.instance
           .collection('categories')
           .getDocuments();
  }
}