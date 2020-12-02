import 'package:flutter/material.dart';

Widget textSpan(String text1, String text2, {Color c1, Color c2}) {
  return Text.rich(
    TextSpan(
      children: <TextSpan>[
        TextSpan(text: text1, style: TextStyle(color: c1)),
        TextSpan(text: text2, style: TextStyle(color: c2)),
      ],
    ),
  );
}
