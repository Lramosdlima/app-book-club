import 'package:flutter/material.dart';

class TColor {
  static String fontFamily = 'Roboto';
  static String secondaryFontFamily = 'Montserrat';
  static Color get primary => const Color(0xFF6C7ACC);
  static Color get secondary => const Color(0xFF3749AF);
  static Color get primaryLight => const Color(0xFF6670AA);
  static Color get primaryText => const Color(0xFF212121);
  static Color get primaryTextWhite => Color(0xFFFFFFFF);
  static Color get subTitle => const Color(0xFF212121).withOpacity(0.4);
  static Color get secondaryText => const Color(0xFF9E9E9E);

  static List<Color> get button => const [Color(0xFF3F51B5), Color(0xFF3245AF)];
}
