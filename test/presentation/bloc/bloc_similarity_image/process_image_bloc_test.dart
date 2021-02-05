// import 'dart:io';
//
// import 'package:flutter_text_recognition/domain/entity/similarity_result.dart';
// import 'package:flutter_text_recognition/domain/usecase/purchase_scan_usecase.dart';
//
// class MockPurchaseScanUsecase extends Mock implements PurchaseScanUsecase {}
//
// main() {
//   SimilarityImageBloc similarityImageBloc;
//   MockPurchaseScanUsecase mockPurchase;
//
//   setUp(() {
//     mockPurchase = MockPurchaseScanUsecase();
//     similarityImageBloc = SimilarityImageBloc(purchaseUsecase: mockPurchase);
//   });
//
//   final SimilarityResult similarityResultTest = SimilarityResult(
//       similarity: 0.5,
//       imageFile: File("example/location/on/storage"),
//       textFromDb: "example text from db",
//       textFromMl: "text from ML kit");
//
//   group("test bloc", () {
//     test(
//       "should emit Loading, Loaded",
//       () async {
//         //arrange
//         when(mockPurchase.getSimilarity())
//             .thenAnswer((realInvocation) async => similarityResultTest);
//         //assert
//         final expected = [
//           ProcessImageLoadingState(),
//           ProcessImageLoadedState(
//               textFromDb: similarityResultTest.textFromDb,
//               textFromML: similarityResultTest.textFromMl,
//               file: similarityResultTest.imageFile,
//               similarity: similarityResultTest.similarity,
//               isShown: false),
//         ];
//         expectLater(similarityImageBloc, emitsInOrder(expected));
//         //act
//         similarityImageBloc.add(TakeAndProcessImageEvent());
//       },
//     );
//
//     test(
//       "should emit Loading, Error",
//       () async {
//         //arrange
//         when(mockPurchase.getSimilarity()).thenThrow(Exception("error"));
//         //assert
//         final expected = [
//           ProcessImageLoadingState(),
//           ProcessImageErrorState(message: "error", isShown: true)
//         ];
//         expectLater(similarityImageBloc, emitsInOrder(expected));
//         //act
//         similarityImageBloc.add(TakeAndProcessImageEvent());
//       },
//     );
//   });
// }
