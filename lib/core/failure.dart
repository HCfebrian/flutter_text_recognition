import 'package:equatable/equatable.dart';

class FirebaseFailure implements Exception {
  final message;

  FirebaseFailure(this.message);
}

class CameraFailure implements Exception {
  final message;

  CameraFailure(this.message);
}

class MLFailure implements Exception {
  final message;
  MLFailure( this.message);
}
