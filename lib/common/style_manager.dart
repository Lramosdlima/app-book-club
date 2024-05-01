import 'package:flutter/material.dart';

class StyleManager {
  String fontFamily = 'Roboto';
  String secondaryFontFamily = 'Montserrat';
  Color primary = const Color.fromARGB(255, 51, 33, 243);
  Color secondary = Color.fromARGB(255, 61, 55, 175);
  Color primaryLight = Color.fromARGB(255, 103, 102, 170);
  Color primaryText = const Color(0xFFFFFFFF);
  Color secondaryText = const Color(0xFF9E9E9E);
  Color backgroundColor = Colors.white;
  Color darkBackgroundColor = const Color(0xFF212121);
  Color backgroundSecondary = Colors.grey.shade900;

  static final StyleManager _singleton = StyleManager._internal();
  StyleManager._internal();
  static StyleManager get instance => _singleton;
}
