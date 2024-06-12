import 'package:flutter/material.dart';
import 'package:awesome_dialog/awesome_dialog.dart';

typedef OnDismissCallback = void Function();

class Modal {
  final Function(dynamic)? onPositive;
  final Function(dynamic)? onNegative;
  final OnDismissCallback? onDismiss;
  final String? title;
  final String? message;
  final bool dismissable;

  Modal(
      {this.onDismiss,
      this.onPositive,
      this.onNegative,
      this.title,
      this.message,
      this.dismissable = false});

  setAlert(BuildContext context) {
    return AwesomeDialog(
      context: context,
      dialogType: DialogType.infoReverse,
      headerAnimationLoop: true,
      animType: AnimType.bottomSlide,
      title: title,
      reverseBtnOrder: true,
      btnOkOnPress: () {
        if (onDismiss != null) {
          onDismiss!();
        }
      },
      btnCancelOnPress: () {},
      desc: message,
    ).show();
  }

  errorAlert(String? error, BuildContext context) {
    AwesomeDialog(
      context: context,
      dialogType: DialogType.error,
      animType: AnimType.rightSlide,
      headerAnimationLoop: false,
      title: 'Error',
      desc: '$error!',
      btnOkOnPress: () {
        if (onDismiss != null) {
          onDismiss!();
        }
      },
      btnOkIcon: Icons.cancel,
      btnOkColor: Colors.red,
    ).show();
  }

  alertAlert(String? error, BuildContext context) {
    AwesomeDialog(
      context: context,
      dialogType: DialogType.warning,
      animType: AnimType.rightSlide,
      headerAnimationLoop: false,
      title: 'Alerta',
      desc: '$error!',
      btnOkOnPress: () {
        if (onDismiss != null) {
          onDismiss!();
        }
      },
      btnOkIcon: Icons.cancel,
      btnOkColor: Colors.orange,
    ).show();
  }

  successAlert(String? data, BuildContext context) {
    var message = data ?? 'Realizado com sucesso!';
    AwesomeDialog(
      context: context,
      animType: AnimType.leftSlide,
      headerAnimationLoop: false,
      dialogType: DialogType.success,
      showCloseIcon: true,
      title: 'Sucesso!',
      desc: message,
      autoHide: const Duration(seconds: 2),
      btnOkOnPress: () {
        debugPrint('OnClcik');
      },
      btnOkIcon: Icons.check_circle,
      onDismissCallback: (type) {
        debugPrint('Dialog Dissmiss from callback $type');
      },
    ).show();
  }
}
