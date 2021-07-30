import 'package:flutter/material.dart';

class BotaoPadrao extends StatelessWidget {
  final Function() onPressed;
  final String title;
  final Color backgroundColor;
  const BotaoPadrao({Key key, this.onPressed, this.title, this.backgroundColor})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        height: 50.0,
        width: 155,
        child: RaisedButton(
            color: backgroundColor,
            shape: OutlineInputBorder(
                borderSide: BorderSide.none,
                borderRadius: BorderRadius.all(Radius.circular(12))),
            onPressed: onPressed,
            child: Text(
              "$title",
              style: TextStyle(color: Colors.white),
            )));
  }
}
