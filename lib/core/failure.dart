import 'package:equatable/equatable.dart';

abstract class Failure extends Equatable {
  final String message;

  Failure(this.message);

  @override
  List<Object> get props => [message];
}

class FirebaseFailure extends Failure {
  FirebaseFailure(String message) : super(message);
}

class CameraFailure extends Failure {
  CameraFailure(String message) : super(message);
}

class MLFailure extends Failure {
  MLFailure(String message) : super(message);
}