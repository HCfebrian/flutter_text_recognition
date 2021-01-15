import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:flutter_text_recognition/core/failure.dart';

abstract class MLRepoAbs {
  Future<Either<Failure, String>> getPurchaseID(File imageFile);
  Future<Either<Failure, String>> getFullText(File imageFile);
}

