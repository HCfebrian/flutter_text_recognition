import 'dart:io';
import 'package:meta/meta.dart';

import 'package:flutter_text_recognition/feature/profile/domain/entity/ktp_data_entity.dart';

abstract class ScanKtpMlKitAbs{
  Future<KtpDataEntity> scanKtp({@required File fileImage});
}