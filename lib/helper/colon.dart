import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

Row displayProperty<T>(BuildContext context, String key, T? value,
    {DateFormat? formatter, IconData? icon}) {
  List<Widget> rowChildren = [];

  rowChildren.add(Icon(icon));

  List<InlineSpan> textChildren = [];

  if (value != null) {
    var valueText = value.toString();
    if (value is DateTime) {
      if (formatter == null) {
        throw ArgumentError.notNull();
      }
      valueText = formatter.format(value.toLocal());
    }
    textChildren.add(TextSpan(
        text: ' $valueText',
        style: TextStyle(color: Theme.of(context).primaryColor)));
  }
  final text = TextSpan(
      text: '$key:',
      children: textChildren,
      style: TextStyle(
          fontWeight: FontWeight.bold, color: Theme.of(context).primaryColor));
  rowChildren.add(RichText(text: text));
  return Row(
    mainAxisAlignment: MainAxisAlignment.start,
    children: rowChildren,
  );
}
