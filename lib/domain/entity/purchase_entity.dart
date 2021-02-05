import 'package:equatable/equatable.dart';
import 'package:flutter_text_recognition/domain/entity/pizza_entity.dart';
import 'package:meta/meta.dart';

class PurchaseEntity extends Equatable {
  final String purchaseId;
  final List<PizzaHistoryEntity> listOrder;
  final String purchaseDate;
  final String purchaseTime;
  final String workerId;
  final String workerName;
  final int cashback;
  final int subTotal;
  final int balanceDue;

  PurchaseEntity({
    @required this.purchaseId,
    @required this.listOrder,
    @required this.purchaseDate,
    @required this.workerId,
    @required this.workerName,
    @required this.purchaseTime,
    @required this.subTotal,
    @required this.balanceDue,
    @required this.cashback,
  });

  @override
  List<Object> get props => [
        purchaseId,
        listOrder,
        purchaseDate,
        purchaseTime,
        workerId,
        workerName,
        cashback,
        subTotal,
        balanceDue
      ];
}
