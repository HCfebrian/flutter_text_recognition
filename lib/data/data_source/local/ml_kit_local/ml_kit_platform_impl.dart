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
    print("full text: ");
    print(normalizeReceiptText(visionText.text));
    print("picture dimensiton :");
    var decodedImage = await decodeImageFromList(imageFile.readAsBytesSync());
    print("w: " + decodedImage.width.toString());
    print("h: " + decodedImage.height.toString());
    return normalizeReceiptText(visionText.text);
  }

  @override
  Future<String> getPurchaseId({File imageFile, Size size}) async {
    String result;


    final FirebaseVisionImage visionImage =
        FirebaseVisionImage.fromFile(imageFile);

    final VisionText visionText =
        await textRecognizer.processImage(visionImage);


    List<TextLine> potentialReceiptId = [];

    Rect iRect = Rect.fromLTRB(720 * 0.25, 1280 * 0.1, 720 * 0.75, 1280 * 0.2);

    visionText.blocks.forEach(
      (element) {
        print(element.boundingBox);
        element.lines.forEach((element) {
          print("line :");
          print(element.text);
          print(element.boundingBox);
          final topLeft = iRect.contains(element.boundingBox.topRight);
          final topRight = iRect.contains(element.boundingBox.topRight);
          final bottomRight = iRect.contains(element.boundingBox.topRight);
          final bottomLeft = iRect.contains(element.boundingBox.topRight);
          if (topLeft || topRight || bottomRight || bottomLeft) {
            print("add to potential "+element.text);
            potentialReceiptId.add(element);
          }
        });
      },
    );

    try {
      // for (int i = 0; i < visionText.blocks.length; i++) {
      //   if (result != null) break;
        for (int j = 0; j < potentialReceiptId.length; j++) {
          if (result != null) break;
          for (int k = 0;
              k < potentialReceiptId[j].elements.length;
              k++) {
            if (potentialReceiptId[j].elements[k].text
                .contains("#", 0)) {
              // print("bounding box");
              print(potentialReceiptId[j].elements[k].boundingBox);
              result = potentialReceiptId[j].elements[k].text
                  .replaceAll(RegExp('[^0-9]'), '');
              break;
            }
            // print("!!!! " + visionText.blocks[i].lines[j].text);
          // }
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
