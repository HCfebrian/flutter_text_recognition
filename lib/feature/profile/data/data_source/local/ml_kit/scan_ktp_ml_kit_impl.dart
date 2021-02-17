import 'dart:io';
import 'dart:ui';
import 'package:meta/meta.dart';

import 'package:firebase_ml_vision/firebase_ml_vision.dart';
import 'package:flutter_text_recognition/feature/profile/data/data_source/local/ml_kit/scan_ktp_ml_kit_abs.dart';
import 'package:flutter_text_recognition/feature/profile/domain/entity/user_data_entity.dart';

class ScanKtpMlKitImpl implements ScanKtpMlKitAbs {
  final TextRecognizer textRecognizer;

  ScanKtpMlKitImpl({@required this.textRecognizer});

  @override
  Future<UserDataEntity> scanKtp({File fileImage}) async {
    final firebaseVision = FirebaseVisionImage.fromFile(fileImage);
    final visionText = await textRecognizer.processImage(firebaseVision);

    print("ktp");
    print(visionText.text);

    String nameResult;
    String alamatResult;
    String tglLahirResult;
    String agamaResult;
    String statusKawinResult;

    Rect namaRect;
    Rect alamatRect;
    Rect tanggalLahirRect;
    Rect agamaRect;
    Rect statusKawinRect;

    try {
      for (int i = 0; i < visionText.blocks.length; i++) {
        for (int j = 0; j < visionText.blocks[i].lines.length; j++) {
          for (int k = 0;
              k < visionText.blocks[i].lines[j].elements.length;
              k++) {
            final data = visionText.blocks[i].lines[j].elements[k];
            print("b$i l$j e$k " +
                data.text.toLowerCase().trim().replaceAll(" ", "") +
                " " +
                data.boundingBox.toString());

            if (data.text.toLowerCase() == "nama") {
              final temp = data.boundingBox;
              namaRect = Rect.fromLTRB(
                  temp.left, temp.top + 5, temp.right, temp.bottom + 5);
              print("nama run");
            }

            if (data.text.toLowerCase().trim() == "lahir") {
              final temp = data.boundingBox;
              tanggalLahirRect = Rect.fromLTRB(
                  temp.left, temp.top + 5, temp.right, temp.bottom + 5);
              print("tgllahir run");
            }

            if (data.text.toLowerCase().trim() == "alamat") {
              final temp = data.boundingBox;
              alamatRect = Rect.fromLTRB(
                  temp.left, temp.top + 5, temp.right, temp.bottom + 5);
              print("alamat run");
            }

            if (data.text.toLowerCase().trim() == "agama") {
              final temp = data.boundingBox;
              agamaRect = Rect.fromLTRB(
                  temp.left, temp.top + 5, temp.right, temp.bottom + 5);
              print("agama run");
            }

            if (data.text.toLowerCase().trim() == "perkawinan") {
              final temp = data.boundingBox;
              statusKawinRect = Rect.fromLTRB(
                  temp.left, temp.top + 5, temp.right, temp.bottom + 5);
              print("statusKawin run");
            }
          }
        }
      }
    } catch (e) {
      print(e);
      throw Exception("iteration failed");
    }

    try {
      for (int i = 0; i < visionText.blocks.length; i++) {
        for (int j = 0; j < visionText.blocks[i].lines.length; j++) {
          final data = visionText.blocks[i].lines[j];
          if (isInside(data.boundingBox, namaRect)) {
            nameResult = data.text;
            print("------ name");
            print(nameResult);
          }
          if (isInside(data.boundingBox, alamatRect)) {
            alamatResult = data.text;
            print("------ alamat");
            print(alamatResult);
          }
          if (isInside(data.boundingBox, tanggalLahirRect)) {
            tglLahirResult = data.text;
            print("------ tgllahir");
            print(tglLahirResult);
          }
          if (isInside(data.boundingBox, agamaRect)) {
            agamaResult = data.text;
            print("------ agama");
            print(agamaResult);
          }
          if (isInside(data.boundingBox, statusKawinRect)) {
            statusKawinResult = data.text;
            print("------ ");
            print(statusKawinResult);
          }
        }
      }
    } catch (e) {
      print(e);
      throw Exception("iteration failed jhooon");
    }

    print("result");
    print(nameResult.toString());
    print(alamatResult.toString());
    print(tglLahirResult.toString());
    print(agamaResult.toString());
    print(statusKawinResult.toString());
  }

  bool isInside(Rect rect1, Rect rect2) {
    if (rect1 == null) {
      return false;
    }
    if(rect2 == null){
      return false;
    }
    if (rect1.contains(rect2.center)) {
      return false;
    }
    if (rect2.contains(rect1.center)) {
      return false;
    }
    return true;
  }
}
