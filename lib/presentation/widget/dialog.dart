import 'package:flutter/material.dart';

class DialogManager extends StatelessWidget {
  final isShown;
  final message;

  const DialogManager({Key key, @required this.isShown, this.message = "error"})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    isShown
        ? showDialog(
            context: context,
            builder: (context) {
              return Center(
                child: Container(
                  height: 200,
                  width: 100,
                  child: Text(message),
                ),
              );
            })
        : print("no");
    return Container(height: 0,width: 0,);
  }
}
