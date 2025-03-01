import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:winchuser/MapScreen.dart';
import 'package:winchuser/home_chat.dart';
import 'package:winchuser/screens/safety.dart';
import 'package:winchuser/screens/colors.dart';
import 'package:winchuser/screens/home2.dart';
import 'package:winchuser/screens/user_profile/profile_setting.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  int index = 0;
  final screens = [
    const Home2(),
    const Safety(),
    MapScreen(),
    MyHomePage(
      title: 'Chatbot-Helper',
    ),
    const profile(),
  ];

  @override
  Widget build(BuildContext context) {
    final items = <Widget>[
      const Icon(
        Icons.home,
        size: 30,
      ),
      const ImageIcon(
        AssetImage("assets/images/checked.png"),
        size: 30.0,
      ),
      const ImageIcon(
        AssetImage("assets/images/placeholder.png"),
        size: 30.0,
      ),
      const ImageIcon(
        AssetImage("assets/images/chat.png"),
        size: 30.0,
      ),
      const Icon(
        Icons.person,
        size: 30,
      ),
    ];

    return Scaffold(
      extendBody: true,
      body: screens[index],
      bottomNavigationBar: Theme(
        data: Theme.of(context).copyWith(
          iconTheme: const IconThemeData(color: Colors.white),
        ), //color of icon itself

        child: CurvedNavigationBar(
          height: 58,
          items: items,
          index: index,
          buttonBackgroundColor: Mycolor.teal,
          backgroundColor: Mycolor.transparent,
          color: Mycolor.darkblue,
          animationCurve: Curves.easeInOut,
          animationDuration: const Duration(milliseconds: 300),
          onTap: (index) => setState(() => this.index = index),
        ),
      ),
    );
  }
}
