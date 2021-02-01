import 'dart:io';

import 'package:firebase_ml_vision/firebase_ml_vision.dart';
import 'package:flutter_text_recognition/data/data_source/local/ml_kit_local/ml_kit_local_abs.dart';
import 'package:flutter_text_recognition/data/model_converter/mlkit_full_text_normalization.dart';
import 'package:meta/meta.dart';

class MLKitPlatformImpl extends MLKitLocalAbs {
  final TextRecognizer textRecognizer;

  MLKitPlatformImpl({@required this.textRecognizer});

  @override
  Future<String> getFullText(File imageFile) async {
    final visionImage = FirebaseVisionImage.fromFile(imageFile);
    final visionText = await textRecognizer.processImage(visionImage);
    print("full text: ");
    print(normalizeReceiptText(visionText.text));
    return normalizeReceiptText(visionText.text);
  }

  @override
  Future<String> getPurchaseId(File imageFile) async {
    String result;

    final FirebaseVisionImage visionImage =
        FirebaseVisionImage.fromFile(imageFile);
    final VisionText visionText =
        await textRecognizer.processImage(visionImage);

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
              result = visionText.blocks[i].lines[j].elements[k].text
                  .replaceAll(RegExp('[^0-9]'), '');
              break;
            }
            print("!!!! " + visionText.blocks[i].lines[j].text);
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
