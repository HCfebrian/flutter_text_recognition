import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:meta/meta.dart';

class PurchaseRemoteDataImpl {
  final FirebaseFirestore firesBaseFirestore;

  PurchaseRemoteDataImpl({@required this.firesBaseFirestore});

  void getPurchaseHistory({String id = "123454"}) async {
    try {
      final purchaseHistory =
          firesBaseFirestore.collection("purchase_history").doc(id);

      await purchaseHistory.get().then((value) => print(value.toString()),
          onError: (e) {
        print(e.toString());
      });
    } catch (e) {
      print(e.toString());
    }
  }
}
