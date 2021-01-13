import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:edit_distance/edit_distance.dart';
import 'package:firebase_ml_vision/firebase_ml_vision.dart';
import 'package:flutter_text_recognition/data/data_source/platform/camera_platform/camera_platform_abs.dart';
import 'package:flutter_text_recognition/data/data_source/platform/ml_kit_platform/ml_kit_platform_abs.dart';
import 'package:flutter_text_recognition/data/data_source/platform/ml_kit_platform/ml_kit_platform_impl.dart';
import 'package:flutter_text_recognition/data/data_source/remote/purchase_order_remote/purchase_order_remote_abs.dart';
import 'package:flutter_text_recognition/data/data_source/remote/purchase_order_remote/purchase_order_remote_impl.dart';
import 'package:flutter_text_recognition/data/repository/canera_repo_impl.dart';
import 'package:flutter_text_recognition/data/repository/mlkit_repo_impl.dart';
import 'package:flutter_text_recognition/data/repository/purchase_repo_impl.dart';
import 'package:flutter_text_recognition/domain/contract_repository/camera_contract_repo.dart';
import 'package:flutter_text_recognition/domain/contract_repository/mlkit_contract_repo.dart';
import 'package:flutter_text_recognition/domain/contract_repository/purchase_contract_repo.dart';
import 'package:flutter_text_recognition/domain/usecase/purchase_usecase.dart';
import 'package:flutter_text_recognition/presentation/bloc/bloc_similarity_image/process_image_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:image_picker/image_picker.dart';
import 'data/data_source/platform/camera_platform/camera_platform_impl.dart';

final sl = GetIt.instance;

void init() {
// Feature
  //bloc
  sl.registerFactory(() => SimilarityImageBloc(purchaseUsecase: sl()));
  //UseCase
  sl.registerLazySingleton(() => PurchaseUsecase(
        purchaseRepo: sl(),
        cameraRepoAbs: sl(),
        levenshtein: sl(),
        mlkitRepoAbs: sl(),
      ));

  //repo
  sl.registerLazySingleton<PurchaseRepoAbs>(
      () => PurchaseRepoImpl(purchaseRemoteAbs: sl()));
  sl.registerLazySingleton<CameraRepoAbs>(
      () => CameraRepoImpl(cameraPlatform: sl()));
  sl.registerLazySingleton<MLKitRepoAbs>(
      () => MLKitRepoImpl(mlKitPlatform: sl()));

  //data
  sl.registerLazySingleton<PurchaseRemoteAbs>(
      () => PurchaseRemoteDataImpl(firesBaseFirestore: sl()));
  sl.registerLazySingleton<CameraPlatformAbs>(
      () => CameraPlatformImpl(picker: sl()));
  sl.registerLazySingleton<MLKitPlatformAbs>(
      () => MLKitPlatformImpl(textRecognizer: sl()));

// Core
  //presentation

  //util

  //network

// External Dependency

  sl.registerLazySingleton(() => FirebaseFirestore.instance);
  sl.registerLazySingleton(() => ImagePicker());
  sl.registerLazySingleton(() => Levenshtein());
  sl.registerLazySingleton(() => FirebaseVision.instance.textRecognizer());
}
