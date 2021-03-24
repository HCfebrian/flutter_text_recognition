import 'dart:io';

import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_text_recognition/feature/history/domain/entity/pizza_entity.dart';
import 'package:flutter_text_recognition/feature/history/domain/usecase/order_history_usecase.dart';
import 'package:flutter_text_recognition/feature/history/presentation/bloc/pizza_history/pizza_history_bloc.dart';
import 'package:mockito/mockito.dart';

class MockOrderHistoryUsecase extends Mock implements OrderHistoryUsecase {}

class MockStream extends Mock implements Stream<List<PizzaHistoryEntity>> {}

void main() {
  MockOrderHistoryUsecase mockOrderHistoryUsecase;
  PizzaHistoryBloc pizzaHistoryBloc;
  MockStream stream;
  setUp(() {
    stream = MockStream();
    mockOrderHistoryUsecase = MockOrderHistoryUsecase();
    pizzaHistoryBloc = PizzaHistoryBloc(mockOrderHistoryUsecase);
  });
  final PizzaHistoryEntity pizzaHistoryEntity = PizzaHistoryEntity(
      "recipeId",
      "purchaseId",
      "purchaseDate",
      "purchaseQuantity",
      "pizzaName",
      "pizzaPrice",
      "pizzaSize",
      "pizzaCal",
      "purchasePicUrl");

  final List<PizzaHistoryEntity> tListPizza = [
    pizzaHistoryEntity,
    pizzaHistoryEntity,
    pizzaHistoryEntity
  ];

  // final tFilePath = File("/test/test/tes.jpg");

  test(
    "should yield ScannerConfirmedState when similaritydistance is below 0.25",
    () async {
      //arrange
      when(mockOrderHistoryUsecase.getPizzaHistory())
          .thenAnswer((realInvocation) => stream);
      when(stream.listen(any)).thenAnswer((Invocation invocation) {
        var callback = invocation.positionalArguments.single;
        return callback(tListPizza);
      });
      final expected = [
        PizzaHistoryLoadingState(),
        PizzaHistoryLoadedState(listPizza: tListPizza)
      ];
      //assert
      expectLater(pizzaHistoryBloc, emitsInOrder(expected));
      //act
      pizzaHistoryBloc.add(PizzaHistoryGetStreamEvent());
    },
  );
}
