import 'dart:io';

import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_text_recognition/feature/history/data/data_source/local/camera/camera_platform_abs.dart';
import 'package:flutter_text_recognition/feature/history/data/repo/canera_repo_impl.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mockito/mockito.dart';

class MockCameraPlatform extends Mock implements CameraPlatformAbs {}

main() {
  MockCameraPlatform cameraPlatform;
  CameraRepoImpl cameraRepoImpl;

  setUp(() {
    cameraPlatform = MockCameraPlatform();
    cameraRepoImpl = CameraRepoImpl(cameraPlatform: cameraPlatform);
  });

  final tFile = File("example/of/storage");

  test(
    "should return File",
    () async {
      //arrange
      when(cameraPlatform.getImage(any))
          .thenAnswer((realInvocation) async => tFile);
      //act
      final result = await cameraRepoImpl.getImage(ImageSource.camera);
      //assert
      expect(result, tFile);
    },
  );
}
