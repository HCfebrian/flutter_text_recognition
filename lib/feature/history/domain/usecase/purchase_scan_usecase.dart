import 'dart:io';
import 'dart:ui';
import 'package:flutter_text_recognition/feature/history/domain/contract_repository/camera_repo_abs.dart';
import 'package:flutter_text_recognition/feature/history/domain/contract_repository/mlkit_repo_abs.dart';
import 'package:flutter_text_recognition/feature/history/domain/contract_repository/pizza_repo_abs.dart';
import 'package:flutter_text_recognition/feature/history/domain/contract_repository/purchase_repo_abs.dart';
import 'package:flutter_text_recognition/feature/history/domain/contract_repository/similarity_repo_abs.dart';
import 'package:flutter_text_recognition/feature/history/domain/entity/purchase_entity.dart';
import 'package:flutter_text_recognition/feature/history/domain/entity/similarity_result.dart';
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

  bool setSize(Size size){
    return mlkitRepoAbs.setCameraSize(size);
  }

  Future<SimilarityResult> getSimilarity({File sourceFile, Size size}) async {
    File file;
    String purchaseID, mlString, comparableDbText;
    PurchaseEntity resultDb;

    //get image
    if(sourceFile == null){
      try {
        file = await cameraRepoAbs.getImage(ImageSource.camera);
        print("file : " + file.path);
      } catch (_) {
        throw Exception("Camera Fail");
      }
    }else{
      file = sourceFile;
    }

    //get full text using MLkit
    try {
      mlString = await mlkitRepoAbs.getFullText(file);
    } catch (_) {
      throw Exception("Failed to get Pic Text");
    }

    //get purchase id from Mlkit
    try {
      purchaseID = await mlkitRepoAbs.getPurchaseID(imageFile: file, size: size);
      print("purchaseID " + purchaseID.toString());
    } catch (e) {
      print(e);
      throw Exception("cannot get purchaseID");
    }

    //get data from firebase
    try {
      resultDb = await purchaseRepo.getPurchaseDetail(purchaseID);
    } catch (e) {
      print(e);
      throw Exception("Failed to get db text");
    }

    //get comparable string from resultDB
    try {
      comparableDbText = similarityRepo.getDbComparableText(
          purchaseID: purchaseID,
          workerName: resultDb.workerName,
          workerId: resultDb.workerId,
          purchaseDate: resultDb.purchaseDate,
          purchaseTime: resultDb.purchaseTime,
          listPizza: resultDb.listOrder,
          subTotal: resultDb.subTotal,
          balanceDue: resultDb.balanceDue);
    } catch (e) {
      throw Exception("failed compare data");
    }

    final similarityDistance = similarityRepo.getSimilarity(
        databaseComparableText: comparableDbText,
        scanImageComparableText: mlString);

    print("jaccard " + similarityDistance.toString());

    if (similarityDistance < 0.25) {
      print("copy receipt");
      pizzarepo.addReceiptToHistory(purchaseID);
    }

    return SimilarityResult(
      purchaseID: purchaseID,
      similarity: similarityDistance,
      confirmed: (similarityDistance < 0.25),
      cashback: resultDb.cashback,
    );
  }
}
