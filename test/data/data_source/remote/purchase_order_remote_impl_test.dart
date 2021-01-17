import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_text_recognition/data/data_source/remote/purchase_order_remote/purchase_order_remote_impl.dart';
import 'package:flutter_text_recognition/data/model_converter/purchase_model.dart';
import 'package:mockito/mockito.dart';

class MockFirestore extends Mock implements FirebaseFirestore{}
class MockColectionRef extends Mock implements CollectionReference{}
class MockQuerySnap extends Mock implements QuerySnapshot{}
class MockDocRef extends Mock implements DocumentReference{}
class MockDocumentSnap extends Mock implements DocumentSnapshot{
  @override
  String get documentID => "12343";
  @override
  Map<String, dynamic> data() =>  {
    "ship_to":"indonesia",
    "order":"chair",
    "price":"\$10000",
  };
}

void main(){
  MockFirestore mockFirestore;
  MockColectionRef mockColectionRef;
  MockDocRef mockDocRef;
  MockDocumentSnap mockDocumentSnap;
  PurchaseRemoteDataImpl purchaseRemoteDataImpl;

  setUp((){
    mockFirestore = MockFirestore();
    mockColectionRef = MockColectionRef();
    mockDocRef = MockDocRef();
    mockDocumentSnap = MockDocumentSnap();
    purchaseRemoteDataImpl = PurchaseRemoteDataImpl(firesBaseFirestore: mockFirestore);
  });


  test( "should return data snap",() async {
        //arrange
    when(mockFirestore.collection(any)).thenReturn(mockColectionRef);
    when(mockColectionRef.doc(any)).thenReturn(mockDocRef);
    when(mockDocRef.get()).thenAnswer((realInvocation) async => mockDocumentSnap);
        //act
    final result = await purchaseRemoteDataImpl.getPurchaseDetail("123");
        //assert
    expect(result, isA<PurchaseModel>());
        },
      );

}