import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_text_recognition/feature/history/domain/entity/pizza_entity.dart';
import 'package:meta/meta.dart';

class PizzaEntityConverter extends PizzaHistoryEntity {
  PizzaEntityConverter({
    @required recipeId,
    @required purchaseId,
    @required purchaseDate,
    @required purchaseQuantity,
    @required pizzaName,
    @required pizzaPrice,
    @required pizzaSize,
    @required pizzaCal,
    @required purchasePicUrl,
  }) : super(
          recipeId,
          purchaseId,
          purchaseDate,
          purchaseQuantity,
          pizzaName,
          pizzaPrice,
          pizzaSize,
          pizzaCal,
          purchasePicUrl,
        );

  factory PizzaEntityConverter.from(DocumentSnapshot ds) {
    final data = ds.data();

    return PizzaEntityConverter(
        recipeId: "PZE45hViRDAWKzCCabS7",
        purchaseId: ds.id,
        purchaseDate: data["purchase_date"],
        purchaseQuantity: data["product_quantity"],
        pizzaName: data["product_name"],
        pizzaPrice: data["product_price"],
        pizzaSize: data["product_size"],
        pizzaCal: data["product_cal"],
        purchasePicUrl: data["product_pic_url"]);
  }
}
