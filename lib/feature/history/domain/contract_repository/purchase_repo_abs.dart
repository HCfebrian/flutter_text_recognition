import 'package:flutter_text_recognition/feature/history/domain/entity/purchase_entity.dart';

abstract class PurchaseRepoAbs {
  Future<PurchaseEntity> getPurchaseDetail(String id);
}
