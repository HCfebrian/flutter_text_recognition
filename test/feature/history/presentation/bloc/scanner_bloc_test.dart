import 'dart:io';

import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_text_recognition/feature/history/domain/entity/similarity_result.dart';
import 'package:flutter_text_recognition/feature/history/domain/usecase/purchase_scan_usecase.dart';
import 'package:flutter_text_recognition/feature/history/presentation/bloc/scaner/scanner_bloc.dart';
import 'package:mockito/mockito.dart';

class MockPurchaseScanUsecase extends Mock implements PurchaseScanUsecase {}

void main() {
  MockPurchaseScanUsecase purchaseScanUsecase;
  ScannerBloc scannerBloc;
  setUp(() {
    purchaseScanUsecase = MockPurchaseScanUsecase();
    scannerBloc = ScannerBloc(purchaseScanUsecase: purchaseScanUsecase);
  });

  final tSimilarityResult = SimilarityResult(
    similarityDistance: 0.1,
    confirmed: true,
    purchaseID: "123456789",
    cashback: 2,
  );
  final tSimilarityNotConfirmed = SimilarityResult(
    similarityDistance: 0.1,
    confirmed: false,
    purchaseID: "123456789",
    cashback: 2,
  );

  final tFilePath = File("/test/test/tes.jpg");

  test(
    "should yield ScannerConfirmedState when similaritydistance is below 0.25",
    () async {
      //arrange
      when(purchaseScanUsecase.getSimilarity(sourceFile: anyNamed("sourceFile")))
          .thenAnswer((_) async => tSimilarityResult);
      //assert
      final expected = [
        ScannerInitial(),
        ScannerConfirmedState(tSimilarityResult.cashback)
      ];
      expectLater(scannerBloc, emitsInOrder(expected));
      //act
      scannerBloc.add(ScanReceiptEvent(path: tFilePath));
    },
  );

  test(
    "should yield ScannerNotConfirmedState when similarityDistance is above 0.25",
        () async {
      //arrange
      when(purchaseScanUsecase.getSimilarity(sourceFile: anyNamed("sourceFile")))
          .thenAnswer((_) async => tSimilarityNotConfirmed);
      //assert
      final expected = [
        ScannerInitial(),
        ScannerNotConfirmedState("cannot confirm this receipt")
      ];
      expectLater(scannerBloc, emitsInOrder(expected));
      //act
      scannerBloc.add(ScanReceiptEvent(path: tFilePath));
    },
  );

  test(
    "should yield ScannerNotConfirmedState error happend",
        () async {
      //arrange
      when(purchaseScanUsecase.getSimilarity(sourceFile: anyNamed("sourceFile")))
          .thenThrow(Exception("some exception"));
      //assert
      final expected = [
        ScannerInitial(),
        ScannerNotConfirmedState("some exception")
      ];
      expectLater(scannerBloc, emitsInOrder(expected));
      //act
      scannerBloc.add(ScanReceiptEvent(path: tFilePath));
    },
  );
}
