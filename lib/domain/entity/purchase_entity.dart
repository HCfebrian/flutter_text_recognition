import 'package:equatable/equatable.dart';
import 'package:flutter_text_recognition/domain/entity/pizza_entity.dart';

class PurchaseEntity extends Equatable {
  final List<PizzaHistoryEntity> listOrder;
  final String purchaseDate;
  final String purchaseTime;
  final String workerId;
  final String workerName;
  final int cashback;
  final int subTotal;
  final int balanceDue;

  PurchaseEntity(
    this.listOrder,
    this.purchaseDate,
    this.workerId,
    this.workerName,
    this.purchaseTime,
    this.subTotal,
    this.balanceDue,
    this.cashback,
  );

  @override
  List<Object> get props => [
        listOrder,
        purchaseDate,
        workerId,
        workerName,
        purchaseTime,
      ];
}
