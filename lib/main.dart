import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flare_splash_screen/flare_splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:its12/homepage.dart';
import 'package:its12/pages/login_page.dart';
import 'package:its12/pages/signup_page.dart';
import 'package:its12/services/models_Provider.dart';
import 'package:its12/services/user_management.dart';
import 'package:provider/provider.dart';


void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
  }
class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {

  User user; 
  String uid;
  User getUser(){
   return  FirebaseAuth.instance.currentUser;
  }
  @override
  void initState() { 
    setState(() {
      user = getUser();
      try {
        uid = user.uid;
      } catch(e){
        
      }
    });
    super.initState();
  }
  @override
  Widget build(BuildContext context){
      return MultiProvider(
          providers: [
            StreamProvider<User>.value(value: FirebaseAuth.instance.authStateChanges()),
            StreamProvider<UserC>.value(value: UserManagemenent().getUserStream(uid), catchError: (context,user){
              print(user);
            },),
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
              until: (){
                getUser();
                },
              startAnimation: 'its12',
            ),
      ),
    );
    
 }
}
// add multiprovider in first loggedin widget!