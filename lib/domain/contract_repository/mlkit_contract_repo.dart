import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:flutter_text_recognition/core/failure.dart';

abstract class MLKitRepoAbs {
  Future<Either<Failure, String>> getImage(File imageFile);
}
