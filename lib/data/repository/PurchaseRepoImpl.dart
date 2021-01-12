import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_text_recognition/core/failure.dart';
import 'package:flutter_text_recognition/data/data_source/remote/purchase_order_remote_abs.dart';
import 'package:flutter_text_recognition/domain/contract_repository/purchase_contract_repo.dart';
import 'package:flutter_text_recognition/domain/entity/purchase_order.dart';

class PurchaseRepoImpl extends PurchaseRepoAbs {
  final PurchaseRemoteAbs purchaseRemoteAbs;

  PurchaseRepoImpl({@required this.purchaseRemoteAbs});

  @override
  Future<Either<Failure, PurchaseEntity>> getPurchaseDetail(String id) async {
    try {
      return Right(await purchaseRemoteAbs.getPurchaseDetail(id));
    } catch (e) {
      return Left(FirebaseFailure("Failed to get data from firebase"));
    }
  }
}
