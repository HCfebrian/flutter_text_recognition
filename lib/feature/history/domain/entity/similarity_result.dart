
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

class SimilarityResult extends Equatable {
  final double similarityDistance;
  final bool confirmed;
  final String purchaseID;
  final int cashback;

  SimilarityResult(
      {@required this.similarityDistance,
      @required this.confirmed,
      @required this.purchaseID,
      @required this.cashback});

  @override
  List<Object> get props => [
        confirmed,
        similarityDistance,
        purchaseID,
        cashback,
      ];
}
