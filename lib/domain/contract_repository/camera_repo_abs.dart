import 'dart:io';


import 'package:image_picker/image_picker.dart';

abstract class CameraRepoAbs{
  Future< File> getImage(ImageSource imageSource);
}