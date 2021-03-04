import 'dart:io';

import 'package:flutter_text_recognition/feature/profile/domain/contract_repo/scan_ktp_contract_repo.dart';
import 'package:flutter_text_recognition/feature/profile/domain/entity/ktp_data_entity.dart';
import 'package:meta/meta.dart';

class ScanKtpUsecase{
  final ScanKtpRepoAbs scanKtpRepoAbs;

  ScanKtpUsecase({@required this.scanKtpRepoAbs});

  Future<KtpDataEntity> getUserData(File fileImage)async{

    final result = await scanKtpRepoAbs.scanUserData(fileImage);

    print("result after normalization");
    print("nik : " + result.nik.toString());
    print("nama : " + result.namaLengkap.toString());
    print("tempatLahir : " +  result.tempatLahir.toString());
    print("tglLahir : " + result.tanggalLahir.toString());
    print("jenis kelamin : " + result.jenisKelamin.toString());
    print("alamat full : " + result.alamatFull.toString());
    print("alamat : " + result.alamat.toString());
    print("rt rw : " + result.rtrw.toString());
    print("kel desa : " + result.kelDesa.toString());
    print("kecamatan : " + result.kecamatan.toString());
    print("agama : " + result.agama.toString());
    print("status kawin : " + result.statusPerkawinan.toString());
    print("pekerjaan : " + result.pekerjaan.toString());
    print("kewarganegaraan : " + result.kewarganegaraan.toString());

    return result;
  }
}