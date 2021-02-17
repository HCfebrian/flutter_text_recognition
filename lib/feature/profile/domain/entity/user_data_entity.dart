import 'package:flutter/cupertino.dart';

class UserDataEntity {
  final String namaLengkap;
  final String tanggalLahir;
  final String alamat;
  final String agama;
  final String statusPerkawinan;

  UserDataEntity(
      {@required this.namaLengkap,
      @required this.tanggalLahir,
      @required this.alamat,
      @required this.agama,
      @required this.statusPerkawinan});
}
