import 'package:estate_app/src/utils/const.dart';
import 'package:flutter/material.dart';

class TextView extends StatelessWidget {
  final String text;
  final Color textColor;
  final FontWeight fontWeight;
  final double sizeText;

  const TextView({Key key, this.text, this.textColor, this.fontWeight,this.sizeText}) : super(key: key);@override

  Widget build(BuildContext context) {
    return Text(
      text,
      style: TextStyle(
        color: textColor,
        fontFamily: kFontBold,
        fontWeight: fontWeight,
        fontSize: sizeText,
      ),
    );
  }
}
