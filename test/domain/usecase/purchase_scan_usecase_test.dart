import 'dart:io';

import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_text_recognition/core/failure.dart';
import 'package:flutter_text_recognition/domain/contract_repository/camera_repo_abs.dart';
import 'package:flutter_text_recognition/domain/contract_repository/mlkit_repo_abs.dart';
import 'package:flutter_text_recognition/domain/contract_repository/pizza_repo_abs.dart';
import 'package:flutter_text_recognition/domain/contract_repository/purchase_repo_abs.dart';
import 'package:flutter_text_recognition/domain/contract_repository/similarity_repo_abs.dart';
import 'package:flutter_text_recognition/domain/entity/pizza_entity.dart';
import 'package:flutter_text_recognition/domain/entity/purchase_entity.dart';
import 'package:flutter_text_recognition/domain/entity/similarity_result.dart';
import 'package:flutter_text_recognition/domain/usecase/purchase_scan_usecase.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mockito/mockito.dart';

class MockPurchaseRepo extends Mock implements PurchaseRepoAbs {}

class MockCameraRepo extends Mock implements CameraRepoAbs {}

class MockMLRepo extends Mock implements MLRepoAbs {}

class MockSimilarityRepo extends Mock implements SimilarityRepoAbs {}

class MockPizzaRepo extends Mock implements PizzaRepoAbs {}

