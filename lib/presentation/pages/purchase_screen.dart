import 'package:flutter/material.dart';
import 'package:flutter_text_recognition/presentation/pages/purchase_page.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';

class PurchaseScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SlidingUpPanel(
        minHeight: 150,
        body: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Text("Use me")
          ],
        ),
        panelBuilder: (ScrollController sc){
          return ResultWidget(
            sc: sc,
            result: "halo",
          );
        },
      ),
      floatingActionButton: FloatingActionButton(onPressed: () {

      },

      ),
    );
  }
}
