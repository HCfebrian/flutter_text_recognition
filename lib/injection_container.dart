import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:edit_distance/edit_distance.dart';
import 'package:firebase_ml_vision/firebase_ml_vision.dart';
import 'package:flutter_text_recognition/feature/history/data/repo/canera_repo_impl.dart';
import 'package:flutter_text_recognition/feature/history/data/repo/mlkit_repo_impl.dart';
import 'package:flutter_text_recognition/feature/history/data/repo/pizza_history_repo.dart';
import 'package:flutter_text_recognition/feature/history/data/repo/purchase_repo_impl.dart';
import 'package:flutter_text_recognition/feature/history/data/repo/similarity_repo_impl.dart';
import 'package:flutter_text_recognition/feature/history/domain/contract_repository/camera_repo_abs.dart';
import 'package:flutter_text_recognition/feature/history/domain/contract_repository/mlkit_repo_abs.dart';
import 'package:flutter_text_recognition/feature/history/domain/contract_repository/pizza_repo_abs.dart';
import 'package:flutter_text_recognition/feature/history/domain/contract_repository/purchase_repo_abs.dart';
import 'package:flutter_text_recognition/feature/history/domain/contract_repository/similarity_repo_abs.dart';
import 'package:flutter_text_recognition/feature/history/data/data_source/local/camera/camera_platform_abs.dart';
import 'package:flutter_text_recognition/feature/history/data/data_source/local/camera/camera_platform_impl.dart';
import 'package:flutter_text_recognition/feature/history/data/data_source/local/ml_kit_local/ml_kit_local_abs.dart';
import 'package:flutter_text_recognition/feature/history/data/data_source/local/ml_kit_local/ml_kit_platform_impl.dart';
import 'package:flutter_text_recognition/feature/history/data/data_source/remote/pizza_history_remote/pizza_order_data_source_abs.dart';
import 'package:flutter_text_recognition/feature/history/data/data_source/remote/pizza_history_remote/pizza_order_data_source_impl.dart';
import 'package:flutter_text_recognition/feature/history/data/data_source/remote/purchase_order_remote/purchase_order_remote_abs.dart';
import 'package:flutter_text_recognition/feature/history/data/data_source/remote/purchase_order_remote/purchase_order_remote_impl.dart';
import 'package:flutter_text_recognition/feature/history/domain/usecase/order_history_usecase.dart';
import 'package:flutter_text_recognition/feature/history/domain/usecase/purchase_scan_usecase.dart';
import 'package:flutter_text_recognition/feature/history/presentation/bloc/pizza_history/pizza_history_bloc.dart';
import 'package:flutter_text_recognition/feature/history/presentation/bloc/scaner/scanner_bloc.dart';
import 'package:flutter_text_recognition/feature/profile/data/data_source/local/ml_kit/scan_ktp_ml_kit_abs.dart';
import 'package:flutter_text_recognition/feature/profile/data/data_source/local/ml_kit/scan_ktp_ml_kit_impl.dart';
import 'package:flutter_text_recognition/feature/profile/data/repo/scan_ktp_repo.dart';
import 'package:flutter_text_recognition/feature/profile/domain/contract_repo/scan_ktp_contract_repo.dart';
import 'package:flutter_text_recognition/feature/profile/domain/usecase/scan_ktp_usecase.dart';
import 'package:flutter_text_recognition/feature/profile/presentation/bloc/scan_ktp_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:image_picker/image_picker.dart';

final sl = GetIt.instance;

void init() {
// Feature
  //bloc
  sl.registerFactory(() => PizzaHistoryBloc(sl()));
  sl.registerFactory(() => ScanKtpBloc(scanKtpUsecase: sl()));
  sl.registerFactory(() => ScannerBloc(purchaseScanUsecase: sl()));

  //UseCase
  sl.registerLazySingleton<ScanKtpUsecase>(
      () => ScanKtpUsecase(scanKtpRepoAbs: sl()));
  sl.registerLazySingleton<OrderHistoryUsecase>(
      () => OrderHistoryUsecase(pizzaRepo: sl()));
  sl.registerLazySingleton<PurchaseScanUsecase>(
    () => PurchaseScanUsecase(
      purchaseRepo: sl(),
      cameraRepoAbs: sl(),
      mlkitRepoAbs: sl(),
      similarityRepo: sl(),
      pizzarepo: sl(),
    ),
  );

  //repo
  sl.registerLazySingleton<ScanKtpRepoAbs>(
      () => ScanKtpRepoImpl(scanKtpMlKit: sl()));
  sl.registerLazySingleton<SimilarityRepoAbs>(
      () => SimilarityRepoImpl(jaccard: sl()));
  sl.registerLazySingleton<PizzaRepoAbs>(
      () => PizzaRepoImpl(pizzaDataSource: sl()));
  sl.registerLazySingleton<PurchaseRepoAbs>(
      () => PurchaseRepoImpl(purchaseRemoteAbs: sl()));
  sl.registerLazySingleton<CameraRepoAbs>(
      () => CameraRepoImpl(cameraPlatform: sl()));
  sl.registerLazySingleton<MLRepoAbs>(() => MLKitRepoImpl(mlKit: sl()));

  //data
  sl.registerLazySingleton<ScanKtpMlKitAbs>(
      () => ScanKtpMlKitImpl(textRecognizer: sl()));
  sl.registerLazySingleton<PizzaHistoryDataSourceAbs>(
      () => PizzaHistoryDataSourceImpl(sl()));
  sl.registerLazySingleton<PurchaseRemoteAbs>(
      () => PurchaseRemoteDataImpl(firesBaseFirestore: sl()));
  sl.registerLazySingleton<CameraPlatformAbs>(
      () => CameraPlatformImpl(picker: sl()));
  sl.registerLazySingleton<MLKitLocalAbs>(
      () => MLKitPlatformImpl(textRecognizer: sl()));

// Core
  //feature.history.presentation

  //util

  //network

// External Dependency
  sl.registerLazySingleton(() => FirebaseFirestore.instance);
  sl.registerLazySingleton(() => ImagePicker());
  sl.registerLazySingleton(() => Levenshtein());
  sl.registerLazySingleton(() => Jaccard());
  sl.registerLazySingleton(() => FirebaseVision.instance.cloudTextRecognizer());
}
