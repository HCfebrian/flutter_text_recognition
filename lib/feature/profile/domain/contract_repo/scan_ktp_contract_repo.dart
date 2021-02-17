import 'dart:io';

import 'package:flutter_text_recognition/feature/profile/domain/entity/user_data_entity.dart';

abstract class ScanKtpRepoAbs{
  Future<UserDataEntity> scanUserData(File fileImage);
}