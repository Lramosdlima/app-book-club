import 'package:flutter/material.dart';
import 'package:ndialog/ndialog.dart';
import 'package:awesome_dialog/awesome_dialog.dart';

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

  // NAlertDialog setAlert(BuildContext context) {
  //   return NAlertDialog(
  //     onDismiss: onDismiss,
  //     backgroundColor: Colors.black.withOpacity(.80),
  //     blur: 2,
  //     dismissable: dismissable,
  //     dialogStyle: DialogStyle(
  //         borderRadius: const BorderRadius.all(Radius.circular(10.0)),
  //         elevation: 10.0),
  //     actions: <Widget>[
  //       TextButton(
  //         child: const Text("OK"),
  //         onPressed: () {

  //           if (onDismiss != null) {
  //             onDismiss!();
  //           }
  //         },
  //       )
  //     ],
  //     title: Text(title ?? '',
  //         textAlign: TextAlign.center,
  //         style: const TextStyle(
  //             color: Colors.white,
  //             fontFamily: 'Manrope',
  //             fontWeight: FontWeight.w700,
  //             fontSize: 18)),
  //     content: Text(message ?? '',
  //         textAlign: TextAlign.center,
  //         style: const TextStyle(
  //             color: Colors.white, fontFamily: 'Manrope', fontSize: 12)),
  //   );
  // }

  setAlert(BuildContext context) {
    return AwesomeDialog(
      context: context,
      dialogType: DialogType.infoReverse,
      headerAnimationLoop: true,
      animType: AnimType.bottomSlide,
      title: title,
      reverseBtnOrder: true,
      btnOkOnPress: () {},
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
      btnOkOnPress: () {},
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
      btnOkOnPress: () {},
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
