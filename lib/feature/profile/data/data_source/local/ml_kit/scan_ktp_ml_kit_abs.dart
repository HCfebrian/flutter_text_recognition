import 'dart:io';
import 'package:meta/meta.dart';

import 'package:flutter_text_recognition/feature/profile/domain/entity/user_data_entity.dart';

abstract class ScanKtpMlKitAbs{
  Future<UserDataEntity> scanKtp({@required File fileImage});
}