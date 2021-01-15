import 'dart:io';


import 'package:flutter_text_recognition/core/failure.dart';

abstract class MLRepoAbs {
  Future< String> getPurchaseID(File imageFile);
  Future< String> getFullText(File imageFile);
}

