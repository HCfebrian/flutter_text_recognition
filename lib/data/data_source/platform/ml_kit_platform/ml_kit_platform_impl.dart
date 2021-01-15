import 'dart:io';

import 'package:firebase_ml_vision/firebase_ml_vision.dart';
import 'package:flutter_text_recognition/data/data_source/platform/ml_kit_platform/ml_kit_platform_abs.dart';
import 'package:meta/meta.dart';

class MLKitPlatformImpl extends MLKitPlatformAbs {
  final TextRecognizer textRecognizer;

  MLKitPlatformImpl({@required this.textRecognizer});

  @override
  Future<String> processImage(File imageFile) async {
    final FirebaseVisionImage visionImage =
        FirebaseVisionImage.fromFile(imageFile);
    final VisionText visionText =
        await textRecognizer.processImage(visionImage);

    String result;
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
    }
    print(visionText.blocks.asMap().toString());

    return result ?? "no result";
  }
}
