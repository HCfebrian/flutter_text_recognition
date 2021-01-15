import 'dart:io';

abstract class MLKitLocalAbs {
  Future<String> getPurchaseId(File imageFile);

  Future<String> getFullText(File imageFile);
}
