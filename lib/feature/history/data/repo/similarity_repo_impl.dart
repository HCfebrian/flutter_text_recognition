import 'package:edit_distance/edit_distance.dart';
import 'package:flutter_text_recognition/feature/history/domain/contract_repository/similarity_repo_abs.dart';
import 'package:flutter_text_recognition/feature/history/domain/entity/pizza_entity.dart';
import 'package:meta/meta.dart';

class SimilarityRepoImpl extends SimilarityRepoAbs {
  final Jaccard jaccard;

  SimilarityRepoImpl({@required this.jaccard});

  @override
  String getDbComparableText(
      {String purchaseID,
      String workerName,
      String workerId,
      String purchaseDate,
      String purchaseTime,
      int subTotal,
      int balanceDue,
      List<PizzaHistoryEntity> listPizza}) {
    String result;
    String textOrder = "";
    int orderNumber = 1;
    result = purchaseID + workerName + workerId + purchaseDate + purchaseTime;

    listPizza.forEach((element) {
      textOrder = textOrder + orderNumber.toString().padLeft(2, "0");
      textOrder = textOrder + "x" + element.purchaseQuantity;
      textOrder = textOrder + element.pizzaName;
      textOrder = textOrder + element.pizzaPrice;
      textOrder = textOrder + element.pizzaSize;
      orderNumber++;
    });
    print("textOrder " + textOrder);
    result = result + textOrder + subTotal.toString() + balanceDue.toString();
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
