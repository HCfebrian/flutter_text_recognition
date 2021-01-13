import 'dart:io';

abstract class MLKitPlatformAbs{
  Future<String> processImage(File imageFile);
}