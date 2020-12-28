import 'package:flutter/material.dart';

mixin ShipantherTheme {
  static ThemeData get theme {
    final themeData = ThemeData.dark();
    final textTheme = themeData.textTheme;
    final bodyText2 = (textTheme.bodyText2 != null)
        ? textTheme.bodyText2!.copyWith(decorationColor: Colors.transparent)
        : const TextStyle(decorationColor: Colors.transparent);

    return ThemeData.dark().copyWith(
      primaryColor: Colors.grey[800],
      accentColor: Colors.cyan[300],
      buttonColor: Colors.grey[800],
      // buttonColor: Color.fromRGBO(236, 77, 55, 1),
      toggleableActiveColor: Colors.cyan[300],
      floatingActionButtonTheme: FloatingActionButtonThemeData(
        backgroundColor: Colors.cyan[300],
      ),
      snackBarTheme: SnackBarThemeData(
        backgroundColor: themeData.dialogBackgroundColor,
        contentTextStyle: bodyText2,
        actionTextColor: Colors.cyan[300],
      ),
      textTheme: textTheme.copyWith(
        bodyText2: bodyText2,
      ),
      textSelectionTheme: TextSelectionThemeData(
        selectionColor: Colors.cyan[100],
      ),
    );
  }
}
