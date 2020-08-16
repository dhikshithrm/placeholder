import 'package:flutter/material.dart';
import 'package:its12/items/item_class.dart';
import 'package:its12/services/category_services.dart';
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
    super.initState();
    getItems();
    
    // TODO: implement initState
    
  }

  void getItems(){
    Category_services().getItemsWithCategory(widget.category)
    .then((value) {
      setState(() {
        categoryItems = value;
      });
    });
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
                padding: const EdgeInsets.fromLTRB(7.3,8.0,7.3,8.0),
                child: Container(
                  width: double.infinity,
                  height: 50,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5.0),
                      color: Colors.black
                  ),
                  child: Center(
                      child: Padding(padding: EdgeInsets.all(5.0),
                        child: Text(
                          widget.category,
                          style: TextStyle(
                            fontSize: 20,
                            color: Colors.white,
                            fontWeight: FontWeight.w500
                          ),
                        ),
                      ),
                  ),
                ),
            ),
            categoryItems.length == 0?
            Container(
                height: 500,
                child: Center(child: CircularProgressIndicator()))
            :Container(
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
                          diffVariants: categoryItems[index]['customisable'],
                        );
                      }
                   ),
            )
          ],),
       )
    );
  }
}