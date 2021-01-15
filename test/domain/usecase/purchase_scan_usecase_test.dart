import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:edit_distance/edit_distance.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_text_recognition/core/failure.dart';
import 'package:flutter_text_recognition/domain/contract_repository/camera_repo_abs.dart';
import 'package:flutter_text_recognition/domain/contract_repository/mlkit_repo_abs.dart';
import 'package:flutter_text_recognition/domain/contract_repository/purchase_repo_abs.dart';
import 'package:flutter_text_recognition/domain/entity/purchase_order.dart';
import 'package:flutter_text_recognition/domain/entity/similarity_result.dart';
import 'package:flutter_text_recognition/domain/usecase/purchase_scan_usecase.dart';
import 'package:mockito/mockito.dart';

class MockPurchaseRepo extends Mock implements PurchaseRepoAbs {}

class MockCameraRepo extends Mock implements CameraRepoAbs {}

class MockMLRepo extends Mock implements MLRepoAbs {}

class MockLevenshtein extends Mock implements Levenshtein {}

class MockJaccard extends Mock implements Jaccard {}

void main() {
  MockCameraRepo mockCameraRepo;
  MockMLRepo mockMLRepo;
  MockPurchaseRepo mockPurchaseRepo;
  Levenshtein mockLevenshtein;
  Jaccard mockJaccard;

  PurchaseScanUsecase purchaseScanUsecase;

  setUp(() {
    mockCameraRepo = MockCameraRepo();
    mockMLRepo = MockMLRepo();
    mockPurchaseRepo = MockPurchaseRepo();
    mockLevenshtein = Levenshtein();
    mockJaccard = Jaccard();

    purchaseScanUsecase = PurchaseScanUsecase(
        purchaseRepo: mockPurchaseRepo,
        cameraRepoAbs: mockCameraRepo,
        levenshtein: mockLevenshtein,
        mlkitRepoAbs: mockMLRepo,
        jaccard: mockJaccard);
  });

  File testFile = File("test");
  PurchaseEntity testPurchase = PurchaseEntity(
      "20",
      "description",
      "item",
      "lineTotal",
      "purchaseOrderDate",
      "quantity",
      "shipTo",
      "shippingMethod",
      "shippingTerms",
      "subTotal",
      "tax",
      "total",
      "cost",
      "vendor",
      "purchaseId",
      "fullText");

  SimilarityResult testSimilarity = SimilarityResult(
      similarity: 1,
      imageFile: testFile,
      textFromDb: "fullText",
      textFromMl: "fullText");

  group("test getSimilarity usecase", () {
    test("should return similarity index", () async {
      //arrange
      when(mockCameraRepo.getImage(any))
          .thenAnswer((realInvocation) async => Right(testFile));
      when(mockMLRepo.getPurchaseID(testFile))
          .thenAnswer((realInvocation) async => Right("123"));
      when(mockPurchaseRepo.getPurchaseDetail("123"))
          .thenAnswer((realInvocation) async => Right(testPurchase));
      when(mockMLRepo.getFullText(testFile))
          .thenAnswer((realInvocation) async => Right("fullText 2"));

      //act
      final result = await purchaseScanUsecase.getSimilarity();
      //assert
      expect(result, Right(testSimilarity));
    });

    test("should return Firebase Failure", () async{
      //arrange
      when(mockCameraRepo.getImage(any))
          .thenAnswer((realInvocation) async => Right(testFile));
      when(mockMLRepo.getPurchaseID(testFile))
          .thenAnswer((realInvocation) async => Right("123"));
      when(mockMLRepo.getFullText(testFile))
          .thenAnswer((realInvocation) async => Right("fullText 2"));
      when(mockPurchaseRepo.getPurchaseDetail("123"))
          .thenAnswer((realInvocation) async => Left(FirebaseFailure("camera failure")));

      //act
      final result = await purchaseScanUsecase.getSimilarity();

      //assert
      expect(result, Left(CameraFailure("camera failure")));

    });


  });
}
