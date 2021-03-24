import 'dart:io';

import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_text_recognition/feature/profile/domain/entity/ktp_data_entity.dart';
import 'package:flutter_text_recognition/feature/profile/domain/usecase/scan_ktp_usecase.dart';
import 'package:flutter_text_recognition/feature/profile/presentation/bloc/scan_ktp_bloc.dart';
import 'package:mockito/mockito.dart';

class MockScanKtpUsecase extends Mock implements ScanKtpUsecase {}

void main() {
  ScanKtpBloc scanKtpBloc;
  MockScanKtpUsecase mockScanKtpUsecase;
  setUp(() {
    mockScanKtpUsecase = MockScanKtpUsecase();
    scanKtpBloc = ScanKtpBloc(scanKtpUsecase: mockScanKtpUsecase);
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
    "should yield ScanKtpSuccessState when result is Available",
    () async {
      //arrange
      when(mockScanKtpUsecase.getUserData(any))
          .thenAnswer((realInvocation) async => tDataEntity);
      //assert
      final expected = [
        ScanKtpInitial(),
        ScanKtpSuccessState(userData: tDataEntity),
      ];
      expectLater(scanKtpBloc, emitsInOrder(expected));
      //act
      scanKtpBloc.add(ScanKtpInputEvent(fileImage: tFilePath));
    },
  );
}
