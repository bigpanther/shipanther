import 'package:flutter/material.dart';

class ExtraActionsButton<T> extends StatelessWidget {
  const ExtraActionsButton({
    required this.onSelected,
    required Key key,
    required this.possibleValues,
  }) : super(key: key);

  final List<T> possibleValues;
  final PopupMenuItemSelected<T> onSelected;

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton<T>(
      onSelected: onSelected,
      itemBuilder: (BuildContext context) {
        return possibleValues
            .map((e) => PopupMenuItem<T>(
                  value: e,
                  child: Text(e.toString()),
                ))
            .toList();
      },
    );
  }
}
