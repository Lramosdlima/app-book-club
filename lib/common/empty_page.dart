import 'package:bookclub/common/StyleManager.dart';
import 'package:flutter/material.dart';

class EmptyPage extends StatelessWidget {
  final String text;
  const EmptyPage({Key? key, this.text = "Nenhum dado disponível"})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
        text,
        textAlign: TextAlign.center,
        style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.w500,
            fontFamily: StyleManager.instance.secondaryFontFamily,
            color: StyleManager.instance.secondaryText),
      ),
    );
  }
}
