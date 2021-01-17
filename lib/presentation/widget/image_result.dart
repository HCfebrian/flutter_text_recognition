import 'package:flutter/material.dart';

class ImageContent extends StatelessWidget {
  final fileImage;

  const ImageContent({Key key, this.fileImage}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return fileImage == null
        ? Center(child: Text("Use me please!"))
        : Image.file(fileImage);
  }
}
