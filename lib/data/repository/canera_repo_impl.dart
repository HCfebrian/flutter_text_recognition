import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:flutter_text_recognition/core/failure.dart';
import 'package:flutter_text_recognition/data/data_source/platform/camera_platform/camera_platform_abs.dart';
import 'package:flutter_text_recognition/domain/contract_repository/camera_repo_abs.dart';
import 'package:image_picker/image_picker.dart';
import 'package:meta/meta.dart';

class CameraRepoImpl extends CameraRepoAbs {
  final CameraPlatformAbs cameraPlatform;

  CameraRepoImpl({@required this.cameraPlatform});

  @override
  Future<Either<Failure, File>> getImage(ImageSource imageSource) async {
    try {
      return cameraPlatform.getImage(imageSource);
    } catch (e) {
      print(e);
      return Left(CameraFailure("camera Failure"));
    }
  }
}
