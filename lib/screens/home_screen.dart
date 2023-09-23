import 'package:flutter/material.dart';
import 'package:inext/firebase_service/authservice.dart';
import 'package:inext/screens/login_page.dart';

class HomeScreen extends StatefulWidget {
  HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  var height, width;

  List imageData=[
    "assets/mcqs.png",
    "assets/quiz.png",
    "assets/job.png",
    "assets/about.png"

  ];

List dataTitle = [
  "MCQS",
  "QUIZ",
  "Jobs",
  "About",

];
  AuthService authService = AuthService();
  @override
  Widget build(BuildContext context) {
    height = MediaQuery.of(context).size.height;
    width = MediaQuery.of(context).size.width;

    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Container(
            color: Color(0xFFefcf18),
            height: height,
            width: width,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  height: height * 0.25,
                  width: width,
                  decoration: BoxDecoration(),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding:
                            const EdgeInsets.only(top: 35, left: 20, right: 20),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            InkWell(
                              onTap: ()async {
                                showDialog(
                                    barrierDismissible: false,
                                    context: context,
                                    builder: (context) {
                                      return AlertDialog(
                                        title: Text("Logout"),
                                        content: Text("Are you sure you want to logout?"),
                                        actions: [
                                          IconButton(
                                              onPressed: () {
                                             Navigator.pop(context);
                                              },
                                              icon: Icon(
                                                Icons.cancel,
                                                color: Colors.red,
                                              )),
                                          IconButton(
                                              onPressed: () async {
                                                authService.signOut().whenComplete(() {
                                                  Navigator.push(context, MaterialPageRoute(builder: (context)=>LoginPage()));

                                                });
                                              },
                                              icon: Icon(
                                                Icons.done,
                                                color: Colors.green,
                                              ))
                                        ],
                                      );
                                    });
                              },
                              child: Icon(
                                Icons.logout,
                                color: Colors.white,
                                size: 40,
                              ),
                            ),
                            CircleAvatar(
                              backgroundImage: AssetImage("assets/profile.jpg"),
                              radius: 25,
                            )
                          ],
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(
                          top: 20,
                          left: 30,
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Dashboard",
                              style: TextStyle(
                                  fontSize: 30,
                                  color: Colors.white,
                                  fontWeight: FontWeight.w500,
                                  letterSpacing: 1),
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                ),
                Container(
                  padding: EdgeInsets.symmetric(vertical: 20),
                  height: height * 0.75,
                  width: width,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(30),
                      topRight: Radius.circular(30),
                    ),
                  ),
                  child: GridView.builder(
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      childAspectRatio: 1.1,
                      mainAxisSpacing: 25,
                    ),

                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    itemCount: 4,
                    itemBuilder: (context,index){
                      return InkWell(
                        onTap: (){},
                        child: Container(
                          margin: EdgeInsets.symmetric(vertical: 8,horizontal: 20),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            color: Colors.white,
                            boxShadow: [
                              BoxShadow(
                                  color:Colors.black26,
                                spreadRadius: 1,
                                blurRadius: 6,

                              )
                            ]
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Image.asset(imageData[index],width: 100,),
                              Text(dataTitle[index],style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
