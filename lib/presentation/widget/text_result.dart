import 'package:flutter/material.dart';

class ResultWidget extends StatelessWidget {
  final String result;
  final sc;

  const ResultWidget({
    Key key,
    this.result = "loading",
    this.sc,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(left: 20, top: 10),
      child: ListView.builder(
          itemCount: 1,
          controller: sc,
          itemBuilder: (BuildContext context, int index) {
            return Column(children: [
              Center(
                child: Container(
                  padding: EdgeInsets.symmetric(vertical: 10),
                  child: Text(
                    "result".toUpperCase(),
                    style: TextStyle(fontSize: 25, fontWeight: FontWeight.w700),
                  ),
                ),
              ),
              Align(alignment: Alignment.center, child: Text(result))
            ]);
          }),
    );
  }
}
