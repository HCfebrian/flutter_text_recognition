

class FirebaseException implements Exception {
  final message;

  FirebaseException(this.message);
}

class CameraException implements Exception {
  final message;

  CameraException(this.message);
}

class MLException implements Exception {
  final message;
  MLException( this.message);
}

class SimilarityException implements Exception {
  final message;
  SimilarityException( this.message);
}