void main() {
  MockCameraRepo mockCameraRepo;
  MockMLRepo mockMLRepo;
  MockPurchaseRepo mockPurchaseRepo;
  MockSimilarityRepo mockSimilarityRepo;
  MockPizzaRepo mockPizzaRepo;
  PurchaseScanUsecase purchaseScanUsecase;

  final testFile = File("android/storage/test/somthing.jpg");

  final testReceiptId = "123456";

  final testFullText =
      "123456HERYAN69696911/01/20210435PM7201X2SUPERSUPREMEM02XBTALIANOBRUTALOXL99171";

  final PizzaHistoryEntity pizzaHistoryEntity = PizzaHistoryEntity(
      recipeId: "PZE45hViRDAWKzCCabS7",
      purchaseId: "123456",
      purchaseDate: "11/01/2021",
      purchaseQuantity: "2",
      pizzaName: "italinao pizza",
      pizzaPrice: "72",
      pizzaSize: "M",
      pizzaCal: "34",
      purchasePicUrl: "www.pizza.com/storage/test/somthing.jpg");

  final PurchaseEntity testPurchaseEntity = PurchaseEntity(
      listOrder: [pizzaHistoryEntity, pizzaHistoryEntity],
      purchaseDate: "20/11/2012",
      workerId: "696969",
      workerName: "Heryan",
      purchaseTime: "04.35 PM",
      subTotal: 72,
      balanceDue: 72,
      cashback: 10,
      purchaseId: "123456");

  final testComparableDBText =
      "123456HERYAN69696911/01/20210435PM01X2SUPERSUPREME72M02X3ITALIANOBRUTALO99XL171171";

  final SimilarityResult testSimilarity = SimilarityResult(
      similarity: 0.2,
      confirmed: true,
      purchaseID: testReceiptId,
      cashback: testPurchaseEntity.cashback);

  setUp(() {
    mockCameraRepo = MockCameraRepo();
    mockMLRepo = MockMLRepo();
    mockPurchaseRepo = MockPurchaseRepo();
    mockSimilarityRepo = MockSimilarityRepo();
    mockPizzaRepo = MockPizzaRepo();

    purchaseScanUsecase = PurchaseScanUsecase(
        purchaseRepo: mockPurchaseRepo,
        cameraRepoAbs: mockCameraRepo,
        mlkitRepoAbs: mockMLRepo,
        similarityRepo: mockSimilarityRepo,
        pizzarepo: mockPizzaRepo);
  });

  test("check are the data flow is correct", () async {
    //arrange
    when(mockCameraRepo.getImage(ImageSource.camera))
        .thenAnswer((realInvocation) async => testFile);

    when(mockMLRepo.getFullText(testFile))
        .thenAnswer((_) async => testFullText);

    when(mockMLRepo.getPurchaseID(testFile))
        .thenAnswer((_) async => testReceiptId);

    when(mockPurchaseRepo.getPurchaseDetail(testReceiptId))
        .thenAnswer((_) async => testPurchaseEntity);

    when(mockSimilarityRepo.getDbComparableText(
            purchaseEntity: testPurchaseEntity))
        .thenAnswer((realInvocation) => testComparableDBText);

    when(mockSimilarityRepo.getSimilarity(
            databaseComparableText: testComparableDBText,
            scanImageComparableText: testFullText))
        .thenReturn(0.2);

    //act
    final result = await purchaseScanUsecase.getSimilarity();
    //assert
    expect(result, testSimilarity);
  });

  test(
      "should throw camera exception, and no other transaction should be called",
      () async {
    //arrange
    when(mockCameraRepo.getImage(any)).thenThrow((_) async => Exception("any"));
    //act
    final result = purchaseScanUsecase.getSimilarity;
    //assert
    expect(() => result(), throwsA(isA<CameraException>()));
    verifyZeroInteractions(mockMLRepo);
    verifyZeroInteractions(mockPurchaseRepo);
    verifyZeroInteractions(mockSimilarityRepo);
    verifyZeroInteractions(mockPizzaRepo);
  });

  test("should throw ML exception, and no other transaction should be called",
      () async {
    //arrange
    when(mockCameraRepo.getImage(any)).thenAnswer((_) async => testFile);
    when(mockMLRepo.getFullText(testFile))
        .thenThrow((_) async => Exception("any"));
    //act
    final result = purchaseScanUsecase.getSimilarity;
    //assert
    expect(() => result(), throwsA(isA<MLException>()));

    // todo: for unknown reason this doesn't work.
    verifyNoMoreInteractions(mockMLRepo);
    verifyZeroInteractions(mockMLRepo);
    verifyZeroInteractions(mockPurchaseRepo);
    verifyZeroInteractions(mockSimilarityRepo);
    verifyZeroInteractions(mockPizzaRepo);
  });

  test("should throw ML exception, and no other transaction should be called",
      () async {
    //arrange
    when(mockCameraRepo.getImage(any)).thenAnswer((_) async => testFile);
    when(mockMLRepo.getFullText(testFile)).thenAnswer((_) async => testFullText);
    when(mockMLRepo.getPurchaseID(testFile))
        .thenThrow((_) async => Exception("any"));
    //act
    final result = purchaseScanUsecase.getSimilarity;
    //assert
    expect(() => result(), throwsA(isA<MLException>()));

    // todo: for unknown reason this doesn't work.
    verifyZeroInteractions(mockMLRepo);

    verifyZeroInteractions(mockPurchaseRepo);
    verifyZeroInteractions(mockSimilarityRepo);
    verifyZeroInteractions(mockPizzaRepo);
  });

  test(
      "should throw Firebase exception, and no other transaction should be called",
      () async {
    //arrange
    when(mockCameraRepo.getImage(any)).thenAnswer((_) async => testFile);
    when(mockMLRepo.getFullText(testFile)).thenAnswer((_) async => testFullText);
    when(mockMLRepo.getPurchaseID(testFile)).thenAnswer((_) async => testReceiptId);
    when(mockPurchaseRepo.getPurchaseDetail(testReceiptId))
        .thenThrow(() async => Exception("any"));

    //act
    final result = purchaseScanUsecase.getSimilarity;
    //assert
    expect(() => result(), throwsA(isA<FirebaseException>()));
    verifyZeroInteractions(mockPurchaseRepo);
    verifyZeroInteractions(mockSimilarityRepo);
    verifyZeroInteractions(mockPizzaRepo);
  });

  test(
      "should throw Similarity exception, and no other transaction should be called",
      () async {
    //arrange
    when(mockCameraRepo.getImage(any)).thenAnswer((_) async => testFile);
    when(mockMLRepo.getFullText(testFile)).thenAnswer((_) async => testFullText);
    when(mockMLRepo.getPurchaseID(testFile)).thenAnswer((_) async => testReceiptId);
    when(mockPurchaseRepo.getPurchaseDetail(testReceiptId))
        .thenAnswer((_) async => testPurchaseEntity);
    when(mockSimilarityRepo.getDbComparableText(
            purchaseEntity: testPurchaseEntity))
        .thenThrow((_) async => Exception("any"));

    //act
    final result = purchaseScanUsecase.getSimilarity;
    //assert
    expect(() => result(), throwsA(isA<SimilarityException>()));
    verifyZeroInteractions(mockPurchaseRepo);
    verifyZeroInteractions(mockSimilarityRepo);
    verifyZeroInteractions(mockPizzaRepo);
  });

  test(
      "should throw Similarity exception, and no other transaction should be called",
      () async {
    //arrange
    when(mockCameraRepo.getImage(any)).thenAnswer((_) async => testFile);
    when(mockMLRepo.getFullText(testFile)).thenAnswer((_) async => testFullText);
    when(mockMLRepo.getPurchaseID(any)).thenAnswer((_) async => testReceiptId);
    when(mockPurchaseRepo.getPurchaseDetail(testReceiptId))
        .thenAnswer((_) async => testPurchaseEntity);
    when(mockSimilarityRepo.getDbComparableText(
            purchaseEntity: testPurchaseEntity))
        .thenReturn(testComparableDBText);
    when(mockSimilarityRepo.getSimilarity(
      scanImageComparableText: testFullText,
      databaseComparableText: testComparableDBText,
    )).thenThrow((_) async => Exception("any"));

    //act
    final result = purchaseScanUsecase.getSimilarity;
    //assert
    expect(() => result(), throwsA(isA<SimilarityException>()));
    verifyZeroInteractions(mockPurchaseRepo);
    verifyZeroInteractions(mockSimilarityRepo);
    verifyZeroInteractions(mockPizzaRepo);
  });
}
