import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flappy_search_bar/flappy_search_bar.dart';
import 'package:flutter/material.dart';
class SearchPage extends StatelessWidget {
  List<Map<String,dynamic>> searchSpace;
  SearchPage({
    this.searchSpace
  });
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(child: 
      Padding(
        padding: EdgeInsets.symmetric(horizontal: 20),
        child: SearchBar<Post>(onSearch: search, onItemFound: (Post post,int index){
              return ListTile(
                title: Text(post.title),
                  subtitle: Text(post.subTitle)
                          );
                          }),
                        )),
                    );
                  }
          Future<List<Post>> search(String text) async{
            List<Post> suggestions = [];
            searchSpace.forEach((e) {
             if(e["name"].toLowerCase().contains(text.toLowerCase())){
               suggestions.add(Post(title: e["name"],subTitle: e["category"]));
             }
            });
           return suggestions;
          }
        }
        
        class Post {
          final String title;
          final String subTitle;

          Post({this.title, this.subTitle});
          }
        