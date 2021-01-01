import 'package:flutter/material.dart';
import 'package:flex_color_scheme/flex_color_scheme.dart';

mixin ShipantherTheme {
  static ThemeData get lightTheme => FlexColorScheme.light(
        colors: FlexColor.schemes[FlexScheme.indigo]!.light,
        // Use comfortable on desktops instead of compact, devices use default.
        visualDensity: FlexColorScheme.comfortablePlatformDensity,
        fontFamily: 'Roboto',
      ).toTheme;
  static ThemeData get darkTheme => FlexColorScheme.light(
        colors: FlexColor.schemes[FlexScheme.indigo]!.dark,
        // Use comfortable on desktops instead of compact, devices use default.
        visualDensity: FlexColorScheme.comfortablePlatformDensity,
        fontFamily: 'Roboto',
      ).toTheme;
}
