import 'dart:async';

import 'package:card_holder/pages/home_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class SplashScreenPage extends StatefulWidget {
  static final String routeName = '/';

  @override
  _SplashScreenPageState createState() => _SplashScreenPageState();
}

class _SplashScreenPageState extends State<SplashScreenPage> {
  @override
  void initState() {
    super.initState();
    Timer(
        Duration(seconds: 5),
            () => Navigator.of(context).pushReplacement(MaterialPageRoute(
            builder: (BuildContext context) => HomePage())));
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.greenAccent,
      body: Center(
          child:  Center(child: appNameWithTitle()),
      ),
    );
  }
}

Widget appNameWithTitle() {
  return Column(
    mainAxisAlignment: MainAxisAlignment.center,
    children: [
      Text('Card Collector',
          style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold,color: Colors.white)),
      SizedBox(height: 5,),
      Text('Save your all business card smartly',
          style: TextStyle(
              fontSize: 14, fontWeight: FontWeight.w300, wordSpacing: 2,color: Colors.white)),
    ],
  );
}

