import 'package:bookclub/common/style_manager.dart';
import 'package:flutter/material.dart';

class EmptyPage extends StatelessWidget {
  final String text;
  final Icon? icon;
  const EmptyPage({Key? key, this.text = "Nenhum dado disponível", this.icon})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: MediaQuery.of(context).size.height,
      width: MediaQuery.of(context).size.width,
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              text,
              textAlign: TextAlign.center,
              style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w500,
                  fontFamily: StyleManager.instance.secondaryFontFamily,
                  color: StyleManager.instance.secondaryText),
            ),
            const SizedBox(height: 10),
            icon ??
                Icon(Icons.cancel,
                    size: 40, color: StyleManager.instance.secondaryText),
          ],
        ),
      ),
    );
  }
}
