import 'package:bookclub/common/style_manager.dart';
import 'package:bookclub/common/validator.dart';
import 'package:flutter/material.dart';

class AppTextField extends StatelessWidget {
  final TextEditingController controller;
  final String? hintText;
  final String? label;
  final IconData? icon;
  final bool isPassword;
  final int? minLines;
  final int? maxLines;
  final int? maxLength;

  const AppTextField(
      {super.key,
      required this.controller,
      this.hintText,
      this.label,
      this.maxLines,
      this.minLines,
      this.maxLength,
      this.icon,
      this.isPassword = false});

  @override
  Widget build(BuildContext context) {
    var border = OutlineInputBorder(
        borderRadius: BorderRadius.circular(18),
        borderSide: const BorderSide(color: Colors.white));
    return TextFormField(
      style: TextStyle(color: StyleManager.instance.primaryText),
      controller: controller,
      minLines: minLines,
      maxLines: maxLines,
      maxLength: maxLength,
      validator: Validator().validateField,
      decoration: InputDecoration(
        hintText: hintText,
        hintStyle: TextStyle(color: StyleManager.instance.secondaryText),
        label: label == null ? null : Text(label!),
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
