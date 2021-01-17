import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_text_recognition/presentation/widget/dialog.dart';
import 'package:flutter_text_recognition/presentation/widget/image_result.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';
import 'package:meta/meta.dart';

class PurchaseScreenContent extends StatelessWidget {
  final String textFromDb;
  final String textFromMl;
  final File fileImage;
  final double similarity;
  final bool isShown;
  final String message;

  const PurchaseScreenContent({
    Key key,
    @required this.textFromDb,
    @required this.fileImage,
    @required this.similarity,
    @required this.textFromMl,
    this.isShown,
    this.message,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SlidingUpPanel(
      minHeight: 150,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          ImageContent(
            fileImage: fileImage,
          ),
          DialogManager(
            isShown: isShown,
            message: message,
          )
        ],
      ),
      panelBuilder: (ScrollController sc) {
        return Container(
          padding: EdgeInsets.only(left: 20, top: 10),
          child: ListView.builder(
              itemCount: 1,
              controller: sc,
              itemBuilder: (BuildContext context, int index) {
                return Column(
                  children: [
                    Align(
                        alignment: Alignment.center,
                        child: Text(similarity.toString())),
                  ],
                );
              }),
        );
      },
    );
  }
}
