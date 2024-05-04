import 'package:bookclub/common/style_manager.dart';
import 'package:bookclub/common/text.dart';
import 'package:flutter/material.dart';

class AppCard extends StatelessWidget {
  final String title;
  final VoidCallback onPressed;
  final IconData? icon;
  final Color? color;

  const AppCard(
      {super.key, required this.title, required this.onPressed, this.icon, this.color});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 1,
      child: ListTile(
        onTap: onPressed,
        leading: Icon(icon, color: color ?? StyleManager.instance.primaryText),
        title: AppText(title, textColor: color,),
        trailing: Icon(
          Icons.arrow_forward_ios,
          size: 20,
          color: color ?? StyleManager.instance.secondaryText,
        ),
      ),
    );
  }
}
