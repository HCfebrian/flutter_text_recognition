import 'package:camera_camera/camera_camera.dart';
import 'package:flutter/material.dart';
import 'package:flutter_text_recognition/core/global_variable.dart';


class CustomCamera extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    GlobalVariable.size = MediaQuery.of(context).size;
    return Scaffold(
      body: Stack(
        children: [
          Camera(
            mode: CameraMode.normal,
            enableCameraChange: false,
            orientationEnablePhoto: CameraOrientation.portrait,
            imageMask: _FocusRectangle(
              color: Colors.black.withOpacity(0.5),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                margin: EdgeInsets.only(
                    top: MediaQuery.of(context).size.height * 0.045),
                child: Text(
                  "Place your receipt and Receipt ID within the box",
                  style: TextStyle(
                      fontSize: MediaQuery.of(context).size.width * 0.04,
                      color: Colors.white,
                      fontWeight: FontWeight.w700),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _FocusRectangle extends StatelessWidget {
  final Color color;

  const _FocusRectangle({Key key, this.color}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        AspectRatio(
          aspectRatio: 720 / 1280,
          child: Container(
            child: Column(
              children: [
                Flexible(
                  flex: 1,
                  child: Container(),
                ),
                Flexible(
                  flex: 1,
                  child: Container(
                    width: MediaQuery.of(context).size.width * 0.5,
                    color: Colors.black.withOpacity(0.3),
                  ),
                ),
                Flexible(
                  flex: 8,
                  child: Container(),
                )
              ],
            ),
          ),
        )
      ],
    );
  }
}
