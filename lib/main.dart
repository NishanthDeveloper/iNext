import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:inext/screens/home_screen.dart';
import 'package:inext/screens/login_page.dart';

import 'firebase_options.dart';
import 'helper_function/helper_function.dart';


void main() async {
  WidgetsFlutterBinding.ensureInitialized();

// ...

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}
class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  bool _isSignedIn = false;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getUserLoggedInStatus();
  }
  getUserLoggedInStatus() async{
    await HelperFunction.getUserLoggedInStatus().then((value) {
      if(value != null){
        setState(() {
          _isSignedIn = value;
        });

      }
    });
  }
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home:
      _isSignedIn ? HomeScreen() : LoginPage(),
    );
  }
}