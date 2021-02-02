import 'package:flutter_text_recognition/domain/entity/purchase_entity.dart';

abstract class PurchaseRemoteAbs {
  ///get multiple purchers from Remote
  Future<PurchaseEntity> getPurchaseDetail(String id);

}