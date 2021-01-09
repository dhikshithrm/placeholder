import 'package:carousel_pro/carousel_pro.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:its12/pages/wishlist_page.dart';
import 'package:its12/services/models_Provider.dart';
import 'package:its12/services/user_management.dart';
import 'package:provider/provider.dart';
import 'package:its12/pages/About.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter/widgets.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:its12/items/item_class.dart';
import 'package:its12/pages/categoryItemsPage.dart';
import 'package:its12/pages/search_page.dart';
import 'package:its12/pages/profile.dart';
import 'package:its12/services/category_services.dart';
import 'package:its12/services/item_services.dart';
import 'pages/shop_by_cat.dart';

class HomePage extends StatefulWidget {
  
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final GoogleSignIn googleSignIn = GoogleSignIn();
  FirebaseFirestore db = FirebaseFirestore.instance;
  FirebaseDatabase _database = FirebaseDatabase.instance;
  int itemlen;
  bool categoryisLoading;
  List<Map<String, dynamic>> productItems=[];
  Category_services category_services = Category_services();
  Item_services item_services = Item_services();
  User user;
  UserC firestore_user;
  @override
  void initState() { 
    item_services.getItems().then((value){
      setState(() {
        productItems = value;
      });
    });
    super.initState();
      }

  @override
  void dispose() { 
    
    super.dispose();
  }

  int photoIndex = 0;
  static List photos = [
    'assets/images/bouquets.png',
    'assets/images/cakes.png',
    'assets/images/gifts.png',
    'assets/images/teddys.png',
    'assets/images/watches.png',
    'assets/images/bouquets.png',
    'assets/images/cakes.png',
    'assets/images/gifts.png',
    'assets/images/teddys.png',
    'assets/images/watches.png',];

  List<String> tile = ['Home','Shop By Category','Your Orders','Wishlist','Best Sellers','My Coupons','Profile','Sign Out','About Us','Contact Us'
  ,'Customer Service',
  ];

  void nextSet(){
    setState(() {if (photoIndex == 0 || photoIndex == 5){ photoIndex++;}
      photoIndex= (photoIndex+1)%6;
    });
  }

  void prevSet(){
    setState(() {if (photoIndex == 0 ||photoIndex == 5 ){ photoIndex--;}
      photoIndex = (photoIndex-1)%6;
    });
  }
  
