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

    String nameResult = "";
    String alamatResult = "";
    String tglLahirResult = "";
    String agamaResult = "";
    String statusKawinResult = "";

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

            if (data.text.toLowerCase() == "nama" ||
                data.text.toLowerCase() == "nema" ||
                data.text.toLowerCase() == "name") {
              final temp = data.boundingBox;
              namaRect =
                  Rect.fromLTRB(temp.left, temp.top, temp.right, temp.bottom);
              print("nama run");
            }

            if (data.text.toLowerCase().trim() == "lahir" ||
                data.text.toLowerCase().trim() == "tempat" ||
                data.text.toLowerCase().trim() == "tempat/tgl") {
              final temp = data.boundingBox;
              tanggalLahirRect =
                  Rect.fromLTRB(temp.left, temp.top, temp.right, temp.bottom);
              print("tgllahir run");
            }

            if (data.text.toLowerCase().trim() == "alamat") {
              final temp = data.boundingBox;
              alamatRect =
                  Rect.fromLTRB(temp.left, temp.top, temp.right, temp.bottom);
              print("alamat run");
            }

            if (data.text.toLowerCase().trim() == "agama") {
              final temp = data.boundingBox;
              agamaRect =
                  Rect.fromLTRB(temp.left, temp.top, temp.right, temp.bottom);
              print("agama run");
            }

            if (data.text.toLowerCase().trim() == "perkawinan" ||
                data.text.toLowerCase().trim() == "perkawinan:") {
              final temp = data.boundingBox;
              statusKawinRect =
                  Rect.fromLTRB(temp.left, temp.top, temp.right, temp.bottom);
              print("statusKawin run");
            }
          }
        }
      }
    } catch (e) {
      print(e);
      throw Exception("iteration failed");
    }

    print("nama rect " + namaRect.toString());
    print("alamat rect " + alamatRect.toString());
    print("tanggalLahir rect " + tanggalLahirRect.toString());
    print("agama rect " + agamaRect.toString());
    print("statusKawin rect " + statusKawinRect.toString());

    try {
      for (int i = 0; i < visionText.blocks.length; i++) {
        for (int j = 0; j < visionText.blocks[i].lines.length; j++) {
          final data = visionText.blocks[i].lines[j];

          if (isInside3rect(
              isThisRect: data.boundingBox,
              isInside: namaRect,
              andAbove: tanggalLahirRect)) {
            if (data.text.toLowerCase() != "nama") {
              nameResult = (nameResult + " " + data.text)
                  .replaceAll("Nema", "")
                  .replaceAll(":", "")
                  .trim();
              print("------ name");
              print(nameResult);
            }
          }
          if (namaRect == null) {
            print("namaRect null bosku");
          }

          if (isInside3rect(
              isThisRect: data.boundingBox,
              isInside: alamatRect,
              andAbove: agamaRect)) {
            if (data.text.toLowerCase() != "alamat") {
              alamatResult = alamatResult + " " + data.text;
              alamatResult = alamatResult
                  .replaceAll("Kecamatan", "")
                  .replaceAll("RTIRW", "")
                  .replaceAll("RT/RW", "")
                  .replaceAll(":", "")
                  .replaceAll("Kel/Desa", "")
                  .replaceAll("KeVDesa", "")
                  .replaceAll("KeVDes", "")
                  .replaceAll("Kei/Desa", "")
                  .replaceAll("Keli/Desa", "")
                  .replaceAll("Kevbesa", "")
                  .replaceAll("Kell/Desa", "")
                  .replaceAll("elDesa", "")
                  .replaceAll("KellDesa", "")
                  .replaceAll("KelDesa", "")
                  .replaceAll("RT", "")
                  .replaceAll("RW", "")
                  .trim();
              print("------ alamat");
              print(alamatResult);
            }
          }
          if (alamatRect == null) {
            print("alamatRect null bosku");
          }

          if (isInside(data.boundingBox, tanggalLahirRect)) {
            final temp = data.text.replaceAll("Tempat/Tgi Lahir", "");
            final result = temp.substring(0, temp.indexOf(',') + 1);
            print(result);
            if (result != null && result.isNotEmpty) {
              tglLahirResult =
                  temp.replaceAll(result, "").replaceAll(":", "").trim();
            }
            print("------ tgllahir");
            print(tglLahirResult);
          }
          if (tanggalLahirRect == null) {
            print("tglLahirRect null bosku");
          }

          if (isInside(data.boundingBox, agamaRect)) {
            if (data.text.toLowerCase() != "agama") {
              agamaResult = data.text.replaceAll("Agama", "ƒ");
              print("------ agama");
              print(agamaResult);
            }
          }
          if (agamaRect == null) {
            print("agamaRect null bosku");
          }

          if (isInside(data.boundingBox, statusKawinRect)) {
            statusKawinResult = data.text
                .replaceAll("Status Perkawinan", "")
                .replaceAll(":", "")
                .trim();
            print("------ status kawin result ");
            print(statusKawinResult);
          }
          if (statusKawinRect == null) {
            print("kawin result null bosku");
          }
        }
      }
    } catch (e) {
      print(e);
      throw Exception("iteration failed jhooon");
    }

    print("result");
    print("nama : " + nameResult.toString());
    print("alamat : " + alamatResult.toString());
    print("tglLahir : " + tglLahirResult.toString());
    print("agama : " + agamaResult.toString());
    print("status kawin : " + statusKawinResult.toString());

    return UserDataEntity(
        namaLengkap: nameResult,
        tanggalLahir: tglLahirResult,
        alamat: alamatResult,
        agama: agamaResult,
        statusPerkawinan: statusKawinResult);
  }

  bool isInside(Rect rect1, Rect rect2) {
    if (rect1 == null) {
      return false;
    }

    if (rect2 == null) {
      return false;
    }

    if (rect1.center.dy <= rect2.bottom &&
        rect1.center.dy >= rect2.top &&
        rect1.center.dx <= 290) {
      return true;
    }
    return false;
  }

  bool isInside3rect({Rect isThisRect, Rect isInside, Rect andAbove}) {
    if (isThisRect == null) {
      return false;
    }

    if (isInside == null) {
      return false;
    }
    if (andAbove == null) {
      return false;
    }

    if (isThisRect.center.dy <= andAbove.top &&
        isThisRect.center.dy >= isInside.top) {
      return true;
    }
    return false;
  }
}
