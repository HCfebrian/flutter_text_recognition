import 'dart:io';

import 'package:edit_distance/edit_distance.dart';

import 'package:flutter_text_recognition/domain/contract_repository/camera_repo_abs.dart';
import 'package:flutter_text_recognition/domain/contract_repository/mlkit_repo_abs.dart';
import 'package:flutter_text_recognition/domain/contract_repository/purchase_repo_abs.dart';
import 'package:flutter_text_recognition/domain/entity/purchase_order.dart';
import 'package:flutter_text_recognition/domain/entity/similarity_result.dart';
import 'package:image_picker/image_picker.dart';
import 'package:meta/meta.dart';

class PurchaseScanUsecase {
  final PurchaseRepoAbs purchaseRepo;
  final CameraRepoAbs cameraRepoAbs;
  final Levenshtein levenshtein;
  final Jaccard jaccard;
  final MLRepoAbs mlkitRepoAbs;

  PurchaseScanUsecase({
    @required this.purchaseRepo,
    @required this.cameraRepoAbs,
    @required this.levenshtein,
    @required this.mlkitRepoAbs,
    @required this.jaccard,
  });

  Future<SimilarityResult> getSimilarity() async {
    File file;
    String purchaseID, mlString;
    PurchaseEntity resultDb;

    //get image
    try {
      file = await cameraRepoAbs.getImage(ImageSource.camera);
      print("file : "+file.path);
    } catch (_) {
      throw Exception("Camera Fail");
    }

    //get purchase id
    try {
      purchaseID = await mlkitRepoAbs.getPurchaseID(file);
      print("purchaseID " + purchaseID.toString());
    } catch (_) {
      throw Exception("Faild to get PurchaseId");
    }

    //get mlkit full string
    try {
      mlString = await mlkitRepoAbs.getFullText(file);
    } catch (_) {
      throw Exception("Failed to get Pic Text");
    }

    //get data from firebase
    try {
      resultDb = await purchaseRepo.getPurchaseDetail(purchaseID);
      print("db text " + resultDb.fullText);
    } catch (_) {
      throw Exception("Failed to get db text");
    }

    // get similarity
    final similarity = levenshtein.distance(mlString, resultDb.fullText);
    final jaccardSim = jaccard.normalizedDistance(
        mlString.replaceAll(" ", "").replaceAll(".", "").replaceAll(",", ""),
        resultDb.fullText
            .replaceAll(" ", "")
            .replaceAll(".", "")
            .replaceAll(",", ""));

    print("levenshtein " + similarity.toString());
    print("jaccard " + jaccardSim.toString());

    return SimilarityResult(
      imageFile: file,
      textFromDb: resultDb.fullText,
      similarity: jaccardSim,
      textFromMl: mlString,
    );
  }
}
