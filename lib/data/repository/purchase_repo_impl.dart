import 'package:flutter/cupertino.dart';
import 'package:flutter_text_recognition/core/failure.dart';
import 'package:flutter_text_recognition/data/data_source/remote/purchase_order_remote/purchase_order_remote_abs.dart';
import 'package:flutter_text_recognition/domain/contract_repository/purchase_repo_abs.dart';
import 'package:flutter_text_recognition/domain/entity/purchase_order.dart';

class PurchaseRepoImpl extends PurchaseRepoAbs {
  final PurchaseRemoteAbs purchaseRemoteAbs;

  PurchaseRepoImpl({@required this.purchaseRemoteAbs});

  @override
  Future<PurchaseEntity> getPurchaseDetail(String id) async {
    return await purchaseRemoteAbs.getPurchaseDetail(id);
  }
}
