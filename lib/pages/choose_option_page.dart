import 'package:card_holder/models/card_information.dart';
import 'package:card_holder/models/contract_model.dart';
import 'package:card_holder/pages/scan_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_ml_kit/google_ml_kit.dart';
import 'package:image_picker/image_picker.dart';

class ChoosePage extends StatefulWidget {
  static final String routeName = '/choose_option_page';

  @override
  _ChoosePageState createState() => _ChoosePageState();
}

class _ChoosePageState extends State<ChoosePage> {
  var imageSource = ImageSource.camera;

  String? imagePath;
  final contractModel = ContractModel();
  List<String> linesOfList = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Stack(
          children: [
            Container(
          margin: const EdgeInsets.only(left: 16.0, top: 64.0),
          child: titleText(),
        ),
            Align(
          alignment: Alignment.bottomCenter,
          child: Stack(
            children: <Widget>[
              Container(
                margin: EdgeInsets.only(left: 20, bottom: 40, right: 20),
                height: 260,
                width: double.infinity,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    boxShadow: [
                      BoxShadow(
                          blurRadius: 6,
                          spreadRadius: 0.4,
                          offset: Offset(0.1, 0.5),
                          color: Colors.blueAccent),
                    ],
                    color: Colors.blue),
              ),
              Positioned(
                top: 20,
                right: 40,
                child: InkWell(
                  onTap: _galleryButton,
                  child: Container(
                    height: 150,
                    width: 150,
                    child: columnButtonItem('images/gallery.png', 'Gallery'),
                    decoration: buttonBoxDecoration(Colors.yellow),
                  ),
                ),
              ),
              Positioned(
                top: 20,
                left: 40,
                child: InkWell(
                  onTap: _cameraButton,
                  child: Container(
                    height: 150,
                    width: 150,
                    decoration: buttonBoxDecoration(Colors.greenAccent),
                    child: columnButtonItem('images/camera.png', 'Camera'),
                  ),
                ),
              ),
              Positioned(
                top: 190,
                left: 40,
                right: 40,
                child: new SizedBox(
                  height: 50.0,
                  child: ElevatedButton.icon(
                    style: ElevatedButton.styleFrom(
                      primary: Colors.white,
                    ),
                    icon: Icon(
                      Icons.qr_code_rounded,
                      color: Colors.pink,
                      size: 24.0,
                    ),
                    label: Text(
                      'QR Code',
                      style: TextStyle(fontSize: 16, color: Colors.blue),
                    ),
                    onPressed: _qrScannerButton,
                  ),
                ),
              ),
            ],
          ),
        ),
            ],
    ));
  }

  Column titleText() {
    return Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text('what you want',
                style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w400,
                    color: Colors.black54)),
            Text('CHOOSE',
                style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold)),
          ],
        );
  }

  Widget columnButtonItem(String imgPath, String buttonText) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Image.asset(
          imgPath,
          width: 90,
          height: 90,
        ),
        Text(
          buttonText,
          style: TextStyle(color: Colors.white, fontSize: 20),
        )
      ],
    );
  }

  BoxDecoration buttonBoxDecoration(Color colors) {
    return BoxDecoration(
      borderRadius: BorderRadius.circular(20),
      color: colors,
    );
  }

  void _qrScannerButton(){
    setState(() async {
      imageSource = ImageSource.camera;
  //    final barcodeScanner = GoogleMlKit.vision.barcodeScanner();
   //   final List<Barcode> barcodes = await barcodeScanner.processImage(imagePath);
   //   print(barcodes);
      _scanner();
    });
  }

  void _cameraButton() {
    setState(() {
      imageSource = ImageSource.camera;
      _scanner();
    });
  }

  void _galleryButton() {
    setState(() {
      imageSource = ImageSource.gallery;
      _scanner();
    });
  }

  void _nextPage(CardInfo info) {
    Navigator.pushNamed(context, ScanPage.routeName, arguments: info);
  }

  void _scanner() async {
    PickedFile? file = await ImagePicker().getImage(source: imageSource);
    setState(() {
      imagePath = file!.path;
    });
    if (imagePath != null) {
      contractModel.image = imagePath;
      final inputImage = InputImage.fromFilePath(imagePath!);
      final textDetector = GoogleMlKit.vision.textDetector();
      final recognizeText = await textDetector.processImage(inputImage);
      var temp = <String>[];
      for (var block in recognizeText.blocks) {
        for (var line in block.lines) {
          temp.add(line.text);
        }
      }
      setState(() {
        linesOfList = temp;
      });
      var info = CardInfo(imagePath, linesOfList);
      _nextPage(info);
    }
  }
}
