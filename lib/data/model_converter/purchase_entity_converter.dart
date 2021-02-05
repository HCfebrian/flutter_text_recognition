import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_text_recognition/domain/entity/pizza_entity.dart';
import 'package:flutter_text_recognition/domain/entity/purchase_entity.dart';

class PurchaseEntityConverter extends PurchaseEntity {
  PurchaseEntityConverter(
      String purchaseId,
      List<PizzaHistoryEntity> listOrder,
      String purchaseDate,
      String workerId,
      String workerName,
      String purchaseTime,
      int subTotal,
      int balanceDue,
      int cashback)
      : super(
            purchaseId: purchaseId,
            listOrder: listOrder,
            purchaseDate: purchaseDate,
            workerId: workerId,
            workerName: workerName,
            purchaseTime: purchaseTime,
            subTotal: subTotal,
            balanceDue: balanceDue,
            cashback: cashback);

  factory PurchaseEntityConverter.from(DocumentSnapshot dsPurchase, listOrder) {
    final data = dsPurchase.data();

    return PurchaseEntityConverter(
      dsPurchase.id,
      listOrder,
      data["purchase_date"],
      data["worker_id"],
      data["worker_name"],
      data["purchase_time"],
      data["sub_total"],
      data["balance_due"],
      data["cashback"],
    );
  }
}
