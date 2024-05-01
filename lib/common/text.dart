import 'package:bookclub/common/style_manager.dart';
import 'package:flutter/material.dart';

enum TextType { title, subtitle, normal }

class AppText extends StatelessWidget {
  final String text;
  final Color? textColor;
  final double? size;
  final TextType? type;

  const AppText(
    this.text, {
    super.key,
    this.size,
    this.textColor,
    this.type,
  });

  @override
  Widget build(BuildContext context) {
    double size;
    TextAlign textAlign;
    FontWeight fontWeight;

    switch (type) {
      case TextType.title:
        size = 25;
        fontWeight = FontWeight.bold;
        textAlign = TextAlign.center;
        break;
      case TextType.subtitle:
        size = 20;
        fontWeight = FontWeight.normal;
        textAlign = TextAlign.justify;
        break;
      case TextType.normal:
        size = 17;
        fontWeight = FontWeight.normal;
        textAlign = TextAlign.justify;
        break;
      default:
        size = 17;
        fontWeight = FontWeight.normal;
        textAlign = TextAlign.justify;
    }

    return Text(
      text,
      textAlign: textAlign,
      style: TextStyle(
        fontSize: this.size ?? size,
        color: textColor ?? StyleManager.instance.primaryText,
        fontWeight: fontWeight,
      ),
    );
  }
}
