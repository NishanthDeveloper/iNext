import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:inext/firebase_service/authservice.dart';
import 'package:inext/screens/home_screen.dart';
import 'package:inext/screens/register_page.dart';
import 'package:lottie/lottie.dart';

import '../firebase_service/database_service.dart';
import '../helper_function/helper_function.dart';
import '../widgets/text_field_widget.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formkey = GlobalKey<FormState>();
  String email ="";
  String password = "";
  AuthService authService = AuthService();
  bool _isLoading = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Color(0xFF282828),
body:_isLoading ? Center(child: CircularProgressIndicator(color: Color(0xFFefcf18),),) : SafeArea(
  child:   SingleChildScrollView(
    child:   Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20,vertical: 80),
      child:   Form(
        key: _formkey,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children:<Widget> [
            Text("iNext",style: TextStyle(
              fontSize: 40,fontWeight: FontWeight.bold,color:Colors.white
            ),),
            SizedBox(height: 10,),

            Center(
              child: Lottie.asset("assets/animation_lmw2nczz.json"),

            ),
            SizedBox(height: 45,),
            TextFormField(
              style:TextStyle(color: Colors.white),
              decoration:textInputDecoration.copyWith(
                labelText: "Email",
                  labelStyle: TextStyle(color: Colors.white),
                prefixIcon: Icon(Icons.email,color: Color(0xFFefcf18),)
              ),
              onChanged: (val){
                setState(() {
                  email = val;
                  print(email);
                });
              },
              validator: (value){
                return RegExp(
                    r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$')
                    .hasMatch(value!) ? null : "Please enter the valid email";
              },
            ),
            SizedBox(height: 15,),
            TextFormField(
              style:TextStyle(color: Colors.white),
              obscureText: true,
              decoration:textInputDecoration.copyWith(
                  labelText: "Password",
                  labelStyle: TextStyle(color: Colors.white),
                  prefixIcon: Icon(Icons.lock,color: Color(0xFFefcf18),)
              ),
              validator: (val){
                if(val!.length < 6){
                  return "Password must be at least 6 characters ";
                }
                else{
                  return null;
                }
              },
              onChanged: (val){
                setState(() {
                  password = val;
                  print(password);
                });
              },
            ),
            SizedBox(height: 20,),
            Container(
              width: double.infinity,
              height: 50,
              child: ElevatedButton(
                onPressed: (){
                  login();
                },
                style: ElevatedButton.styleFrom(
                  primary: Color(0xFFefcf18)
                ),
                child: Text("Sign In",style: TextStyle(fontSize: 25,fontWeight: FontWeight.bold),),
              ),
            ),
            SizedBox(height: 25,),
            Text.rich(
              TextSpan(
                text: "Don't have an account?  ",

                  style: TextStyle(
                color: Colors.white,fontSize: 18
              ),
                children: <TextSpan>[
                  TextSpan(
                    text: "Register here", style: TextStyle(
                      color: Color(0xFFefcf18),fontSize: 20
                  ),
                    recognizer: TapGestureRecognizer()..onTap=(){
                      Navigator.push(context, MaterialPageRoute(builder: (context)=>RegistrationPage()));

                    }
                  )
                ],
              )
            )
          ],
        ),
      ),
    ),
  ),
),
    );
  }

  void login() async{
    if(_formkey.currentState!.validate()){
      setState(() {
        _isLoading = true;
      });
      await authService.loginWithEmailandPassword( email, password).then((value)async{
        if(value == true){
     QuerySnapshot snapshot =     await DatabaseService(uid: FirebaseAuth.instance.currentUser!.uid).gettingUserData(email);
     await HelperFunction.saveUserLoggedInStatus(true);
     await HelperFunction.saveUserEmailSF(email);
     await HelperFunction.saveUserNameSF(snapshot.docs[0]['fullName']);
     Navigator.push(context, MaterialPageRoute(builder: (context)=>HomeScreen()));


        }else{
          showSnackbar(context, value, Colors.red);
          setState(() {
            _isLoading = false;
          });
        }
      });
    }
  }

}
