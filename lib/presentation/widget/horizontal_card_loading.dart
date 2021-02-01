import 'package:flutter/material.dart';
import 'package:flutter_text_recognition/core/colors.dart';
import 'package:shimmer/shimmer.dart';

class HorizontalCardLoading extends StatelessWidget {
  const HorizontalCardLoading({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: Colors.grey[200],
      highlightColor: Colors.white,
      child: Container(
        height: 120,
        margin: EdgeInsets.symmetric(vertical: 6, horizontal: 16),
        decoration: BoxDecoration(
            color: appColorCardBackground,
            borderRadius: BorderRadius.all(Radius.circular(8))),
      ),
    );
  }
}
