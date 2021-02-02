import 'dart:async';

import 'package:flutter_text_recognition/domain/entity/pizza_entity.dart';

abstract class PizzaRepoAbs{
  Stream<List<PizzaHistoryEntity>> getStreamPizzaHistory();
  Future<void> closePizzaHistoryStream();
  Future<bool> addReceiptToHistory(String receiptId);
}