import 'package:bookclub/common/styleManager.dart';
import 'package:bookclub/common/text.dart';
import 'package:flutter/material.dart';

class AppButton extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;
  final Color? backgroundColor;
  final Color? textColor;
  final Icon? icon;

  const AppButton(
      {super.key,
      required this.text,
      required this.onPressed,
      this.backgroundColor,
      this.textColor,
      this.icon});

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
        onPressed: onPressed,
        textColor: textColor ?? StyleManager.instance.primaryText,
        color: backgroundColor ?? StyleManager.instance.primary,
        minWidth: double.maxFinite,
        height: 50,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            icon ?? const SizedBox(),
            icon != null ? const SizedBox(width: 20) : const SizedBox(),
            AppText(
                text: text,
                textColor: textColor ?? StyleManager.instance.primaryTextWhite,
                isTitle: true)
          ],
        ));
  }
}
