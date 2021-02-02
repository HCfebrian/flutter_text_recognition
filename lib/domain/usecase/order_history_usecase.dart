import 'dart:async';

import 'package:flutter_text_recognition/domain/contract_repository/pizza_repo_abs.dart';
import 'package:flutter_text_recognition/domain/entity/pizza_entity.dart';
import 'package:meta/meta.dart';

class OrderHistoryUsecase {
  final PizzaRepoAbs pizzaRepo;

  OrderHistoryUsecase({@required this.pizzaRepo});

  Stream<List<PizzaHistoryEntity>> getPizzaHistory() {
    final result = pizzaRepo.getStreamPizzaHistory();
    return result;
  }

  Future<void> closeStream() {
    return pizzaRepo.closePizzaHistoryStream();
  }


}
