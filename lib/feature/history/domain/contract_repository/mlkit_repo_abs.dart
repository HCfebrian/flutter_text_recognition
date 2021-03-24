import 'dart:io';

import 'dart:ui';

abstract class MLRepoAbs {
  Future< String> getPurchaseID({File imageFile});
  Future< String> getFullText(File imageFile);
  bool setCameraSize(Size size);
}

