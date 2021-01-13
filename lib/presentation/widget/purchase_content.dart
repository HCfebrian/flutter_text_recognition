import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_text_recognition/presentation/widget/text_result.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';

class PurchaseScreenContent extends StatelessWidget {
  final String text;
  final File fileImage;
  final double similarity;

  const PurchaseScreenContent({
    Key key,
    this.text,
    this.fileImage,
    this.similarity,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SlidingUpPanel(
      minHeight: 150,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          fileImage == null ? Center(child: Text("Use me please!")) : Image.file(fileImage)
        ],
      ),
      panelBuilder: (ScrollController sc) {
        return ResultWidget(
          sc: sc,
          result: text,
        );
      },
    );
  }
}
