import 'dart:io';

import 'package:flutter_text_recognition/feature/profile/domain/entity/ktp_data_entity.dart';

abstract class ScanKtpRepoAbs{
  Future<KtpDataEntity> scanUserData(File fileImage);
}