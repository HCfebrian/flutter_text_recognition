import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:flutter_text_recognition/core/failure.dart';
import 'package:flutter_text_recognition/data/data_source/local/ml_kit_local/ml_kit_local_abs.dart';
import 'package:flutter_text_recognition/domain/contract_repository/mlkit_repo_abs.dart';
import 'package:meta/meta.dart';

class MLKitRepoImpl extends MLRepoAbs {
  final MLKitLocalAbs mlKit;

  MLKitRepoImpl({@required this.mlKit});


  @override
  Future<Either<Failure, String>> getPurchaseID(File imageFile) async {
    try{
      final result = await mlKit.getPurchaseId(imageFile);
      return Right(result);
    }catch(e){
      print(e);
      return Left(MLFailure("ML Failure"));
    }
  }

  @override
  Future<Either<Failure, String>> getFullText(File imageFile) async{
    try{
      final result = await mlKit.getFullText(imageFile);
      return Right(result);
    }catch(e){
      print(e);
      return Left(MLFailure("ML Failure"));
    }

  }
}
