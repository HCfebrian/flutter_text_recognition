import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:flutter_text_recognition/core/failure.dart';
import 'package:flutter_text_recognition/data/data_source/platform/camera_platform_abs.dart';
import 'package:image_picker/image_picker.dart';
import 'package:meta/meta.dart';

class CameraPlatformImpl extends CameraPlatformAbs {
  final ImagePicker picker;

  CameraPlatformImpl({@required this.picker});

  @override
  Future<Either<Failure, File>> getImage(ImageSource imageSource) async {
    final pickedFile = await picker.getImage(source: imageSource);
    return Right(File(pickedFile.path));
  }
}
