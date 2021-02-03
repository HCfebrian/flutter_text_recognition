import 'package:camera_camera/camera_camera.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_text_recognition/core/global_variable.dart';
import 'package:flutter_text_recognition/presentation/bloc/scaner/scanner_bloc.dart';

class CustomCamera extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // BlocProvider.of<ScannerBloc>(context).add(
    //   SetCameraSizeEvent(MediaQuery.of(context).size),
    // );
    GlobalVariable.size = MediaQuery.of(context).size;
    return Scaffold(
      body: Stack(
        children: [
          Camera(
            mode: CameraMode.fullscreen,
            enableCameraChange: false,
            orientationEnablePhoto: CameraOrientation.portrait,
            imageMask: _FocusRectangle(
              color: Colors.red.withOpacity(0.5),
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
          CustomPaint(
            painter: new ReceiptIdBox(context),
          )
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
    return IgnorePointer(
      child: ClipPath(
        child: Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          color: color,
        ),
        clipper: _RectangleModePhoto(),
      ),
    );
  }
}

class _RectangleModePhoto extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    var path = Path();
    var reactPath = Path();

    reactPath.moveTo(size.width / 20, size.height / 10);
    reactPath.lineTo(size.width / 20, size.height * 8.5 / 10);
    reactPath.lineTo(size.width * 19 / 20, size.height * 8.6 / 10);
    reactPath.lineTo(size.width * 19 / 20, size.height / 10);

    path.addPath(reactPath, Offset(0, 0));
    path.addRect(Rect.fromLTWH(0.0, 0.0, size.width, size.height));
    path.fillType = PathFillType.evenOdd;

    path.close();
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) {
    return true;
  }
}

class ReceiptIdBox extends CustomPainter {
  final context;

  ReceiptIdBox(this.context);

  @override
  void paint(Canvas canvas, Size size) {
    Size size = MediaQuery.of(context).size;
    canvas.drawRect(
      new Rect.fromLTRB(size.width * 0.25, size.height * 0.2, size.width * 0.75,
          size.height * 0.15),
      new Paint()..color = Colors.black.withOpacity(0.1),
    );
  }

  @override
  bool shouldRepaint(ReceiptIdBox oldDelegate) {
    return false;
  }
}
