import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:edit_distance/edit_distance.dart';
import 'package:firebase_ml_vision/firebase_ml_vision.dart';
import 'package:flutter_text_recognition/core/failure.dart';
import 'package:flutter_text_recognition/domain/contract_repository/camera_cntract_repo.dart';
import 'package:flutter_text_recognition/domain/contract_repository/purchase_contract_repo.dart';
import 'package:flutter_text_recognition/domain/entity/purchase_order.dart';
import 'package:image_picker/image_picker.dart';
import 'package:meta/meta.dart';

class PurchaseUsecase {
  final PurchaseRepoAbs purchaseRepo;
  final CameraRepoAbs cameraRepoAbs;
  final Levenshtein levenshtein;
  final TextRecognizer textRecognizer;

  PurchaseUsecase({
    @required this.purchaseRepo,
    @required this.cameraRepoAbs,
    @required this.levenshtein,
    @required this.textRecognizer,
  });


  Future<Either<Failure, double>> getSimilarity() async {
    File fileImage;
    final file = await cameraRepoAbs.getImage(ImageSource.camera);
    file.fold((l) {
      return CameraFailure("Camera Error");
    }, (r) {
      fileImage = r;
    });

    final FirebaseVisionImage visionImage = FirebaseVisionImage.fromFile(fileImage);
    final VisionText visionText = await textRecognizer.processImage(visionImage);
    final result = visionText.text;

    print(result);
    return Right(20);

  }
}
