import 'dart:io';

import 'package:firebase_ml_vision/firebase_ml_vision.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_text_recognition/core/global_variable.dart';
import 'package:flutter_text_recognition/feature/history/data/data_source/local/ml_kit_local/ml_kit_local_abs.dart';
import 'package:flutter_text_recognition/feature/history/data/entity_converter/mlkit_full_text_normalization.dart';
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
    print("picture dimension :");
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
    var decodedImage = await decodeImageFromList(imageFile.readAsBytesSync());

    Rect iRect = Rect.fromLTRB(
        decodedImage.width * 0.25,
        decodedImage.height * 0.1,
        decodedImage.width * 0.75,
        decodedImage.height * 0.2);

    visionText.blocks.forEach(
      (block) {
        print(block.boundingBox);
        block.lines.forEach((line) {
          print("line :");
          print(line.text);
          print(line.boundingBox);
          final topLeft = iRect.contains(line.boundingBox.topRight);
          final topRight = iRect.contains(line.boundingBox.topRight);
          final bottomRight = iRect.contains(line.boundingBox.topRight);
          final bottomLeft = iRect.contains(line.boundingBox.topRight);
          if (topLeft || topRight || bottomRight || bottomLeft) {
            print("add to potential " + line.text);
            potentialReceiptId.add(line);
          }
        });
      },
    );

    try {
      // for (int i = 0; i < visionText.blocks.length; i++) {
      //   if (result != null) break;
      for (int j = 0; j < potentialReceiptId.length; j++) {
        if (result != null) break;
        for (int k = 0; k < potentialReceiptId[j].elements.length; k++) {
          if (potentialReceiptId[j].elements[k].text.contains("#", 0)) {
            // print("bounding box");
            print("id");
            print(potentialReceiptId[j].elements[k].boundingBox);
            result = potentialReceiptId[j]
                .elements[k]
                .text
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
