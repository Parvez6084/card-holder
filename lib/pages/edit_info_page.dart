import 'package:card_holder/database/db_sqlite.dart';
import 'package:card_holder/models/contract_model.dart';
import 'package:card_holder/pages/home_page.dart';
import 'package:card_holder/utilitu/helper.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class EditInfoPage extends StatefulWidget {
  static final String routeName = '/edit_info_page';

  @override
  _EditInfoPageState createState() => _EditInfoPageState();
}

class _EditInfoPageState extends State<EditInfoPage> {
  final nameController = TextEditingController();
  final designationController = TextEditingController();
  final phoneController = TextEditingController();
  final emailController = TextEditingController();
  final websiteController = TextEditingController();
  final addressController = TextEditingController();
  final companyController = TextEditingController();

  ContractModel? contractModel;
  final _formKey = GlobalKey<FormState>();

  @override
  void didChangeDependencies() {
    contractModel = ModalRoute.of(context)!.settings.arguments as ContractModel;
    _setTextValues();
    super.didChangeDependencies();
  }

  @override
  void dispose() {
    nameController.dispose();
    designationController.dispose();
    phoneController.dispose();
    emailController.dispose();
    websiteController.dispose();
    addressController.dispose();
    companyController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add Contact'),
        actions: [
          IconButton(onPressed: _saveContact, icon: Icon(Icons.save)),
        ],
      ),
      body: Form(
        key: _formKey,
        child: ListView(
          padding: const EdgeInsets.all(12.0),
          children: [
            TextFormField(
              controller: nameController,
              decoration: InputDecoration(
                  labelText: 'Name', border: OutlineInputBorder()),
              validator: (value) {
                if (value!.isEmpty) {
                  return 'Field is empty!!';
                }
                return null;
              },
              onSaved: (value) {
                contractModel!.name = value;
              },
            ),
            SizedBox(
              height: 10,
            ),

            TextFormField(
              controller: designationController,
              decoration: InputDecoration(
                  labelText: 'Designation', border: OutlineInputBorder()),
              validator: (value) {
                if (value!.isEmpty) {
                  return 'Field is empty!!';
                }
                return null;
              },
              onSaved: (value) {
                contractModel!.designation = value;
              },
            ),
            SizedBox(
              height: 10,
            ),

            TextFormField(
              keyboardType: TextInputType.phone,
              maxLength: 11,
              validator: (value) {
                if (value!.isEmpty) {
                  return 'Field is empty!!';
                }
                return null;
              },
              onSaved: (value) {
                contractModel!.phoneNumber = value;
              },
              controller: phoneController,
              decoration: InputDecoration(
                labelText: 'Phone',
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(
              height: 10,
            ),

            TextFormField(
              controller: emailController,
              keyboardType: TextInputType.emailAddress,
              decoration: InputDecoration(
                  labelText: 'Email', border: OutlineInputBorder()),
              validator: (value) {
                if (value!.isEmpty) {
                  return 'Field is empty!!';
                }
                return null;
              },
              onSaved: (value) {
                contractModel!.email = value;
              },
            ),
            SizedBox(
              height: 10,
            ),

            TextFormField(
              controller: companyController,
              decoration: InputDecoration(
                  labelText: 'Company', border: OutlineInputBorder()),
              validator: (value) {
                if (value!.isEmpty) {
                  return 'Field is empty!!';
                }
                return null;
              },
              onSaved: (value) {
                contractModel!.companyName = value;
              },
            ),
            SizedBox(
              height: 10,
            ),

            TextFormField(
              controller: websiteController,
              decoration: InputDecoration(
                  labelText: 'Web Site', border: OutlineInputBorder()),
              validator: (value) {
                if (value!.isEmpty) {
                  return 'Field is empty!!';
                }
                return null;
              },
              onSaved: (value) {
                contractModel!.website = value;
              },
            ),
            SizedBox(
              height: 10,
            ),

            TextFormField(
              controller: addressController,
              decoration: InputDecoration(
                  labelText: 'Address', border: OutlineInputBorder()),
              validator: (value) {
                if (value!.isEmpty) {
                  return 'Field is empty!!';
                }
                return null;
              },
              onSaved: (value) {
                contractModel!.address = value;
              },
            ),
          ],
        ),
      ),
    );
  }


  void _setTextValues() {
    setState(() {
      nameController.text = contractModel!.name ?? 'Unknown';
      designationController.text = contractModel!.designation ?? 'Unknown';
      phoneController.text = contractModel!.phoneNumber ?? 'Unknown';
      emailController.text = contractModel!.email ?? 'Unknown';
      companyController.text = contractModel!.companyName ?? 'Unknown';
      addressController.text = contractModel!.address ?? 'Unknown';
      websiteController.text = contractModel!.website ?? 'Unknown';
    });
  }

  void _saveContact() {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
    }
    DBSQLite.insertNewContact(contractModel!).then((id) {
      showMessage(context,'Save');
      Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context) =>
          HomePage()), (Route<dynamic> route) => false);
    }).catchError((error) {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text('Fail to save')));
      throw error;
    });
  }

}
