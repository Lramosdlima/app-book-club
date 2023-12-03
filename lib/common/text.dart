import 'package:bookclub/common/style_manager.dart';
import 'package:flutter/material.dart';

enum TextType { title, subtitle, normal }

class AppText extends StatelessWidget {
  final String text;
  final Color? textColor;
  final TextType? type;

  const AppText(
    this.text, {
    super.key,
    this.textColor,
    this.type,
  });

  @override
  Widget build(BuildContext context) {
    double size;
    FontWeight fontWeight;

    switch (type) {
      case TextType.title:
        size = 30;
        fontWeight = FontWeight.bold;
        break;
      case TextType.subtitle:
        size = 20;
        fontWeight = FontWeight.normal;
        break;
      case TextType.normal:
        size = 17;
        fontWeight = FontWeight.normal;
        break;
      default:
        size = 17;
        fontWeight = FontWeight.normal;
    }

    return Text(
      text,
      textAlign: TextAlign.center,
      style: TextStyle(
        fontSize: size,
        color: StyleManager.instance.primaryTextWhite,
        fontWeight: fontWeight,
      ),
    );
  }
}
