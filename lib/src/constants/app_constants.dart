import 'package:flutter/material.dart';

class AppConst {
  static const String appName = 'Flutter Application';

  static const int apiVersion = 1;
  static const String serverURL = 'https://gcodex.rezonia.com'; //'https://gcodex.rezer.app';

  static const MaterialColor primaryColor = Colors.deepPurple;
  static const MaterialColor textColor = Colors.grey;
  static const Color accentColor = Color(0x80383838);

  static const MaterialColor themeColor = MaterialColor(
    _themeValue,
    <int, Color>{
      50: Color(0xFF9E9E9E),
      100: Color(0xFF2D2D2D),
      200: Color(0xFF1E1E1E),
      300: Color(0xFF121212),
      400: Color(0xFF121212),
      500: Color(_themeValue),
      600: Color(0xFF121212),
      700: Color(0xFF121212),
      800: Color(0xFF121212),
      900: Color(0xFF121212),
    },
  );
  static const int _themeValue = 0xFF121212;
}
