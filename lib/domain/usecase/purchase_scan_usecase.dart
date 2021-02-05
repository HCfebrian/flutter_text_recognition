import 'dart:io';

import 'package:flutter_text_recognition/core/failure.dart';
import 'package:flutter_text_recognition/domain/contract_repository/camera_repo_abs.dart';
import 'package:flutter_text_recognition/domain/contract_repository/mlkit_repo_abs.dart';
import 'package:flutter_text_recognition/domain/contract_repository/pizza_repo_abs.dart';
import 'package:flutter_text_recognition/domain/contract_repository/purchase_repo_abs.dart';
import 'package:flutter_text_recognition/domain/contract_repository/similarity_repo_abs.dart';
import 'package:flutter_text_recognition/domain/entity/purchase_entity.dart';
import 'package:flutter_text_recognition/domain/entity/similarity_result.dart';
import 'package:image_picker/image_picker.dart';
import 'package:meta/meta.dart';

class PurchaseScanUsecase {
  final PurchaseRepoAbs purchaseRepo;
  final CameraRepoAbs cameraRepoAbs;
  final MLRepoAbs mlkitRepoAbs;
  final SimilarityRepoAbs similarityRepo;
  final PizzaRepoAbs pizzarepo;

  PurchaseScanUsecase({
    @required this.pizzarepo,
    @required this.purchaseRepo,
    @required this.cameraRepoAbs,
    @required this.mlkitRepoAbs,
    @required this.similarityRepo,
  });

  Future<SimilarityResult> getSimilarity() async {
    File file;
    String purchaseID, mlString, comparableDbText;
    PurchaseEntity resultDb;
    double similarityDistance;

    //get image
    try {
      file = await cameraRepoAbs.getImage(ImageSource.camera);
      print("file : " + file.path);
    } catch (_) {
      throw CameraException("Camera Fail");
    }

    //get full text using MLkit
    try {
      print("get full text called");
      mlString = await mlkitRepoAbs.getFullText(file);
      print("get full text returned " + mlString);
    } catch (_) {
      throw MLException("Failed to get Pic Text");
    }

    //get purchase id from Mlkit
    try {
      print("get purchase id called");
      purchaseID = await mlkitRepoAbs.getPurchaseID(file);
      print("purchaseID " + purchaseID.toString());
    } catch (e) {
      print(e);
      throw MLException("cannot get purchaseID");
    }

    //get data from firebase
    try {
      print("get purchase called");
      resultDb = await purchaseRepo.getPurchaseDetail(purchaseID);
      print("get purchase returned " + resultDb.workerName);
    } catch (e) {
      print(e);
      throw FirebaseException("Failed to get db text");
    }

    //get comparable string from resultDB
    try {
      print("get dbComparable Text called");
      comparableDbText = similarityRepo.getDbComparableText(
        purchaseEntity: resultDb,
      );
      print("comparable DB text " + comparableDbText);
    } catch (_) {
      throw SimilarityException("failed while comparing the data");
    }

    // compare two string from db and mlkit
    try {
      similarityDistance = similarityRepo.getSimilarity(
          databaseComparableText: comparableDbText,
          scanImageComparableText: mlString);
      print("jaccard " + similarityDistance.toString());
    } catch (_) {
      throw SimilarityException("Cannot get Similarity Distance");
    }

    // if similarity distance smaller than 0.25, update user pizza history
    if (similarityDistance < 0.25) {
      try {
        print("Update database");
        pizzarepo.addReceiptToHistory(purchaseID);
      } catch (_) {
        throw FirebaseException("Error while update database");
      }
    }

    return SimilarityResult(
      purchaseID: purchaseID,
      similarity: similarityDistance,
      confirmed: (similarityDistance < 0.25),
      cashback: resultDb.cashback,
    );
  }
}
