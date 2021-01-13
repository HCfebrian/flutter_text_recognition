import 'dart:io';

import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

class SimilarityResult extends Equatable {
  final double similarity;
  final File imageFile;
  final String text;

  SimilarityResult(
      {@required this.similarity,
      @required this.imageFile,
      @required this.text});

  @override
  List<Object> get props => [similarity, imageFile, text];
}
