import 'dart:io';

import 'package:flutter_text_recognition/core/failure.dart';
import 'package:image_picker/image_picker.dart';

abstract class CameraPlatformAbs {
  Future<File> getImage(ImageSource imageSource);
}
