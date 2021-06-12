import 'package:card_holder/models/contract_model.dart';
import 'package:card_holder/pages/scan_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

var isVisible = false;

class LineItem extends StatefulWidget {
  final String? line;

  LineItem(this.line);

  @override
  _LineItemState createState() => _LineItemState();
}

class _LineItemState extends State<LineItem> {
  bool isChecked = false;
  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(widget.line!),
      trailing: Checkbox(
        activeColor: Colors.greenAccent,
        value: isChecked,
        onChanged: (value) {
          setState(() {
            isChecked = value!;
          });
          value! ? tempArray.add(widget.line) : tempArray.remove(widget.line);
          print('list item = $tempArray');
        },
      ),
    );
  }

}
