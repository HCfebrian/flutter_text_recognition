

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get_it/get_it.dart';

final sl = GetIt.instance;


void init(){

// Feature
  //bloc

  //UseCase

  //repo

  //data


// Core
  //presentation

  //util

  //network

// External Dependency

  sl.registerLazySingleton(() => FirebaseFirestore.instance);



}