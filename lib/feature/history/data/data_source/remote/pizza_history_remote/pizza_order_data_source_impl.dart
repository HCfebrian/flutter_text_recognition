import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_text_recognition/feature/history/data/entity_converter/pizza_converter.dart';
import 'package:flutter_text_recognition/feature/history/domain/entity/pizza_entity.dart';
import 'package:flutter_text_recognition/feature/history/data/data_source/remote/pizza_history_remote/pizza_order_data_source_abs.dart';

class PizzaHistoryDataSourceImpl extends PizzaHistoryDataSourceAbs {
  final FirebaseFirestore firebaseFirestore;

  final _controller = StreamController<List<PizzaHistoryEntity>>();

  Stream<List<PizzaHistoryEntity>> get _stream => _controller.stream;

  PizzaHistoryDataSourceImpl(this.firebaseFirestore) {
    firebaseFirestore
        .collection("order_history/PZE45hViRDAWKzCCabS7/order_collection")
        .snapshots()
        .listen((event) {
      List<PizzaHistoryEntity> temp = [];
      event.docs.forEach((element) {
        final PizzaHistoryEntity result = PizzaEntityConverter.from(element);
        temp.add(result);
      });
      print(temp[1].pizzaName);

      _controller.sink.add(temp);
    });
  }

  @override
  Stream<List<PizzaHistoryEntity>> getPizzaHistoryStream() {
    return _stream;
  }

  @override
  Future<void> closePizzaHistoryStream() async {
    await _controller?.close();
  }

  @override
  Future<bool> addReceiptToHistory(String receiptId) async {
    final CollectionReference collectionReceiptRef = firebaseFirestore
        .collection("purchase_history/$receiptId/order_collection");
    final CollectionReference collectionHistoryRef = firebaseFirestore
        .collection("order_history/PZE45hViRDAWKzCCabS7/order_collection");
    collectionReceiptRef.snapshots().forEach(
      (element) {
        element.docs.forEach(
          (element) {
            print("document id" + element.id);
            collectionHistoryRef.doc(element.id).set(element.data());
          },
        );
      },
    );
    return true;
  }

  @override
  void deletePizzaHistory({String documentId}) {
    firebaseFirestore
        .doc("/order_history/PZE45hViRDAWKzCCabS7/order_collection/$documentId")
        .delete();
  }
}
