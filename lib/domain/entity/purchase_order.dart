import 'package:equatable/equatable.dart';

class PurchaseEntity extends Equatable {
  final String purchaseId;
  final String deliveryData;
  final String description;
  final String item;
  final String lineTotal;
  final String purchaseOrderDate;
  final String quantity;
  final String shipTo;
  final String shippingMethod;
  final String shippingTerms;
  final String subTotal;
  final String tax;
  final String total;
  final String cost;
  final String vendor;
  final String fullText;

  PurchaseEntity(
      this.deliveryData,
      this.description,
      this.item,
      this.lineTotal,
      this.purchaseOrderDate,
      this.quantity,
      this.shipTo,
      this.shippingMethod,
      this.shippingTerms,
      this.subTotal,
      this.tax,
      this.total,
      this.cost,
      this.vendor,
      this.purchaseId,
      this.fullText);

  @override
  List<Object> get props => [];
}
