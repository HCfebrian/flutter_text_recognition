import 'dart:developer';
import 'dart:io';
import 'dart:ui';

import 'package:firebase_ml_vision/firebase_ml_vision.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_text_recognition/core/global_variable.dart';
import 'package:flutter_text_recognition/data/data_source/local/ml_kit_local/ml_kit_local_abs.dart';
import 'package:flutter_text_recognition/data/model_converter/mlkit_full_text_normalization.dart';
import 'package:meta/meta.dart';

class MLKitPlatformImpl extends MLKitLocalAbs {
  final TextRecognizer textRecognizer;

  MLKitPlatformImpl({@required this.textRecognizer});
  Size cameraSize = GlobalVariable.size;


  @override
  bool setCameraSize(Size size) {
    return true;
  }

  @override
  Future<String> getFullText(File imageFile) async {
    final visionImage = FirebaseVisionImage.fromFile(imageFile);
    final visionText = await textRecognizer.processImage(visionImage);
    print("full text: "+ GlobalVariable.size.toString());
    print(normalizeReceiptText(visionText.text));
    return normalizeReceiptText(visionText.text);
  }

  @override
  Future<String> getPurchaseId({File imageFile, Size size}) async {
    String result;

    final Rect rectId = Rect.fromLTRB(GlobalVariable.size.width * 0.25, GlobalVariable.size.height * 0.2,
        GlobalVariable.size.width * 0.75, GlobalVariable.size.height * 0.15);

    final FirebaseVisionImage visionImage =
        FirebaseVisionImage.fromFile(imageFile);

    final VisionText visionText =
        await textRecognizer.processImage(visionImage);

    var image = await decodeImageFromList(imageFile.readAsBytesSync());

    // print("image "+ image.toString());
    // print("width scale "+ image.width.toString());
    // print("height scale "+ image.height.toString());
    double widthScale =  814.5/ image.width;
    double heightScale =  392.7  / image.height;
    // print("print size w "+ cameraSize.width.toString());toString
    // print("print size h "+ cameraSize.height.toString());
    print("width scale "+ widthScale.toString());
    print("height scale "+ heightScale.toString());

    List<TextBlock> potentialReceiptId = [];

    visionText.blocks.forEach(
      (element) {

        print(element.boundingBox);
        final imageRact = Rect.fromLTRB(
            element.boundingBox.left * widthScale,
            element.boundingBox.top * heightScale,
            element.boundingBox.right * widthScale,
            element.boundingBox.bottom * heightScale);

        print("before scaling "+element.boundingBox.toString());
        print("after scaling "+imageRact.toString());
        print("react id rect "+ rectId.toString());

        Rect rectText = element.boundingBox;
        final bool point1 = rectId.contains(imageRact.topLeft);
        final bool point2 = rectId.contains(imageRact.bottomLeft);
        final bool point3 = rectId.contains(imageRact.topRight);
        final bool point4 = rectId.contains(imageRact.bottomRight);
        print(point1.toString() +
            point2.toString() +
            point3.toString() +
            point4.toString());
        if (point1 || point2 || point3 || point4) {
          potentialReceiptId.add(element);
        }
      },
    );
    log("original text block" + visionText.blocks.length.toString());
    log("ID text block" + potentialReceiptId.length.toString());

    try {
      for (int i = 0; i < visionText.blocks.length; i++) {
        if (result != null) break;
        for (int j = 0; j < visionText.blocks[i].lines.length; j++) {
          if (result != null) break;
          for (int k = 0;
              k < visionText.blocks[i].lines[j].elements.length;
              k++) {
            if (visionText.blocks[i].lines[j].elements[k].text
                .contains("#", 0)) {
              // print("bounding box");
              print(visionText.blocks[i].lines[j].elements[k].boundingBox);
              result = visionText.blocks[i].lines[j].elements[k].text
                  .replaceAll(RegExp('[^0-9]'), '');
              break;
            }
            // print("!!!! " + visionText.blocks[i].lines[j].text);
          }
          print(visionText.blocks[i].text);
        }
      }
      print("ID " + result.toString());
    } catch (e) {
      print(e);
      throw Exception("iteration failed");
    }
    if (result != null) {
      return result;
    } else {
      throw Exception("Purchase ID not detected");
    }
  }


}
