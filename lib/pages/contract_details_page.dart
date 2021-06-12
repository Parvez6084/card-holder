import 'dart:io';

import 'package:card_holder/database/db_sqlite.dart';
import 'package:card_holder/models/contract_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';


class ContractDetailsPage extends StatefulWidget {
  static final String routeName = '/contract_details_page';


  @override
  _ContractDetailsPageState createState() => _ContractDetailsPageState();
}

class _ContractDetailsPageState extends State<ContractDetailsPage> {
  int contractID = -1;
  ContractModel? contractModel;

  @override
  void didChangeDependencies() {
    contractID = ModalRoute
        .of(context)
        ?.settings
        .arguments as int;
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder<ContractModel>(
        future: DBSQLite.getContractByID(contractID),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            contractModel = snapshot.data;
            return dataSetDesign();
          }

          if (snapshot.hasError) {
            return Text('Fail to face data');
          }

          return CircularProgressIndicator();
        },
      ),

    );
  }

  Widget dataSetDesign() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        cardShowContainer(),
        Padding(
          padding: const EdgeInsets.only(top: 40, left: 16, right: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              textFunction('Name', contractModel!.name!),
              if(contractModel!.website != 'Unknown') textFunction('Designation', contractModel!.designation!),
              if(contractModel!.website != 'Unknown')  textFunction('Company Name', contractModel!.companyName!),

              new Divider(color: Colors.grey,),
              SizedBox(height: 8,),
              if(contractModel!.website != 'Unknown') textFunction('Phone', contractModel!.phoneNumber!, Icons.call_rounded, Colors.greenAccent, onCall),
              if(contractModel!.website != 'Unknown') textFunction('Email', contractModel!.email!, Icons.email_rounded, Colors.red, onEmail),
              if(contractModel!.website != 'Unknown') textFunction('Web Site', contractModel!.website!, Icons.web, Colors.blue, onWebSite),
              if(contractModel!.website != 'Unknown')textFunction('Address', contractModel!.address!, Icons.location_on_rounded, Colors.yellow,onAddress),
            ],
          ),
        ),
      ],
    );
  }


  Widget cardShowContainer() {
    return Container(
      margin: EdgeInsets.only(top: 40,left: 16,right: 16),
      child: Card(
        semanticContainer: true,
        clipBehavior: Clip.antiAliasWithSaveLayer,
        child: Align(alignment: Alignment.topCenter,
            child: contractModel!.image == null ? Image.asset('images/not_able.png',width: 250,) : Image.file(File(contractModel!.image!,),fit: BoxFit.fill,)
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        elevation: 5,
        margin: EdgeInsets.all(10),
      ),

    );
  }

  Widget textFunction(String pathName, String pathValue,[IconData? icon, Color? color, void _onclick()?]) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(pathName, style: TextStyle(fontSize: 14,color: Colors.grey)),
        Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(pathValue, style: TextStyle(fontSize: 16)),
            MaterialButton(
              onPressed: _onclick,
              color: color,
              textColor: Colors.white,
              child: Icon(icon, size: 20,),
              shape: CircleBorder(),
            )
          ],
        ),
        SizedBox(height: 8),
      ],
    );
  }

  void onCall() {
    final url = 'tel:${contractModel!.phoneNumber}';
    activityLaunch(url);
  }
  void onEmail() {
    final url = 'mailto:${contractModel!.email}';
    activityLaunch(url);
  }
  void onWebSite(){
    final url = 'https:${contractModel!.email}';
    activityLaunch(url);
  }
  void onAddress(){
    final url = 'geo:0,0?q=${contractModel!.email}';
    activityLaunch(url);
  }
  void activityLaunch(String url) async {
    if(await canLaunch(url)){
      await launch(url);
    }else{
      throw 'Can not launch';
    }
  }


}