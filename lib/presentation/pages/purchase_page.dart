import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';
import 'package:firebase_ml_vision/firebase_ml_vision.dart';
import 'package:cloud_firestore/cloud_firestore.dart';



class PurchasePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

  }
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  File _image;
  String result = "Loading";
  final picker = ImagePicker();
  final TextRecognizer textRecognizer =
  FirebaseVision.instance.textRecognizer();
  final DocumentTextRecognizer cloudDocumentTextRecognizer =
  FirebaseVision.instance.cloudDocumentTextRecognizer();
  final FirebaseFirestore firestore = FirebaseFirestore.instance;

  Future processImage() async {
    final pickedFile = await picker.getImage(source: ImageSource.camera);
    final FirebaseVisionImage visionImage =
    FirebaseVisionImage.fromFile(File(pickedFile.path));
    final VisionText visionText =
    await textRecognizer.processImage(visionImage);

    setState(() {
      if (pickedFile != null) {
        _image = File(pickedFile.path);
        result = visionText.text;
      } else {
        print("no image seleted");
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Image Picker Example"),
      ),
      body: SlidingUpPanel(
        minHeight: 150,
        body: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            _image == null ? Text("No image selected") : Image.file(_image),
          ],
        ),
        panelBuilder: (ScrollController sc) {
          return ResultWidget(
            sc: sc,
            result: result,
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: ()async{
          try {
            final purchaseHistory =
            firestore.collection("purchase_history").doc("123454");

            await purchaseHistory.get().then((value) => print(value.data()),
                onError: (e) {
                  print(e.toString());
                });
          } catch (e) {
            print(e.toString());
          }
        },
        tooltip: "Pick Image",
        child: Icon(Icons.add),
      ),
    );
  }
}

class ResultWidget extends StatelessWidget {
  final String result;
  final sc;

  const ResultWidget({
    Key key,
    this.result = "loading",
    this.sc,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(left: 20, top: 10),
      child: ListView.builder(
          itemCount: 1,
          controller: sc,
          itemBuilder: (BuildContext context, int index) {
            return Column(children: [
              Center(
                child: Container(
                  padding: EdgeInsets.symmetric(vertical: 10),
                  child: Text(
                    "result".toUpperCase(),
                    style: TextStyle(fontSize: 25, fontWeight: FontWeight.w700),
                  ),
                ),
              ),
              Align(alignment: Alignment.center, child: Text(result))
            ]);
          }),
    );
  }
}
