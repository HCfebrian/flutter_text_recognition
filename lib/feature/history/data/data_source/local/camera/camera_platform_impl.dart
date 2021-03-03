import 'dart:io';


import 'package:flutter_text_recognition/feature/history/data/data_source/local/camera/camera_platform_abs.dart';
import 'package:image_picker/image_picker.dart';
import 'package:meta/meta.dart';

class CameraPlatformImpl extends CameraPlatformAbs {
  final ImagePicker picker;

  CameraPlatformImpl({@required this.picker});

  @override
  Future<File> getImage(ImageSource imageSource) async {
    final pickedFile = await picker.getImage(source: imageSource);
    return File(pickedFile.path);
  }
}
