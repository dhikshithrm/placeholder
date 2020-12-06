import 'package:firebase_auth/firebase_auth.dart';
import 'package:flare_splash_screen/flare_splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:its12/homepage.dart';
import 'package:its12/pages/login_page.dart';
import 'package:its12/pages/signup_page.dart';
import 'package:its12/services/models_Provider.dart';
import 'package:its12/services/user_management.dart';
import 'package:provider/provider.dart';
void main() => runApp(
   MyApp());
class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {

  FirebaseUser user; 
  String uid;
  Future<FirebaseUser> getUser()async{
    return await FirebaseAuth.instance.currentUser();
  }
  @override
  void initState() { 
    getUser().then((value){
      setState(() {
        user = value;
        uid = user.uid;
      });
    });
    super.initState();
    
  }
  @override
  Widget build(BuildContext context){
    return MultiProvider(
      providers: [
        StreamProvider<FirebaseUser>.value(value: FirebaseAuth.instance.onAuthStateChanged),
        StreamProvider<User>.value(value: UserManagemenent().getUserStream(uid)),
        ],
          child: MaterialApp(
            routes: {
              '/home': (context) => HomePage(),
              '/signuppage': (context) => Signup(),
              '/loginpage': (context) => Login()
            },
            debugShowCheckedModeBanner: false,
            home: SplashScreen(
              "assets/New File 2.flr",
              uid!=null?HomePage():Login(),
              until: () {
                getUser();
              },
              startAnimation: 'its12',
              
              // transitionsBuilder: 
              ),
      ),
    );
 }
}
// add multiprovider in first loggedin widget!