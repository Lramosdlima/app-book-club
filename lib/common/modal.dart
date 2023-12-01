import 'package:flutter/material.dart';
import 'package:ndialog/ndialog.dart';

typedef OnDismissCallback = void Function();

class Modal {
  final Function(dynamic)? onPositive;
  final Function(dynamic)? onNegative;
  final OnDismissCallback? onDismiss;
  final String? title;
  final String? message;
  final bool dismissable;
  late NAlertDialog dialog;

  Modal(
      {this.onDismiss,
      this.onPositive,
      this.onNegative,
      this.title,
      this.message,
      this.dismissable = false});

  NAlertDialog setAlert(BuildContext context) {
    dialog = NAlertDialog(
      onDismiss: onDismiss,
      backgroundColor: Colors.black.withOpacity(.80),
      blur: 2,
      dismissable: dismissable,
      dialogStyle: DialogStyle(
          borderRadius: const BorderRadius.all(Radius.circular(10.0)),
          elevation: 10.0),
      actions: <Widget>[
        TextButton(
          child: const Text("OK"),
          onPressed: () {
            Navigator.pop(context);
            if (onDismiss != null) {
              onDismiss!();
            }
          },
        )
      ],
      title: Text(title ?? '',
          textAlign: TextAlign.center,
          style: const TextStyle(
              color: Colors.white,
              fontFamily: 'Manrope',
              fontWeight: FontWeight.w700,
              fontSize: 18)),
      content: Text(message ?? '',
          textAlign: TextAlign.center,
          style: const TextStyle(
              color: Colors.white, fontFamily: 'Manrope', fontSize: 12)),
    );
    return dialog;
  }
}
