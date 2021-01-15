import 'dart:developer';
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

class PurchaseUsecase {
  final PurchaseRepoAbs purchaseRepo;
  final CameraRepoAbs cameraRepoAbs;
  final Levenshtein levenshtein;
  final MLVisionAbs mlkitRepoAbs;

  PurchaseUsecase({
    @required this.purchaseRepo,
    @required this.cameraRepoAbs,
    @required this.levenshtein,
    @required this.mlkitRepoAbs,
  });

  Future<Either<Failure, SimilarityResult>> getSimilarity() async {
    File fileImage;
    String textResult;

    //get image
    final fileOF = await cameraRepoAbs.getImage(ImageSource.camera);
    fileOF.fold((fail) {
      return CameraFailure(fail.message);
    }, (resultImage) {
      fileImage = resultImage;
    });

    //process image
    final textResultOF = await mlkitRepoAbs.getImage(fileImage);
    textResultOF.fold((failure) => MLFailure(failure.message),
            (result) => textResult = result);

    //get data from firebase
    PurchaseEntity purchaseEntity;
    final result = await purchaseRepo.getPurchaseDetail(textResult);
    result.fold((failure) => FirebaseFailure(failure.message), (result) => purchaseEntity);


    return Right(SimilarityResult(
      imageFile: fileImage,
      text: textResult,
      similarity: 20,
    ));
  }
}
