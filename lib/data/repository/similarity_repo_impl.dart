import 'package:edit_distance/edit_distance.dart';
import 'package:flutter_text_recognition/domain/contract_repository/similarity_repo_abs.dart';
import 'package:flutter_text_recognition/domain/entity/purchase_entity.dart';
import 'package:meta/meta.dart';

class SimilarityRepoImpl extends SimilarityRepoAbs {
  final Jaccard jaccard;

  SimilarityRepoImpl({@required this.jaccard});

  @override
  String getDbComparableText({
    PurchaseEntity purchaseEntity,
  }) {
    String result;
    String textOrder = "";
    int orderNumber = 1;
    result = purchaseEntity.purchaseId +
        purchaseEntity.workerName +
        purchaseEntity.workerId +
        purchaseEntity.purchaseDate +
        purchaseEntity.purchaseTime;

    purchaseEntity.listOrder.forEach((element) {
      textOrder = textOrder + orderNumber.toString().padLeft(2, "0");
      textOrder = textOrder + "x" + element.purchaseQuantity;
      textOrder = textOrder + element.pizzaName;
      textOrder = textOrder + element.pizzaPrice;
      textOrder = textOrder + element.pizzaSize;
      orderNumber++;
    });
    print("textOrder " + textOrder);
    result = result +
        textOrder +
        purchaseEntity.subTotal.toString() +
        purchaseEntity.balanceDue.toString();
    print(result);

    return result;
  }

  @override
  double getSimilarity(
      {String databaseComparableText, String scanImageComparableText}) {
    final jaccardDistance = jaccard.normalizedDistance(
        scanImageComparableText
            .toUpperCase()
            .replaceAll(" ", "")
            .replaceAll(".", "")
            .replaceAll(",", ""),
        databaseComparableText
            .toUpperCase()
            .replaceAll(" ", "")
            .replaceAll(".", "")
            .replaceAll(",", ""));

    print("mlString " +
        scanImageComparableText
            .toUpperCase()
            .replaceAll(" ", "")
            .replaceAll(".", "")
            .replaceAll(",", ""));

    print("comparable text " +
        databaseComparableText
            .toUpperCase()
            .replaceAll(" ", "")
            .replaceAll(".", "")
            .replaceAll(",", ""));
    return jaccardDistance;
  }
}
