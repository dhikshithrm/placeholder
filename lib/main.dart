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
  void getUser()async{
    user = await FirebaseAuth.instance.currentUser();
    uid = user.uid;
  }
  @override
  void initState() { 
    getUser();
    super.initState();
    
  }
  @override
  Widget build(BuildContext context){
    return MultiProvider(
      providers: [
        StreamProvider<FirebaseUser>.value(value: FirebaseAuth.instance.onAuthStateChanged),
        StreamProvider<User>.value(value: UserManagemenent().getUserStream(uid))
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
              user!=null?HomePage():Login(),
              startAnimation: 'its12',
              // transitionsBuilder: 
              ),
      ),
    );
 }
}
// add multiprovider in first loggedin widget!