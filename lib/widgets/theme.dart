import 'package:flex_color_scheme/flex_color_scheme.dart';
import 'package:flutter/material.dart';

mixin ShipantherTheme {
  static ThemeData get lightTheme => FlexColorScheme.light(
        colors: FlexSchemeColor.from(primary: const Color(0xFF9540FC)),
        // Use comfortable on desktops instead of compact, devices use default.
        visualDensity: FlexColorScheme.comfortablePlatformDensity,
        fontFamily: 'Roboto',
      ).toTheme;
  static ThemeData get darkTheme => FlexColorScheme.dark(
        colors: FlexSchemeColor.from(primary: const Color(0xFFBB86FC)),
        // Use comfortable on desktops instead of compact, devices use default.
        visualDensity: FlexColorScheme.comfortablePlatformDensity,
        darkIsTrueBlack: true,
        fontFamily: 'Roboto',
      ).toTheme;
}
