import 'package:flutter/material.dart';
import 'package:winchuser/screens/attractions.dart';
import 'package:winchuser/screens/colors.dart';
import 'package:winchuser/Buttons Screens/Main Screen/Main Screen.dart';
import 'package:winchuser/screens/report.dart';
import 'package:winchuser/screens/winchpage/shops.dart';
import 'helppeople/mainpage.dart';

class Home2 extends StatelessWidget {
  const Home2({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Container(
        decoration: BoxDecoration(
          color: Mycolor.white,
        ),
        child: Scaffold(
          appBar: AppBar(
            backgroundColor: Mycolor.darkblue,
            shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.only(
                    bottomRight: Radius.circular(30),
                    bottomLeft: Radius.circular(30))),
            title: const Text(
              "Rescue",
              style: TextStyle(fontSize: 25),
            ),
            centerTitle: true,
          ),
          body: Container(
            alignment: Alignment.center,
            color: Mycolor.white,
            child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  Column(
                    children: [
                      ElevatedButton(
                          style: ElevatedButton.styleFrom(
                              primary: Mycolor.red,
                              fixedSize: const Size(350, 80),
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(50.0))),
                          onPressed: () {
                            Navigator.push(context, MaterialPageRoute(
                                builder: (BuildContext context) {
                              return const Attraction();
                            }));
                          },
                          child: const Text('Request Your Attraction',
                              style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white))),
                    ],
                  ),
                  Column(
                    children: [
                      ElevatedButton(
                          style: ElevatedButton.styleFrom(
                              primary: Mycolor.red,
                              fixedSize: const Size(350, 80),
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(50.0))),
                          onPressed: () {
                            Navigator.push(context, MaterialPageRoute(
                                builder: (BuildContext context) {
                              return Helppeople();
                            }));
                          },
                          child: const Text('Help From People',
                              style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white))),
                    ],
                  ),
                  Column(
                    children: [
                      ElevatedButton(
                          style: ElevatedButton.styleFrom(
                              primary: Mycolor.red,
                              fixedSize: const Size(350, 80),
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(50.0))),
                          onPressed: () {
                            Navigator.push(context, MaterialPageRoute(
                                builder: (BuildContext context) {
                              return Shops();
                            }));
                          },
                          child: const Text('Request Winch',
                              style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white))),
                    ],
                  ),
                  Column(
                    children: [
                      ElevatedButton(
                          style: ElevatedButton.styleFrom(
                              primary: Mycolor.red,
                              fixedSize: const Size(350, 80),
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(50.0))),
                          onPressed: () {
                            Navigator.push(context, MaterialPageRoute(
                                builder: (BuildContext context) {
                              return const Main_Screen();
                            }));
                          },
                          child: const Text('Maintenance',
                              style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white))),
                    ],
                  ),
                  Column(
                    children: [
                      ElevatedButton(
                          style: ElevatedButton.styleFrom(
                              primary: Mycolor.red,
                              fixedSize: const Size(350, 80),
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(50.0))),
                          onPressed: () {
                            Navigator.push(context, MaterialPageRoute(
                                builder: (BuildContext context) {
                              return const Report();
                            }));
                          },
                          child: const Text('Report For Traffic Jam',
                              style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white))),
                      const SizedBox(height: 70),
                    ],
                  ),
                ]),
          ),
        ),
      ),
    );
  }
}
