import 'package:flutter/material.dart';
import 'package:flutter_text_recognition/domain/entity/pizza_entity.dart';

abstract class SimilarityRepoAbs {
  String getDbComparableText({
    @required String purchaseID,
    @required String workerName,
    @required String workerId,
    @required String purchaseDate,
    @required String purchaseTime,
    @required int subTotal,
    @required int balanceDue,
    @required List<PizzaHistoryEntity> listPizza,
  });

  double getSimilarity(
      {@required String databaseComparableText,
      @required String scanImageComparableText});
}
