
import 'package:card_holder/pages/choose_option_page.dart';
import 'package:card_holder/pages/contract_details_page.dart';
import 'package:card_holder/pages/edit_info_page.dart';
import 'package:card_holder/pages/home_page.dart';
import 'package:card_holder/pages/scan_page.dart';
import 'package:card_holder/pages/splash_screen_page.dart';
import 'package:flutter/material.dart';
void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Smart Card Holder',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      routes:{
        SplashScreenPage.routeName : (context) => SplashScreenPage(),
        HomePage.routeName : (context) => HomePage(),
        ChoosePage.routeName : (context) => ChoosePage(),
        ScanPage.routeName : (context) => ScanPage(),
        EditInfoPage.routeName : (context) => EditInfoPage(),
        ContractDetailsPage.routeName:(context)=>ContractDetailsPage()

      },
    );
  }
}
