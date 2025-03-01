import 'dart:ui';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:winchuser/Buttons%20Screens/Main%20Screen/Main%20Screen.dart';
import 'package:winchuser/screens/colors.dart';

import '../../screens/user_login/flutter_toast.dart';

class Engine_Oil extends StatefulWidget {
  const Engine_Oil({Key? key}) : super(key: key);

  @override
  _Engine_OilState createState() => _Engine_OilState();
}

class _Engine_OilState extends State<Engine_Oil> {
  final controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      //The title of the app
      title: 'Rescue',
      //Statement to remove the demo banner from the application
      debugShowCheckedModeBanner: false,
      //This is the declaration of the home screen
      home: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/images/Oil1.png"),
            fit: BoxFit.cover,
          ),
        ),
        child: Scaffold(
          backgroundColor: Mycolor.white,
          appBar: AppBar(
//This is the color of the app bar's BackGround
            backgroundColor: Mycolor.darkblue,
            //This is to control the shape of the appbar borders
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.only(
                    bottomRight: Radius.circular(30),
                    bottomLeft: Radius.circular(30))),
            //This is the title that will appear in the app bar
            title: Text(
              ("Engine Oil"),
              //This is the stye of the text which is whether it is bold or not and the spacing between the letters and the font color
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  letterSpacing: 3.0,
                  color: Colors.white),
            ),
//This is a statement to put the title in the middle of the app bar
            centerTitle: true,
//Leading is used to put the items on the left side on the app bar but in this case the icon
            leading:
                //This is the arrow icon
                IconButton(
                    icon: Icon(Icons.arrow_back_ios),
                    onPressed: () {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (BuildContext context) {
                        return Main_Screen();
                      }));
                    }),
//Action is used to put the items on the right side on the app bar but in this case the icon
            actions: [
//Padding is used here to adjust the place of the icon below
              Padding(
                  padding: EdgeInsets.only(right: 80),
//This the Maintenance icon
                  child: Container(
                      height: 30,
                      width: 30,
                      child: Image.asset("assets/images/car-oil.png"))),
            ],
          ),
          body: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.only(right: 30, left: 30),
                  child: Container(
                    height: 70,
                    child: TextField(
                      controller: controller,
                      decoration: InputDecoration(
                        hoverColor: Colors.white,
                        hintText: "Milage when you changed your oil",
                        icon: Icon(
                          Icons.speed,
                          color: Colors.blue,
                        ),
                      ),
                      keyboardType: TextInputType.datetime,
                    ),
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                Container(
                    height: 60,
                    width: 150,
                    child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            primary: Mycolor.red,
                            fixedSize: Size(300, 70),
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(50.0))),
                        onPressed: () {
                          final battery = controller.text;
                          createData(
                              coll: 'Maintenance',
                              data: battery,
                              doc: FirebaseAuth.instance.currentUser!.uid,
                              coll2: 'Engine Oil');

                          Navigator.push(context, MaterialPageRoute(
                              builder: (BuildContext context) {
                            return Main_Screen();
                          }));
                        },
                        child: Text("Done"))),
              ]),
        ),
      ),
    );
  }
}
