import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_text_recognition/data/data_source/remote/purchase_order_remote/purchase_order_remote_abs.dart';
import 'package:flutter_text_recognition/data/model_converter/pizza_converter.dart';
import 'package:flutter_text_recognition/data/model_converter/purchase_entity_converter.dart';
import 'package:flutter_text_recognition/domain/entity/pizza_entity.dart';
import 'package:flutter_text_recognition/domain/entity/purchase_entity.dart';
import 'package:meta/meta.dart';

class PurchaseRemoteDataImpl extends PurchaseRemoteAbs {
  final FirebaseFirestore firesBaseFirestore;

  PurchaseRemoteDataImpl({@required this.firesBaseFirestore});

  @override
  Future<PurchaseEntity> getPurchaseDetail(String id) async {
    print("get purchase detail running " + id);
    final purchaseHistory =
    firesBaseFirestore.collection("purchase_history").doc(id);
    final ds = await purchaseHistory.get();
    final purchaseCollection = await firesBaseFirestore.collection("purchase_history/$id/order_collection").get();
    List<PizzaHistoryEntity> listPizza=[];
    purchaseCollection.docs.forEach((element) {
      listPizza.add(PizzaEntityConverter.from(element));
    });
    return PurchaseEntityConverter.from(ds, listPizza);
  }
}
