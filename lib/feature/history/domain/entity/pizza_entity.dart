import 'package:equatable/equatable.dart';

class PizzaHistoryEntity extends Equatable {
  final recipeId;
  final purchasePicUrl;
  final purchaseId;
  final purchaseDate;
  final purchaseQuantity;
  final pizzaName;
  final pizzaPrice;
  final pizzaSize;
  final pizzaCal;

  PizzaHistoryEntity(
      this.recipeId,
      this.purchaseId,
      this.purchaseDate,
      this.purchaseQuantity,
      this.pizzaName,
      this.pizzaPrice,
      this.pizzaSize,
      this.pizzaCal,
      this.purchasePicUrl);

  @override
  List<Object> get props => [
        recipeId,
        purchaseId,
        purchaseDate,
        purchaseQuantity,
        pizzaName,
        pizzaPrice,
        pizzaSize,
        pizzaCal,
        purchasePicUrl
      ];
}