    Widget _myAnimatedWidget(BuildContext context, {key}){
      return Container(
       key: ValueKey(photoIndex), 
       color: Colors.white,
       height: 71.5,
        child: Row(
        children: photos.sublist(photoIndex,photoIndex+3).map((e) => Container(
        child: Image.asset('$e',width:MediaQuery.of(context).size.width/3 - 32.0,)
         )).toList()                 
         )
        );
    }
  _launchURL() async {
  const url = 'tel://+919515677044';
  if (await canLaunch(url)) {
    await launch(url);
  } else {
    throw 'Could not launch $url';
  }
}
  @override
  Widget build(BuildContext context) {
     user = Provider.of<User>(context);
     firestore_user = Provider.of<UserC>(context);
           return Scaffold(
                    drawer: Drawer(
                      child: ListView(
                          primary: true,
                          children: <Widget>[
                            StreamProvider<UserC>.value(
                              catchError: (context, user){
                                print(user);
                              },
                            initialData: UserC(user!=null?user.displayName:'its12',user!=null?user.email:'its12@gmail.com',user!=null?user.photoURL:'',user!=null?user.uid:'15AJXxoil8YRIAF3BuvlphiQqul1',[""]),
                            value: UserManagemenent().getUserStream(user!=null?user.uid:'15AJXxoil8YRIAF3BuvlphiQqul1'),
                              child: Container(
                                  height: 78.0,
                                  decoration: BoxDecoration(
                                      gradient: LinearGradient(begin: Alignment.centerLeft,end: Alignment.centerRight,colors: [Color.fromRGBO(179,27,27,1),Colors.redAccent],)
                                  ),
                                  padding: EdgeInsets.fromLTRB(0.0, 13.0, 0.0, 8.0),
                                  child: Consumer<UserC>(builder: (context, _, child){
                                      return ListTile(
                                                title: firestore_user!=null?Text("Hello "+_.username,
                                      style: GoogleFonts.lato(
                                                textStyle: Theme.of(context).textTheme.display1,
                                                fontSize: 22,
                                                fontWeight: FontWeight.w700,
                                                fontStyle: FontStyle.italic,
                                              ),
                                    ):Text("Hello ${user!=null?user.displayName:''}",
                                      style: GoogleFonts.lato(
                                                textStyle: Theme.of(context).textTheme.display1,
                                                fontSize: 22,
                                                fontWeight: FontWeight.w700,
                                                fontStyle: FontStyle.italic,
                                              ),
                                    ),
                                        leading:
                                            CircleAvatar(
                                            radius: 25.0,
                                            backgroundColor: Colors.transparent,
                                            backgroundImage: _!=null?NetworkImage(_.dp??"https://firebasestorage.googleapis.com/v0/b/twelve-ccbd2.appspot.com/o/static%2Fuser.png?alt=media&token=9b70d60d-fbad-4f77-9847-6c97214ba509")
                                            :NetworkImage(user!=null?user.photoURL??"https://firebasestorage.googleapis.com/v0/b/twelve-ccbd2.appspot.com/o/static%2Fuser.png?alt=media&token=9b70d60d-fbad-4f77-9847-6c97214ba509":''),
                                            ),
                                          );
                                  })
                              ),
                            ),
                          Container(
                            child: Column(
                             children: tile.map((e) => Padding(
                               padding: const EdgeInsets.fromLTRB(0.0,4.5,0.0,4.5),
                               child: ListTile(
                                  onTap: ()async{
                                    switch (e) {
                                      case "Sign Out":
                                         FirebaseAuth.instance.signOut().then((value) => Navigator.of(context).pushReplacementNamed('/loginpage'));
                                         await googleSignIn.disconnect();
                                        break;
                                      case "Your Orders":
                                          
                                      break;
                                      case "Profile":
                                        Navigator.of(context).push(CupertinoPageRoute(builder: (BuildContext context){
                                          return ProfilePage();
                                        }));
                                        break;
                                      case "Contact Us":
                                        _launchURL();
                                        break;
                                      case "Shop By Category":
                                          Navigator.of(context).push(CupertinoPageRoute(builder: (BuildContext context){
                                            return ShopByCategory();
                                          }));
                                        break;
                                      case 'Wishlist':
                                        Navigator.of(context).push(CupertinoPageRoute(builder: (BuildContext context){
                                          return Wishlist(userId: user.uid,);
                                        }));
                                        break;
                                      case "About Us":
                                        Navigator.of(context).push(CupertinoPageRoute(builder: (BuildContext context){
                                          return AboutUspage();
                                        }));
                                    }
                                  },
                                  title: Text('$e',
                                  style: GoogleFonts.cabin(
                                    textStyle: Theme.of(context).textTheme.display1,
                                    fontSize: 20,
                                    // color: Colors.white70,
                                    fontWeight: FontWeight.w500,
                                  )
                                  )
                                 ),
                               ),
                             ).toList())
                            )
                          ],
                      )
                      ),
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
                            IconButton(
                               icon: Icon(Icons.search,
                               size: 30,
                               ),
                               onPressed: (){
                                 Navigator.of(context).push(CupertinoPageRoute(builder: (_)=> SearchPage(searchSpace: productItems,)));
                                }
                               ),
                             
                          ],
                        ),
                      ),
                    body: SingleChildScrollView(
                      child: Column(
                        children: <Widget>[
                        Container(
                        height: 200,
                        child: Carousel(
                          animationCurve: Curves.elasticIn,
                          autoplay: false,
                          overlayShadow: false,
                          dotBgColor: Colors.transparent,
                          indicatorBgPadding: 5.0,
                          dotSize: 3.5,
                          images: [Container(
                            width:MediaQuery.of(context).size.width,
                            height: 200.0,
                            decoration: BoxDecoration(
                              image: DecorationImage(fit: BoxFit.fill,image: AssetImage('assets/jns2.jpg'))
                            ),
                          ),
                          Stack(
                              children:<Widget>[ Container(
                              width:MediaQuery.of(context).size.width,
                              height: 200.0,
                              decoration: BoxDecoration(
                                image: DecorationImage(fit: BoxFit.fill,image: AssetImage('assets/images/gift.jpg')), 
                              ),
                            ),
                            Text(' Free \n Delivery \n On \n All \n Products',
                            style: TextStyle(fontFamily: 'Montserrat',fontSize: 30.0,fontWeight: FontWeight.w600,),
                            )
                            ]
                          ),
                        Container(
                          width:MediaQuery.of(context).size.width,
                          height: 200.0,
                          decoration: BoxDecoration(
                            image: DecorationImage(fit: BoxFit.fill,image: NetworkImage("https://images.unsplash.com/photo-1464349153735-7db50ed83c84?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=500&q=60"))
                          ),
                        ),
                    Container(
                        width:MediaQuery.of(context).size.width,
                        height: 200.0,
                        decoration: BoxDecoration(
                          image: DecorationImage(fit: BoxFit.fill,image: NetworkImage("https://images.unsplash.com/photo-1565608444338-315d5fbaeb5e?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=1355&q=80"))
                        ),
                    ),
                    ]
                    )
                  ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                  Container(
                     height: 71.5,
                     color: Colors.white,
                     child: IconButton(icon: Icon(Icons.arrow_left),
                     onPressed: prevSet,splashColor: Colors.transparent)
                    ),
                  AnimatedSwitcher(
                    // transitionBuilder: ,
                    duration: Duration(milliseconds: 400),
                        child: _myAnimatedWidget(context)
                  ),
                   Container(
                    height: 71.5,
                    color: Colors.white,
                    child: IconButton(icon:Icon(Icons.arrow_right),
                    onPressed: nextSet,splashColor: Colors.transparent)
                   )
                  ]
              ),
              Padding(
                  padding: const EdgeInsets.fromLTRB(7.3,8.0,7.3,8.0),
                  child: GestureDetector(
                      onTap: (){Navigator.of(context).push(CupertinoPageRoute(builder: (BuildContext context){
                          return ShopByCategory();
                      }));},
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
              ),
              Padding(
                  padding: const EdgeInsets.fromLTRB(12.0,8.0,8.0,12.0),
                  child: Text("They Might Love",
                  style: GoogleFonts.lobster(
                    fontSize: 20.0,
                    fontWeight: FontWeight.w400
                   ),
                  ),
              ),
              FutureBuilder(
                future: item_services.getItems(),
                builder: (BuildContext context, AsyncSnapshot snapshot) {
                  if(snapshot.connectionState==ConnectionState.done){
                   return Container(
                   height: 7*MediaQuery.of(context).size.height,
                   child: GridView.builder(
                     primary: false,
                     itemCount: snapshot.data.length,
                     gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
                     itemBuilder: (BuildContext context,index){
                          return Singel_prod(
                            prod_name: snapshot.data[index]['name'],
                            prod_picture: snapshot.data[index]['imageUrl'],
                            old_price: snapshot.data[index]['old_price'],
                            price: snapshot.data[index]['price'],
                            description: snapshot.data[index]['description'],
                            diffVariants: snapshot.data[index]['customisable'],
                            category: snapshot.data[index]['category'],
                            pid: snapshot.data[index]['id']
                          );
                        }
                     ),
                      );
                  }else{
                    return Container(
                height: 500,
                child: Center(child: CircularProgressIndicator()),
                    );
                  }
                },
              ),
                  ]
                  ),
                    ),
                );
        }
        }
       class Category extends StatelessWidget {
         final String categoryImage;
         final String categoryName;
         
         const Category({Key key,  this.categoryImage, this.categoryName}) : super(key: key);
         @override
         Widget build(BuildContext context) {
           return  GestureDetector(
           onTap: () {
             Navigator.of(context).push(CupertinoPageRoute(builder: (BuildContext context){
               return CategoryPage(category: categoryName);
             }));
           },
               child: Padding(
                   padding: const EdgeInsets.all(6.0),
                   child: Container(
                     child: Stack(
                       fit: StackFit.expand,
                       children: <Widget>[
                         Container(
                         decoration: BoxDecoration(
                           color: Colors.white.withOpacity(0.8),
                           image: DecorationImage(image: NetworkImage(categoryImage),fit: BoxFit.cover, ),
                           borderRadius: BorderRadius.circular(10)
                         ),
                       ),
                       Container(
                         decoration: BoxDecoration(
                           borderRadius: BorderRadius.circular(10),
                           color: Colors.black45
                         ),
                         child: Center(
                           child: Text(categoryName,
                           textAlign: TextAlign.center,
                           style: TextStyle(
                             color: Colors.white,
                             fontSize: 20,
                             fontWeight: FontWeight.w800
                           ),
                          ),
                         )
                        )
                       ]
                     ),
                   ),
                   ),
         );
         }
        }