
import 'package:flutter_text_recognition/core/failure.dart';
import 'package:flutter_text_recognition/domain/entity/purchase_order.dart';

abstract class PurchaseRepoAbs {
  Future< PurchaseEntity> getPurchaseDetail(String id);
}
