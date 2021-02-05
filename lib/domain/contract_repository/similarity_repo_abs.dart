import 'package:flutter/material.dart';
import 'package:flutter_text_recognition/domain/entity/purchase_entity.dart';

abstract class SimilarityRepoAbs {
  String getDbComparableText({
    @required PurchaseEntity purchaseEntity,
  });

  double getSimilarity(
      {@required String databaseComparableText,
      @required String scanImageComparableText});
}
