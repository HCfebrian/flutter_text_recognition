import 'package:dartz/dartz.dart';
import 'package:flutter_text_recognition/core/failure.dart';
import 'package:flutter_text_recognition/domain/entity/purchase_order.dart';

abstract class PurchaseRepoAbs {
  Future<Either<Failure, PurchaseEntity>> getPurchaseDetail(String id);
}
