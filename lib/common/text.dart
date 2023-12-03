import 'package:bookclub/common/StyleManager.dart';
import 'package:flutter/material.dart';

class AppText extends StatelessWidget {
  final String text;
  final Color? textColor;
  final bool isTitle;

  const AppText({
    super.key,
    required this.text,
    this.textColor,
    this.isTitle = false,
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      textAlign: TextAlign.center,
      style: TextStyle(
        color: textColor ?? StyleManager.instance.primaryTextWhite,
        fontSize: isTitle ? 17 : 14,
        fontWeight: isTitle ? FontWeight.bold : FontWeight.normal,
      ),
    );
  }
}
