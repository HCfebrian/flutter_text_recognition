import 'dart:io';

import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_text_recognition/feature/profile/domain/contract_repo/scan_ktp_contract_repo.dart';
import 'package:flutter_text_recognition/feature/profile/domain/entity/ktp_data_entity.dart';
import 'package:flutter_text_recognition/feature/profile/domain/usecase/scan_ktp_usecase.dart';
import 'package:mockito/mockito.dart';

class MockScanKtpRepo extends Mock implements ScanKtpRepoAbs {}

void main() {
  MockScanKtpRepo mockScanKtpRepo;
  ScanKtpUsecase scanKtpUsecase;
  setUp(() {
    mockScanKtpRepo = MockScanKtpRepo();
    scanKtpUsecase = ScanKtpUsecase(scanKtpRepoAbs: mockScanKtpRepo);
  });

  final tDataEntity = KtpDataEntity(
      namaLengkap: "Heryan Cahya Febriansyah",
      tanggalLahir: "10-10-1990",
      alamatFull: "magelang",
      agama: "islam",
      alamat: "magelang",
      rtrw: "01/01",
      kelDesa: "kalijambe",
      kecamatan: "kajoran",
      statusPerkawinan: "Belum Kawin",
      nik: "123456789",
      tempatLahir: "ambon",
      jenisKelamin: "perempuan",
      golDarah: "o",
      pekerjaan: "Dosen",
      kewarganegaraan: "WNI",
      berlakuHingga: "Seumur Hidup");

  final tFilePath = File("/test/test/tes.jpg");

  test(
    "should return tDataEntity when  ",
    () async {
      //arrange
      when(mockScanKtpRepo.scanUserData(any))
          .thenAnswer((realInvocation) async => tDataEntity);

      //act
      final result = await scanKtpUsecase.getUserData(tFilePath);

      //assert
      expect(result, tDataEntity);
    },
  );
}
