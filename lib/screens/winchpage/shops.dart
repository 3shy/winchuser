import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:winchuser/pojo/driverdetails.dart';
import 'package:winchuser/screens/winchpage/item.dart';

import '../colors.dart';

class Shops extends StatefulWidget {
  const Shops({Key? key}) : super(key: key);

  @override
  _ShopsState createState() => _ShopsState();
}

class _ShopsState extends State<Shops> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Mycolor.darkblue,
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
                bottomRight: Radius.circular(30),
                bottomLeft: Radius.circular(30))),
        title: const Text(
          "Shops",
          style: TextStyle(fontSize: 25),
        ),
        centerTitle: true,
      ),
      body: Container(
        width: double.infinity,
        height: double.infinity,
        child: Expanded(
          child: StreamBuilder<List<DriverDetails>>(
            stream: readWinshs(),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                final users = snapshot.data!;

                if (users.contains("false")) {
                  return Text(
                    "no friends for you",
                    style: TextStyle(color: Colors.black),
                  );
                } else {
                  return ListView(
                    children: users.map(buildWinshs).toList(),
                  );
                }
              } else if (snapshot.hasError) {
                return Text(
                  "hasError ${snapshot.error}",
                  style: TextStyle(color: Colors.black),
                );
              }
              return Center(
                child: CircularProgressIndicator(),
              );
            },
          ),
        ),
      ),
    );
  }

  Stream<List<DriverDetails>> readWinshs() => FirebaseFirestore.instance
      .collection("driver details")
      .snapshots()
      .map((event) =>
          event.docs.map((e) => DriverDetails.fromJson(e.data())).toList());

  Widget buildWinshs(DriverDetails winshs) => Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Item(
          context,
          location: winshs.comuID,
          phone: winshs.phone,
          status: winshs.status,
          name: winshs.name,
          uuid: winshs.uId,
        ),
      );
}
