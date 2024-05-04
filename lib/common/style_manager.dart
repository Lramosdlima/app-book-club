import 'package:flutter/material.dart';

class StyleManager {
  String fontFamily = 'Roboto';
  String secondaryFontFamily = 'Montserrat';
  Color primary = const Color.fromARGB(255, 49, 35, 204);
  Color secondary = const Color.fromARGB(255, 63, 50, 207);
  Color tertiary = const Color.fromARGB(255, 99, 98, 177);
  Color secondaryText = const Color(0xFF9E9E9E);

  // DARK THEME
  Color primaryText = const Color(0xFFFFFFFF);
  Color backgroundColor = const Color(0xFF212121);
  Color backgroundSecondary = Colors.grey.shade900;

  // LIGHT THEME
  // Color primaryText = const Color.fromARGB(255, 47, 47, 47);
  // Color backgroundColor = const Color.fromARGB(255, 243, 243, 243);
  // Color backgroundSecondary = const Color.fromARGB(255, 196, 196, 196);

  static final StyleManager _singleton = StyleManager._internal();
  StyleManager._internal();
  static StyleManager get instance => _singleton;
}

class MyAppThemes {
  static final lightTheme = ThemeData(
    primaryColor: StyleManager.instance.primary,
    brightness: Brightness.light,
  );

  static final darkTheme = ThemeData(
    primaryColor: StyleManager.instance.primary,
    brightness: Brightness.dark,
    colorScheme: ColorScheme.dark(
      primary: StyleManager.instance.primary,
      secondary: StyleManager.instance.secondary,
    ),
  );
}
