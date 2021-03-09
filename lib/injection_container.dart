import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_ml_vision/firebase_ml_vision.dart';
import 'package:flutter_text_recognition/feature/profile/data/data_source/local/ml_kit/scan_ktp_ml_kit_abs.dart';
import 'package:flutter_text_recognition/feature/profile/data/data_source/local/ml_kit/scan_ktp_ml_kit_impl.dart';
import 'package:flutter_text_recognition/feature/profile/data/repo/scan_ktp_repo.dart';
import 'package:flutter_text_recognition/feature/profile/domain/contract_repo/scan_ktp_contract_repo.dart';
import 'package:flutter_text_recognition/feature/profile/domain/usecase/scan_ktp_usecase.dart';
import 'package:flutter_text_recognition/feature/profile/presentation/bloc/scan_ktp_bloc.dart';
import 'package:get_it/get_it.dart';

final sl = GetIt.instance;

void init() {
// Feature
  //bloc
  sl.registerFactory(() => ScanKtpBloc(scanKtpUsecase: sl()));

  //UseCase
  sl.registerLazySingleton<ScanKtpUsecase>(() => ScanKtpUsecase(scanKtpRepoAbs: sl()));

  //repo
  sl.registerLazySingleton<ScanKtpRepoAbs>(() => ScanKtpRepoImpl(scanKtpMlKit: sl()));

  //data
  sl.registerLazySingleton<ScanKtpMlKitAbs>(
      () => ScanKtpMlKitImpl(textRecognizer: sl()));

// External Dependency
  sl.registerLazySingleton(() => FirebaseFirestore.instance);
  sl.registerLazySingleton(() => FirebaseVision.instance.cloudTextRecognizer());
}
