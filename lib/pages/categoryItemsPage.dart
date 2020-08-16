import 'package:flutter/material.dart';
import 'package:its12/items/item_class.dart';
class CategoryPage extends StatefulWidget {
  String category;
  CategoryPage({
    this.category
  });
  @override
  _CategoryPageState createState() => _CategoryPageState();
}

class _CategoryPageState extends State<CategoryPage> {
  List<Map<String, dynamic>> categoryItems=[];
  @override
  void initState() {
    
    // TODO: implement initState
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
             preferredSize: Size.fromHeight(60.0),
            child: AppBar(
          title: Center(
               child: Image(image: AssetImage('assets/new.png'),
                 width: 105,
                 height: 120,
            ),
          ),
          backgroundColor: Colors.black,
        )
       ),
       body: SingleChildScrollView(
         child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                  width: double.infinity,
                  child: Center(
                    child: Text(widget.category,style: TextStyle(
                      fontSize: 22.0,
                    ),),
                  ),
                ),
            ),
            Container(
              height: 1500,
              child: GridView.builder(
                   primary: false,
                   itemCount: categoryItems.length,
                   gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
                   itemBuilder: (BuildContext context,index){
                        return Singel_prod(
                          prod_name: categoryItems[index]['name'],
                          prod_picture: categoryItems[index]['imageUrl'],
                          old_price: categoryItems[index]['old_price'],
                          price: categoryItems[index]['price'],
                          description: categoryItems[index]['description'],
                        );
                      }
                   ),
            )
          ],),
       )
    );
  }
}