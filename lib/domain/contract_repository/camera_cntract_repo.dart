import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:flutter_text_recognition/core/failure.dart';
import 'package:image_picker/image_picker.dart';

abstract class CameraRepoAbs{
  Future<Either<Failure, File>> getImage(ImageSource imageSource);
}