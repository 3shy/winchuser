import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:winchuser/screens/colors.dart';
import 'package:url_launcher/url_launcher.dart';

class Safety extends StatelessWidget {
  const Safety({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    late String phone;

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Container(
        decoration: BoxDecoration(
          color: Mycolor.white,
        ),
        child: Scaffold(
          appBar: AppBar(
            backgroundColor: Mycolor.darkblue,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.only(
                    bottomRight: Radius.circular(30),
                    bottomLeft: Radius.circular(30))),
            title: const Text(
              'Safety',
              style: TextStyle(fontSize: 25),
            ),
            centerTitle: true,
          ),
          body: Container(
            alignment: Alignment.center,
            color: Mycolor.white,
            child: Column(
              children: <Widget>[
                const SizedBox(height: 35),
                Column(
                  children: [
                    Image.asset(
                      "assets/images/safe.png",
                      width: 180,
                      height: 180,
                    ),
                  ],
                ),
                const SizedBox(height: 70),
                Column(
                  children: [
                    ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          primary: Mycolor.red,
                          fixedSize: const Size(300, 45),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(50.0),
                          ),
                        ),
                        onPressed: () {
                          _launchURL('tel:122');
                        },
                        child: const Text(
                          'Call The Police',
                          style: TextStyle(
                            fontSize: 18,
                          ),
                        )),
                  ],
                ),
                const SizedBox(height: 20),
                Column(
                  children: [
                    ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          primary: Mycolor.red,
                          fixedSize: const Size(300, 45),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(50.0),
                          ),
                        ),
                        onPressed: () {
                          _launchURL('tel:123');
                        },
                        child: const Text(
                          'Call the Ambulance',
                          style: TextStyle(
                            fontSize: 18,
                          ),
                        )),
                  ],
                ),
                const SizedBox(height: 20),
                Column(
                  children: [
                    ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          primary: Mycolor.red,
                          fixedSize: const Size(300, 45),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(50.0),
                          ),
                        ),
                        onPressed: () {
                          FirebaseFirestore.instance
                              .collection("users")
                              .doc(FirebaseAuth.instance.currentUser!.uid)
                              .get()
                              .then((value) => {
                                    phone = value.get("em_number").toString(),
                                  });

                          _launchURL('tel:+${phone}');
                        },
                        child: const Text(
                          'Call Your Chosen Number',
                          style: TextStyle(
                            fontSize: 18,
                          ),
                        )),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _launchURL(String _url) async {
    if (!await launch(_url)) throw 'Could not launch $_url';
  }
}
