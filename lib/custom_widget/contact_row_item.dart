import 'dart:io';

import 'package:card_holder/database/db_sqlite.dart';
import 'package:card_holder/models/contract_model.dart';
import 'package:card_holder/pages/contract_details_page.dart';
import 'package:card_holder/utilitu/helper.dart';
import 'package:flutter/material.dart';

class ContactRowItem extends StatefulWidget {
  final ContractModel contractModel;
  final int index;

  ContactRowItem(this.contractModel, this.index);

  @override
  _ContactRowItemState createState() => _ContactRowItemState();
}

class _ContactRowItemState extends State<ContactRowItem> {
  @override
  Widget build(BuildContext context) {
    return Dismissible(
      direction: DismissDirection.endToStart,
      background: Card(
        semanticContainer: true,
        clipBehavior: Clip.antiAliasWithSaveLayer,
        child: Container(
          alignment: Alignment.centerRight,
          color: Colors.redAccent,
          child: Padding(
            padding: const EdgeInsets.only(right: 16),
            child: Icon(
              Icons.delete,
              color: Colors.white,
              size: 32,
            ),
          ),
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
        margin: EdgeInsets.all(4),
      ),
      key: UniqueKey(),
      child: Padding(
        padding: const EdgeInsets.all(4.2),
        child: Card(
          semanticContainer: true,
          clipBehavior: Clip.antiAliasWithSaveLayer,
          child: ListTile(
            onTap: () {
              Navigator.pushNamed(context, ContractDetailsPage.routeName,
                  arguments: widget.contractModel.id);
            },
            title: Text(widget.contractModel.name!),
            tileColor: Colors.white,
            subtitle: Text(widget.contractModel.address!),
            leading: ClipRRect(
              borderRadius: BorderRadius.circular(8.0), //or 15.0
              child: Container(
                height: 70.0,
                width: 70.0,
                color: Colors.greenAccent,
                child: widget.contractModel.image == null ? Image.asset('images/not_able.png',width: 250,) : Image.file(File(widget.contractModel.image!),fit: BoxFit.fill,),
              ),
            ),

            //CircleAvatar(backgroundImage: AssetImage('images/not_able.png')),
            trailing: IconButton(
              icon: Icon(widget.contractModel.favorite! ? Icons.favorite_rounded : Icons.favorite_border_rounded, color: Colors.redAccent,
              ),
              onPressed: () {
                final value = widget.contractModel.favorite! ? 0 : 1;
                DBSQLite.updateFavorite(widget.contractModel.id!, value).then((value){
                  setState(() {
                    widget.contractModel.favorite = !widget.contractModel.favorite!;
                  });
                });
              },
            ),
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          elevation: 5,
          margin: EdgeInsets.all(4),
        ),
      ),
      onDismissed: (_) {
        DBSQLite.deleteContractByID(widget.contractModel.id!).then((value) {
          showMessage(context, 'Delete');
        });
      },
      confirmDismiss: (_) {
        return showDialog(
            context: context,
            builder: (context) => AlertDialog(
                  title: Text('Delete ${widget.contractModel.companyName} ?'),
                  content: Text('Are you sure to delete this contact ?'),
                  actions: [
                    TextButton(
                        onPressed: () {
                          Navigator.pop(context, false);
                        },
                        child: Text('Cancel')),
                    ElevatedButton(
                        onPressed: () {
                          Navigator.pop(context, true);
                        },
                        child: Text('Delete')),
                  ],
                ));
      },
    );
  }
}
