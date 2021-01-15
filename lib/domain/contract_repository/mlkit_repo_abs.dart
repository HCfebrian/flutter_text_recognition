import 'dart:io';




abstract class MLRepoAbs {
  Future< String> getPurchaseID(File imageFile);
  Future< String> getFullText(File imageFile);
}

