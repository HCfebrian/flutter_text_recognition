import 'dart:io';

import 'dart:ui';

abstract class MLKitLocalAbs {
  Future<String> getPurchaseId({File imageFile,Size size});

  Future<String> getFullText(File imageFile);

  bool setCameraSize(Size size);
}
