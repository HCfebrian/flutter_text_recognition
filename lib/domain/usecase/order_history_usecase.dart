import 'dart:async';

import 'package:flutter_text_recognition/domain/contract_repository/pizza_repo_abs.dart';
import 'package:flutter_text_recognition/domain/entity/pizza_entity.dart';
import 'package:meta/meta.dart';

class OrderHistoryUsecase {
  final PizzaRepoAbs pizzaRepoAbs;

  OrderHistoryUsecase({@required this.pizzaRepoAbs});

  Stream<List<PizzaHistoryEntity>> getPizzaHistory() {
    final result = pizzaRepoAbs.getStreamPizzaHistory();
    return result;
  }

  Future<void> closeStream() {
    return pizzaRepoAbs.closePizzaHistoryStream();
  }


}
