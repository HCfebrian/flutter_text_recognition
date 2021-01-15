import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_text_recognition/domain/entity/purchase_order.dart';
import 'package:meta/meta.dart';
import 'dart:convert';

class PurchaseModel extends PurchaseEntity {
  PurchaseModel(
      {@required String purchaseID,
      @required String deliveryData,
      @required String description,
      @required String item,
      @required String lineTotal,
      @required String purchaseOrderDate,
      @required String quantity,
      @required String shipTo,
      @required String shippingMethod,
      @required String shippingTerms,
      @required String subTotal,
      @required String tax,
      @required String total,
      @required String cost,
      @required String vendor,
      @required String fullString})
      : super(
            purchaseID,
            deliveryData,
            description,
            item,
            lineTotal,
            purchaseOrderDate,
            quantity,
            shipTo,
            shippingMethod,
            shippingTerms,
            subTotal,
            tax,
            total,
            cost,
            vendor,
            fullString);

  factory PurchaseModel.from(DocumentSnapshot ds) {
    final data = ds.data();
    String encode = json
        .encode(data)
        .replaceAll("{", "")
        .replaceAll("}", "")
        .replaceAll(":", "")
        .replaceAll("\"", "");
    print(encode);
    return PurchaseModel(
        purchaseID: ds.id,
        deliveryData: data["delivery date"],
        description: data["description"],
        item: data["item"],
        lineTotal: data["line total"],
        purchaseOrderDate: data["purchase order date"],
        quantity: data["quantity"],
        shipTo: data["ship to"],
        shippingMethod: data["shipping method"],
        shippingTerms: data["shipping terms"],
        subTotal: data["subtotal"],
        tax: data["tax(13.0%)"],
        total: data["total"],
        cost: data["unit cost"],
        vendor: data["vendor"],
        fullString: encode);
  }
}
