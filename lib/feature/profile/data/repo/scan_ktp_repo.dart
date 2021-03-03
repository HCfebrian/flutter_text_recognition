import 'dart:io';

import 'package:flutter_text_recognition/feature/profile/data/data_source/local/ml_kit/scan_ktp_ml_kit_abs.dart';
import 'package:flutter_text_recognition/feature/profile/domain/contract_repo/scan_ktp_contract_repo.dart';
import 'package:flutter_text_recognition/feature/profile/domain/entity/ktp_data_entity.dart';
import 'package:meta/meta.dart';

class ScanKtpRepoImpl implements ScanKtpRepoAbs{
  final ScanKtpMlKitAbs scanKtpMlKit;

  ScanKtpRepoImpl({@required this.scanKtpMlKit});
  @override
  Future<KtpDataEntity> scanUserData(File fileImage) {
    return scanKtpMlKit.scanKtp(fileImage: fileImage);
  }
}