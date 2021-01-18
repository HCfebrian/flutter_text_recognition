import 'dart:io';

import 'package:edit_distance/edit_distance.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_text_recognition/domain/contract_repository/camera_repo_abs.dart';
import 'package:flutter_text_recognition/domain/contract_repository/mlkit_repo_abs.dart';
import 'package:flutter_text_recognition/domain/contract_repository/purchase_repo_abs.dart';
import 'package:flutter_text_recognition/domain/entity/purchase_order.dart';
import 'package:flutter_text_recognition/domain/entity/similarity_result.dart';
import 'package:flutter_text_recognition/domain/usecase/purchase_scan_usecase.dart';
import 'package:image_picker/image_picker.dart';
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
  File testFile;
  PurchaseEntity testPurchase;
  SimilarityResult testSimilarity;

  setUp(() {
    mockCameraRepo = MockCameraRepo();
    mockMLRepo = MockMLRepo();
    mockPurchaseRepo = MockPurchaseRepo();
    mockLevenshtein = Levenshtein();
    mockJaccard = Jaccard();
    testFile = File("android/storage/test");

    purchaseScanUsecase = PurchaseScanUsecase(
        purchaseRepo: mockPurchaseRepo,
        cameraRepoAbs: mockCameraRepo,
        levenshtein: mockLevenshtein,
        mlkitRepoAbs: mockMLRepo,
        jaccard: mockJaccard);

    testPurchase = PurchaseEntity(
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

    testSimilarity = SimilarityResult(
        similarity: 1,
        imageFile: testFile,
        textFromDb: "fullText",
        textFromMl: "fullText");
  });

  group("test getSimilarity usecase", () {
    test("should return similarity index", () async {
      //arrange
      when(mockCameraRepo.getImage(any))
          .thenAnswer((realInvocation) async => testFile);
      when(mockMLRepo.getPurchaseID(testFile))
          .thenAnswer((realInvocation) async => "123");
      when(mockPurchaseRepo.getPurchaseDetail("123"))
          .thenAnswer((realInvocation) async => testPurchase);
      when(mockMLRepo.getFullText(testFile))
          .thenAnswer((realInvocation) async => "fullText 2");

      //act
      final result = await purchaseScanUsecase.getSimilarity();
      //assert
      expect(result, testSimilarity);
    });

    test("should throw camera error", () async {
      //arrange
      when(mockCameraRepo.getImage(any))
          .thenThrow((realInvocation) async => Exception("any"));
      when(mockMLRepo.getPurchaseID(testFile))
          .thenAnswer((realInvocation) async => "123");
      when(mockPurchaseRepo.getPurchaseDetail("123"))
          .thenAnswer((realInvocation) async => testPurchase);
      when(mockMLRepo.getFullText(testFile))
          .thenAnswer((realInvocation) async => "fullText 2");

      //act
      final result = purchaseScanUsecase.getSimilarity;
      //assert
      expect(() => result(), throwsException);
    });

    test("should throw purchesID error", () async {
      //arrange
      when(mockCameraRepo.getImage(any))
          .thenAnswer((realInvocation) async => testFile);
      when(mockMLRepo.getPurchaseID(testFile))
          .thenThrow((realInvocation) async => Exception("any"));
      when(mockPurchaseRepo.getPurchaseDetail("123"))
          .thenAnswer((realInvocation) async => testPurchase);
      when(mockMLRepo.getFullText(testFile))
          .thenAnswer((realInvocation) async => "fullText 2");

      //act
      final result = purchaseScanUsecase.getSimilarity;
      //assert
      expect(await mockCameraRepo.getImage(ImageSource.camera), testFile);
      expect(() => result(), throwsException);
    });

    test("should throw fullString error", () async {
      //arrange
      when(mockCameraRepo.getImage(any))
          .thenAnswer((realInvocation) async => testFile);
      when(mockMLRepo.getPurchaseID(testFile))
          .thenAnswer((realInvocation) async => "123");
      when(mockPurchaseRepo.getPurchaseDetail("123"))
          .thenThrow((realInvocation) async => Exception());
      when(mockMLRepo.getFullText(testFile))
          .thenAnswer((realInvocation) async => "fullText 2");

      //act
      final result = purchaseScanUsecase.getSimilarity;
      //assert
      expect(await mockCameraRepo.getImage(ImageSource.camera), testFile);
      expect(await mockMLRepo.getPurchaseID(testFile), "123");
      expect(() => result(), throwsException);
    });

    test("should throw fullTextError", () async {
      //arrange
      when(mockCameraRepo.getImage(any))
          .thenAnswer((realInvocation) async => testFile);
      when(mockMLRepo.getPurchaseID(testFile))
          .thenAnswer((realInvocation) async => "123");
      when(mockPurchaseRepo.getPurchaseDetail("123"))
          .thenAnswer((realInvocation) async => testPurchase);
      when(mockMLRepo.getFullText(testFile))
          .thenThrow((realInvocation) async => Exception());

      //act
      final result = purchaseScanUsecase.getSimilarity;
      //assert
      expect(await mockCameraRepo.getImage(ImageSource.camera), testFile);
      expect(await mockMLRepo.getPurchaseID(testFile), "123");
      expect(await mockPurchaseRepo.getPurchaseDetail("123"), testPurchase);
      expect(() => result(), throwsException);
    });
  });
}
