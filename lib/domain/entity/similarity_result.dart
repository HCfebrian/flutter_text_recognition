import 'dart:io';

import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

class SimilarityResult extends Equatable {
  final double similarity;
  final File imageFile;
  final String textFromDb;
  final String textFromMl;

  SimilarityResult(
      {@required this.similarity,
      @required this.imageFile,
      @required this.textFromDb,
      @required this.textFromMl});

  @override
  List<Object> get props => [];
}
