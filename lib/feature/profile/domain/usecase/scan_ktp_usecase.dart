import 'dart:io';

import 'package:flutter_text_recognition/feature/profile/domain/contract_repo/scan_ktp_contract_repo.dart';
import 'package:flutter_text_recognition/feature/profile/domain/entity/user_data_entity.dart';
import 'package:meta/meta.dart';

class ScanKtpUsecase{
  final ScanKtpRepoAbs scanKtpRepoAbs;

  ScanKtpUsecase({@required this.scanKtpRepoAbs});

  Future<UserDataEntity> getUserData(File fileImage){
    return scanKtpRepoAbs.scanUserData(fileImage);
  }
}