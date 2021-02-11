import 'dart:async';

import 'package:flutter_text_recognition/domain/entity/pizza_entity.dart';
import 'package:meta/meta.dart';

abstract class PizzaRepoAbs{
  Stream<List<PizzaHistoryEntity>> getStreamPizzaHistory();
  Future<void> closePizzaHistoryStream();
  Future<bool> addReceiptToHistory(String receiptId);
  void deletePizzaHistory({@required String documentID});
}