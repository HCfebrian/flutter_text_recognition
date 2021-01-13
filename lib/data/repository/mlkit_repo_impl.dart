import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:flutter_text_recognition/core/failure.dart';
import 'package:flutter_text_recognition/data/data_source/platform/ml_kit_platform/ml_kit_platform_abs.dart';
import 'package:flutter_text_recognition/domain/contract_repository/mlkit_contract_repo.dart';
import 'package:meta/meta.dart';

class MLKitRepoImpl extends MLKitRepoAbs {
  final MLKitPlatformAbs mlKitPlatform;

  MLKitRepoImpl({@required this.mlKitPlatform});


  @override
  Future<Either<Failure, String>> getImage(File imageFile) async{
    try{
      final result = await mlKitPlatform.processImage(imageFile);
      return Right(result);
    }catch(e){
    print(e);
      return(Left(MLFailure("ML Failure")));
    }
  }
}
