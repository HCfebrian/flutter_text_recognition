import 'package:flutter_text_recognition/domain/entity/purchase_entity.dart';

abstract class PurchaseRepoAbs {
  Future<PurchaseEntity> getPurchaseDetail(String id);
}
