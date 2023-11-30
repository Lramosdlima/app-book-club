import 'package:bookclub/common/color_extension.dart';
import 'package:flutter/material.dart';

class AppButton extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;
  final Color? backgroundColor;
  final Color? textColor;

  const AppButton(
      {super.key,
      required this.text,
      required this.onPressed,
      this.backgroundColor,
      this.textColor});

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
        onPressed: onPressed,
        textColor: textColor ?? TColor.primarytext,
        color: backgroundColor ?? TColor.primary,
        minWidth: double.maxFinite,
        height: 50,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        child: Text(
          text,
          style: TextStyle(
            color: textColor ?? TColor.primarytextWhite,
            fontWeight: FontWeight.w500,
            fontSize: 17,
          ),
        ));
  }
}
