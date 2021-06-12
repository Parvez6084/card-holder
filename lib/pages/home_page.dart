import 'dart:io';

import 'package:card_holder/custom_widget/contact_row_item.dart';
import 'package:card_holder/database/db_sqlite.dart';
import 'package:card_holder/models/contract_model.dart';
import 'package:card_holder/pages/choose_option_page.dart';
import 'package:card_holder/pages/contract_details_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  static final String routeName = '/home_page';

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _index = 0;
  final contractList = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 16, left: 16),
              child: appNameWithTitle(),
            ),
            FutureBuilder<List<ContractModel>>(
              future: DBSQLite.getAllContract(),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  final contractList = snapshot.data;
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        child: Padding(
                          padding: const EdgeInsets.only(top: 40),
                          child: SizedBox(
                            height: 260, // card height
                            child: buildPageView(contractList!),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(16),
                        child: Text('Collection List', style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 16,right: 16),
                        child: ListView.builder(
                          shrinkWrap: true,
                            itemCount: contractList.length,
                            itemBuilder: (context, i) =>
                                ContactRowItem(contractList[i], i),
                          ),
                      ),

                    ],
                  );
                }
                if (snapshot.hasError) {
                  return Text('Fail to face data');
                }

                return CircularProgressIndicator();
              },
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () {
          Navigator.pushNamed(context, ChoosePage.routeName);
        },
      ),
    );
  }

  Widget appNameWithTitle() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Card Collector',
            style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold)),
        Text('Save your all business card smartly',
            style: TextStyle(
                fontSize: 14, fontWeight: FontWeight.w300, wordSpacing: 2)),
      ],
    );
  }

  Widget buildPageView(List<ContractModel> contractList) {
    return PageView.builder(
      itemCount: contractList.length,
      controller: PageController(viewportFraction: 0.8),
      onPageChanged: (int index) => setState(() => _index = index),
      itemBuilder: (_, i) {
        return Padding(
          padding: const EdgeInsets.only(bottom: 10.0),
          child: Transform.scale(
            scale: i == _index ? 1 : 0.9,
            child: Card(
              elevation: 4,
              semanticContainer: true,
              clipBehavior: Clip.antiAliasWithSaveLayer,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20)),
              child: cardDataSet(contractList, i),
            ),
          ),
        );
      },
    );
  }

  Widget cardDataSet(List<ContractModel> contractList, int i) {
    return Stack(
      children: [
        Align(
            alignment: Alignment.topCenter,
            child: contractList[i].image == null ? Image.asset('images/not_able.png',width: 250,) : Image.file(File(contractList[i].image!,),fit: BoxFit.fill,)),
      Align(
          alignment: Alignment.bottomCenter,
          child: Container(
            height: 80,
            color: Colors.black.withOpacity(.7),
            child: ListTile(
              title: Text(
                contractList[i].name!,
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.bold),
              ),
              subtitle: Text(
                contractList[i].address!,
                style: TextStyle(color: Colors.white, fontSize: 14),
              ),
              trailing: IconButton(
                icon: Icon(contractList[i].favorite! ? Icons.favorite_rounded : Icons.favorite_border_rounded,
                  color: Colors.redAccent,
                ),
                onPressed: () {
                  final value = contractList[i].favorite! ? 0 : 1;
                  DBSQLite.updateFavorite(contractList[i].id!, value).then((value){
                    setState(() {
                      contractList[i].favorite = !contractList[i].favorite!;
                    });
                  });
                },
              ),
              onTap: () {
                Navigator.pushNamed(context, ContractDetailsPage.routeName,
                    arguments: contractList[i].id);
              },
            ),
          ),
        )
      ],
    );
  }
}
