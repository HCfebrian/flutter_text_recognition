import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:flutter_text_recognition/core/failure.dart';
import 'package:flutter_text_recognition/data/data_source/platform/camera_platform_abs.dart';
import 'package:flutter_text_recognition/domain/contract_repository/camera_cntract_repo.dart';
import 'package:image_picker/image_picker.dart';
import 'package:meta/meta.dart';

class CameraRepoImpl extends CameraRepoAbs {
  final CameraPlatformAbs cameraPlatformAbs;

  CameraRepoImpl({@required this.cameraPlatformAbs});

  @override
  Future<Either<Failure, File>> getImage(ImageSource imageSource) async {
    try {
      return cameraPlatformAbs.getImage(imageSource);
    } catch (_) {
      return Left(CameraFailure("camera Failure"));
    }
  }
}
