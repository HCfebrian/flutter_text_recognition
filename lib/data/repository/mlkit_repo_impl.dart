import 'dart:io';
import 'dart:ui';


import 'package:flutter_text_recognition/data/data_source/local/ml_kit_local/ml_kit_local_abs.dart';
import 'package:flutter_text_recognition/domain/contract_repository/mlkit_repo_abs.dart';
import 'package:meta/meta.dart';

class MLKitRepoImpl extends MLRepoAbs {
  final MLKitLocalAbs mlKit;

  MLKitRepoImpl({@required this.mlKit});

  @override
  Future<String> getPurchaseID({File imageFile, Size size}) async {
    return await mlKit.getPurchaseId(imageFile: imageFile, size: size);
  }

  @override
  Future< String> getFullText(File imageFile) async {
      return await mlKit.getFullText(imageFile);
  }

  @override
  bool setCameraSize(Size size) {
    return mlKit.setCameraSize(size);
  }
}
