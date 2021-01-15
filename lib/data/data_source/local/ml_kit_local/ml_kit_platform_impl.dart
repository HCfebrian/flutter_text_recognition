import 'dart:io';

import 'package:firebase_ml_vision/firebase_ml_vision.dart';
import 'package:flutter_text_recognition/data/data_source/local/ml_kit_local/ml_kit_local_abs.dart';
import 'package:meta/meta.dart';

class MLKitPlatformImpl extends MLKitLocalAbs {
  final TextRecognizer textRecognizer;

  MLKitPlatformImpl({@required this.textRecognizer});

  @override
  Future<String> getFullText(File imageFile) async {
    final visionImage = FirebaseVisionImage.fromFile(imageFile);
    final visionText = await textRecognizer.processImage(visionImage);
    return visionText.text;
  }

  @override
  Future<String> getPurchaseId(File imageFile) async {
    String result;

    final FirebaseVisionImage visionImage =
        FirebaseVisionImage.fromFile(imageFile);
    final VisionText visionText =
        await textRecognizer.processImage(visionImage);

    try {
      visionText.blocks.forEach((element) {
        element.lines.forEach((element) {
          final numberNotEmpty = num.tryParse(element.text);
          if (element.text.length == 6 && numberNotEmpty != null) {
            result = element.text;
          }
        });
      });
      print(result.length);
    } catch (e) {
      print(e);
      throw Exception("iteration failed");
    }

    return result ?? "no result";
  }
}
