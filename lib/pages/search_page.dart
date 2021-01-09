import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flappy_search_bar/flappy_search_bar.dart';
import 'package:flappy_search_bar/scaled_tile.dart';
import 'package:flappy_search_bar/search_bar_style.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:its12/pages/product_page.dart';
import 'package:its12/services/item_services.dart';


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
        child: SearchBar<Post>(
          searchBarStyle: SearchBarStyle(
            padding: EdgeInsets.all(3)
          ),
          hintText: "Search Its12",
          onSearch: search,
          onItemFound: (Post post,int index){
              return GestureDetector(
                onTap: (){
                      Navigator.of(context).push(CupertinoPageRoute(builder: (context){
                        return FutureBuilder(builder: (context, snapshot){
                          if (snapshot.connectionState==ConnectionState.done) {
                            return ProductDetails(
                              prod_name: snapshot.data.docs[0]['name'],
                              prod_picture: snapshot.data.docs[0]['imageUrl'],
                              prod_new_price: snapshot.data.docs[0]['price'],
                              prod_old_price: snapshot.data.docs[0]['old_price'],
                              prod_description: snapshot.data.docs[0]['description'],
                              prod_diffVariants: snapshot.data.docs[0]['customisable'],
                              prod_category: snapshot.data.docs[0]['category'],
                              prod_id: snapshot.data.docs[0]['id'],
                              );
                          } else {
                            return CircularIndicator();
                          }
                        },
                        future: Item_services().getItemWithName(post.title));
                      }));
                },
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.orange,
                    borderRadius: BorderRadius.circular(7.0)
                  ),
                  child: Center(
                    child: ListTile(
                      title: Text(post.title),
                        subtitle: Text(post.subTitle)
                                ),
                              ),
                              ),
                           );
                          },
                          emptyWidget: Text("No Item Found"),
                          icon: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Icon(Icons.search,
                            color: Colors.black,),
                          ),
                          crossAxisCount: 2,
                          indexedScaledTileBuilder: (int index) => ScaledTile.count(
                                        index % 3 == 0 ? 2 : 1,
                                        1,
                                      ),
                           mainAxisSpacing: 10,
                         crossAxisSpacing: 10,
                          ),
                        )),
                    );
                  }
          Future<List<Post>> search(String text) async{
            print(searchSpace.length);
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
        class CircularIndicator extends StatelessWidget {
                              @override
                              Widget build(BuildContext context) {
                                return Scaffold(
                                  body: Center(
                                    child: Container(
                                      height: 40,
                                      width: 40,
                                      child: CircularProgressIndicator(),
                                      ),
                                  ),
                                );
                              }
                             }