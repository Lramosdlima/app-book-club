import 'package:bookclub/common/style_manager.dart';
import 'package:flutter/material.dart';

class AppTextField extends StatelessWidget {
  final TextEditingController controller;
  final String hintText;
  final IconData? icon;
  final bool isPassword;

  const AppTextField(
      {super.key,
      required this.controller,
      required this.hintText,
      this.icon,
      this.isPassword = false});

  @override
  Widget build(BuildContext context) {
    var border = OutlineInputBorder(
        borderRadius: BorderRadius.circular(18),
        borderSide: const BorderSide(color: Colors.white));
    return TextFormField(
      style: TextStyle(color: StyleManager.instance.primaryTextWhite),
      controller: controller,
      decoration: InputDecoration(
        hintText: hintText,
        hintStyle: TextStyle(color: StyleManager.instance.primaryTextWhite),
        enabledBorder: border,
        focusedBorder: border,
        fillColor: Theme.of(context).primaryColor.withOpacity(0.1),
        filled: true,
        prefixIcon: Icon(icon, color: Colors.white),
      ),
      obscureText: isPassword,
    );
  }
}
