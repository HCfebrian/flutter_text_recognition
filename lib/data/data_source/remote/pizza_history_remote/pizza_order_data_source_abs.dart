import 'dart:async';

import 'package:flutter_text_recognition/domain/entity/pizza_entity.dart';

abstract class PizzaHistoryDataSourceAbs {
  ///get multiple purchers from Remote
  Stream<List<PizzaHistoryEntity>> getPizzaHistoryStream();
  Future<void> closePizzaHistoryStream();
  Future<void> addReceiptToHistory(String documentId);
}
