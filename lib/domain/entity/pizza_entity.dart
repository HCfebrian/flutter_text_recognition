import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

class PizzaHistoryEntity extends Equatable {
  final String recipeId;
  final String purchasePicUrl;
  final String purchaseId;
  final String purchaseDate;
  final String purchaseQuantity;
  final String pizzaName;
  final String pizzaPrice;
  final String pizzaSize;
  final String pizzaCal;

  PizzaHistoryEntity(
      {@required this.recipeId,
      @required this.purchaseId,
      @required this.purchaseDate,
      @required this.purchaseQuantity,
      @required this.pizzaName,
      @required this.pizzaPrice,
      @required this.pizzaSize,
      @required this.pizzaCal,
      @required this.purchasePicUrl});

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
