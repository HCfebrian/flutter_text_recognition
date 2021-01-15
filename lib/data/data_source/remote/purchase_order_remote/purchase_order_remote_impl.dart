import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_text_recognition/data/data_source/remote/purchase_order_remote/purchase_order_remote_abs.dart';
import 'package:flutter_text_recognition/data/model_converter/purchase_model.dart';
import 'package:flutter_text_recognition/domain/entity/purchase_order.dart';
import 'package:meta/meta.dart';

class PurchaseRemoteDataImpl extends PurchaseRemoteAbs {
  final FirebaseFirestore firesBaseFirestore;

  PurchaseRemoteDataImpl({@required this.firesBaseFirestore});

  @override
  Future<PurchaseEntity> getPurchaseDetail(String id) async {
    final purchaseHistory =
        firesBaseFirestore.collection("purchase_history").doc(id);

    final ds = await purchaseHistory.get();
    return PurchaseModel.from(ds);
  }
}
