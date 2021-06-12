import 'dart:io';

import 'package:card_holder/models/card_information.dart';
import 'package:card_holder/models/contract_model.dart';
import 'package:card_holder/pages/edit_info_page.dart';
import 'package:card_holder/custom_widget/line_item.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

var tempArray = [];

class ScanPage extends StatefulWidget {
  static final String routeName = '/scan_page';

  @override
  _ScanPageState createState() => _ScanPageState();
}

class _ScanPageState extends State<ScanPage> {
  final contractModel = ContractModel();
  CardInfo? cardInfo;
  String? imgPath;
  List<String> lines = [];

  @override
  void didChangeDependencies() {
    cardInfo = ModalRoute.of(context)!.settings.arguments as CardInfo;
    imgPath = cardInfo!.imagePath;
    lines = cardInfo!.list;
    contractModel.image = imgPath;
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: <Widget>[
          Expanded(
            flex: 1,
            child: cardShowContainer(),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(
                    left: 20, right: 20, top: 10, bottom: 5),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Information',
                          style: TextStyle(
                              fontSize: 20, fontWeight: FontWeight.bold),
                        ),
                        Text(
                          'checked your all needed item',
                          style: TextStyle(fontSize: 14, color: Colors.black54),
                        ),
                      ],
                    ),
                    ElevatedButton(
                      onPressed: _editPageButton,
                      style: ElevatedButton.styleFrom(
                        primary: Colors.greenAccent,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20.0)),
                      ),
                      child: Text('Next'),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 20, right: 20, bottom: 10),
                child: SizedBox(
                  height: 40,
                  child: ListView(
                    scrollDirection: Axis.horizontal,
                    children: [
                      builtPropertyButton('Name'),
                      builtPropertyButton('Designation'),
                      builtPropertyButton('Phone'),
                      builtPropertyButton('Email'),
                      builtPropertyButton('Company'),
                      builtPropertyButton('Web site'),
                      builtPropertyButton('Address'),
                    ],
                  ),
                ),
              ),
              Container(
                height: 500,
                margin: EdgeInsets.only(left: 20, right: 20),
                width: double.infinity,
                decoration: _listDecoration(),
                child: ListView.builder(
                    itemCount: lines.length,
                    itemBuilder: (context, i) => LineItem(lines[i])),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget cardShowContainer() {
    return Container(
      margin: EdgeInsets.only(top: 40),
      child: Card(
        semanticContainer: true,
        clipBehavior: Clip.antiAliasWithSaveLayer,
        child: Image.file(File(imgPath!), fit: BoxFit.fill),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        elevation: 5,
        margin: EdgeInsets.all(10),
      ),
    );
  }

  BoxDecoration _listDecoration() {
    return BoxDecoration(
        borderRadius: BorderRadius.only(
            topLeft: Radius.circular(20), topRight: Radius.circular(20)),
        boxShadow: [
          BoxShadow(
              blurRadius: 6,
              spreadRadius: 0.4,
              offset: Offset(0.1, 0.5),
              color: Colors.blue),
        ],
        color: Colors.white);
  }

  BoxDecoration buildBoxDecoration(Color colors) {
    return BoxDecoration(
      borderRadius: BorderRadius.circular(20),
      color: colors,
    );
  }

  void _editPageButton() {
    print(contractModel);
    Navigator.pushNamed(context, EditInfoPage.routeName,arguments: contractModel);
  }

  void _assignsProperty(String value) {
    final item = tempArray.join(' ');
    switch (value) {
      case 'Name':
        contractModel.name = item;
        break;
      case 'Designation':
        contractModel.designation = item;
        break;
      case 'Company':
        contractModel.companyName = item;
        break;
      case 'Phone':
        contractModel.phoneNumber = item;
        break;
      case 'Email':
        contractModel.email = item;
        break;
      case 'Web site':
        contractModel.website = item;
        break;
      case 'Address':
        contractModel.address = item;
        break;
    }
    tempArray = [];
    print('scan page = $contractModel');
  }

  Widget builtPropertyButton(String text) {
    return Padding(
      padding: const EdgeInsets.only(left: 6.0),
      child: ElevatedButton(
          onPressed: () {
            _assignsProperty(text);
          },
          child: Text(text)),
    );
  }
}
