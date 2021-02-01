import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_text_recognition/data/data_source/remote/pizza_history_remote/pizza_order_data_source_abs.dart';
import 'package:flutter_text_recognition/domain/contract_repository/pizza_repo_abs.dart';
import 'package:flutter_text_recognition/domain/entity/pizza_entity.dart';

class PizzaRepoImpl extends PizzaRepoAbs {
  final PizzaHistoryDataSourceAbs pizzaDataSource;

  PizzaRepoImpl({@required this.pizzaDataSource});

   @override
  Stream<List<PizzaHistoryEntity>> getStreamPizzaHistory() {
    return pizzaDataSource.getPizzaHistoryStream();
  }

  @override
  Future<void> closePizzaHistoryStream() {
     return pizzaDataSource.closePizzaHistoryStream();
  }

  @override
  Future<bool> addReceiptToHistory(String documentId) {
     return pizzaDataSource.addReceiptToHistory(documentId);
  }
}
