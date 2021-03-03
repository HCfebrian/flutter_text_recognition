import 'dart:io';


import 'package:flutter_text_recognition/feature/history/data/data_source/local/camera/camera_platform_abs.dart';
import 'package:flutter_text_recognition/feature/history/domain/contract_repository/camera_repo_abs.dart';
import 'package:image_picker/image_picker.dart';
import 'package:meta/meta.dart';

class CameraRepoImpl extends CameraRepoAbs {
  final CameraPlatformAbs cameraPlatform;

  CameraRepoImpl({@required this.cameraPlatform});

  @override
  Future<File> getImage(ImageSource imageSource) async {
    return cameraPlatform.getImage(imageSource);
  }

}
