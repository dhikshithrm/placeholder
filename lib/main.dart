import 'package:firebase_auth/firebase_auth.dart';
import 'package:flare_splash_screen/flare_splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:its12/homepage.dart';
import 'package:its12/pages/login_page.dart';
import 'package:its12/pages/signup_page.dart';
import 'package:provider/provider.dart';
void main() => runApp(
   MyApp());
class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
            providers:
                [
                StreamProvider<FirebaseUser>.value(value: FirebaseAuth.instance.onAuthStateChanged),
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
          Login(),
          startAnimation: 'its12',
          // transitionsBuilder: 
          ),
      ),
    );
 }
}
