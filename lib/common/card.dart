import 'package:bookclub/common/style_manager.dart';
import 'package:bookclub/common/text.dart';
import 'package:flutter/material.dart';

class AppCard extends StatelessWidget {
  final String title;
  final VoidCallback onPressed;
  final IconData? icon;

  const AppCard(
      {super.key, required this.title, required this.onPressed, this.icon});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 1,
      child: ListTile(
        onTap: onPressed,
        leading: Icon(icon, color: StyleManager.instance.primaryTextWhite),
        title: AppText(title),
        trailing: Icon(
          Icons.arrow_forward_ios,
          size: 20,
          color: StyleManager.instance.secondaryText,
        ),
      ),
    );
  }
}
