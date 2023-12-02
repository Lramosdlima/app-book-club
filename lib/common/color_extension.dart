import 'package:flutter/material.dart';

class TColor {
  static String fontFamily = 'Roboto';
  static String secondaryFontFamily = 'Montserrat';
  static Color get primary => Color.fromARGB(255, 204, 170, 108);
  static Color get secondary => Color.fromARGB(255, 175, 137, 55);
  static Color get primaryLight => Color.fromARGB(255, 170, 143, 102);
  static Color get primaryText => const Color(0xFF212121);
  static Color get primaryTextWhite => const Color(0xFFFFFFFF);
  static Color get subTitle => const Color(0xFF212121).withOpacity(0.4);
  static Color get secondaryText => const Color(0xFF9E9E9E);

  static List<Color> get button => const [Color(0xFF3F51B5), Color(0xFF3245AF)];
}
