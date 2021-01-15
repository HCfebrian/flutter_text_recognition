import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:edit_distance/edit_distance.dart';
import 'package:flutter_text_recognition/core/failure.dart';
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

  Future<Either<Failure, SimilarityResult>> getSimilarity() async {
    File fileImage;
    String purchaseId;
    String mlString;
    PurchaseEntity purchaseEntity;

    //get image
    final fileOF = await cameraRepoAbs.getImage(ImageSource.camera);
    fileOF.fold((fail) => Left(CameraFailure(fail.message)), (resultImage) {
      fileImage = resultImage;
    });

    //get purchase id
    final purchaseOrFailure = await mlkitRepoAbs.getPurchaseID(fileImage);
    purchaseOrFailure.fold((failure) => Left(MLFailure(failure.message)),
        (result) => purchaseId = result);
    print("purchaseID " + purchaseId.toString());

    //get mlkit full string
    final mlStringOrFailure = await mlkitRepoAbs.getFullText(fileImage);
    mlStringOrFailure.fold((failure) => Left(MLFailure(failure.message)),
        (mlText) => mlString = mlText);
    print("ml text " + mlString);

    //get data from firebase
    final result = await purchaseRepo.getPurchaseDetail(purchaseId);
    result.fold((failure) {
      print("log failure");
      return Left(FirebaseFailure(failure.message));
    }, (result) {
      print("log result");
      return purchaseEntity = result;
    });
    print("db text " + purchaseEntity.fullText);

    // get similarity
    final similarity = levenshtein.distance(mlString, purchaseEntity.fullText);
    final jaccardSim = jaccard.normalizedDistance(
        mlString.replaceAll(" ", "").replaceAll(".", "").replaceAll(",", ""),
        purchaseEntity.fullText
            .replaceAll(" ", "")
            .replaceAll(".", "")
            .replaceAll(",", ""));

    print("levenshtein " + similarity.toString());
    print("jaccard " + jaccardSim.toString());

    return Right(
      SimilarityResult(
        imageFile: fileImage,
        textFromDb: purchaseEntity.fullText,
        similarity: jaccardSim,
        textFromMl: mlString,
      ),
    );
  }
}
