import 'package:flutter/material.dart';
import 'package:its12/homepage.dart';
import 'package:its12/services/category_services.dart';

class ShopByCategory extends StatelessWidget {
  Category_services category_services = Category_services();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
                         preferredSize: Size.fromHeight(60.0),
                         child: AppBar(
                        title: Center(
                          child: Image(image: AssetImage('assets/new.png'),
                          width: 105,
                          height: 120,)),
                          flexibleSpace: Container(
                            height: 110,
                            width: double.infinity,
                            color: Colors.black,
                            ),
                            backgroundColor: Colors.transparent,
                          elevation: 0.0,
                          actions: <Widget>[
                            
                          ],
                        ),
                      ),
       body: SingleChildScrollView(
         child: 
          Column(
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
                              "Categories",
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
              FutureBuilder(builder: (context, snap){
                    if(snap.connectionState==ConnectionState.done){
                      return Container(
                        height: 650,
                       child: GridView.builder(
                         gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
                         primary: false,
                        itemCount: snap.data.docs.length,
                        itemBuilder: (BuildContext context,index){
                            return Category(categoryName: snap.data.docs[index].data()['category'],categoryImage: snap.data.docs[index].data()['Images'][0],);
                        },
                        )
                     );
                    }
                    else{
                      return Container(
                      height: 620,
                      child: Center(child: CircularProgressIndicator())
                      );
                    }
                  },future: category_services.getCategories(),),
            ],
          ),
              
        ),
    );
  }
 }