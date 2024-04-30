import 'package:flutter/material.dart';

class StyleManager {
  String fontFamily = 'Roboto';
  String secondaryFontFamily = 'Montserrat';
  Color primary = Colors.amber;
  Color secondary = const Color.fromARGB(255, 175, 137, 55);
  Color primaryLight = const Color.fromARGB(255, 170, 143, 102);
  Color primaryText = const Color(0xFF212121);
  Color primaryTextWhite = const Color(0xFFFFFFFF);
  Color secondaryText = const Color(0xFF9E9E9E);
  Color backgroundColor = Colors.white;
  Color darkBackgroundColor = const Color(0xFF212121);
  Color backgroundSecondary = Colors.grey.shade900;

  static final StyleManager _singleton = StyleManager._internal();
  StyleManager._internal();
  static StyleManager get instance => _singleton;
}
