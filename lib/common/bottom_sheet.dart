import 'package:bookclub/common/button.dart';
import 'package:bookclub/common/style_manager.dart';
import 'package:flutter/material.dart';

typedef OnTapCallback = void Function();

enum BottomSheetType { success, error, warning, info, custom }

class AppBottomSheet {
  final Widget? content;
  final BottomSheetType? type;
  final String? title;
  final String? message;
  final Widget? page;
  final double? height;
  final bool? isScroll;
  final IconData? icon;
  final String? textBotton;
  final OnTapCallback? onTap;

  AppBottomSheet(
      {this.page,
      this.content,
      this.type,
      this.title,
      this.message,
      this.onTap,
      this.height,
      this.icon,
      this.textBotton,
      this.isScroll = false});

  show(BuildContext context) {
    showModalBottomSheet(
        backgroundColor: StyleManager.instance.darkBackgroundColor,
        isScrollControlled: isScroll ?? false,
        context: context,
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
          topLeft: Radius.circular(20),
          topRight: Radius.circular(20),
        )),
        builder: (ctx) {
          switch (type) {
            case BottomSheetType.success:
              return _success(context);
            case BottomSheetType.error:
              return _error(context);
            case BottomSheetType.info:
              return _info(context);
            case BottomSheetType.warning:
              return _warning(context);
            case BottomSheetType.custom:
              return _custom(context);
            default:
              return Container();
          }
        });
  }

  _info(BuildContext context) {
    return SizedBox(
      height: height ?? MediaQuery.of(context).size.height * 0.6,
      child: Center(
          child: Padding(
        padding: const EdgeInsets.only(left: 25, right: 25),
        child: Column(
          children: [
            const SizedBox(height: 20),
            Icon(icon ?? Icons.info_outline, color: Colors.blue, size: 50),
            const SizedBox(height: 20),
            Text(
              title ?? '',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontFamily: StyleManager.instance.fontFamily,
                fontSize: 18,
                fontWeight: FontWeight.w700,
                color: Colors.white,
              ),
            ),
            const SizedBox(height: 10),
            Text(message ?? '',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontFamily: StyleManager.instance.fontFamily,
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                  color: Colors.white,
                )),
            const SizedBox(height: 20),
            AppButton(
                text: textBotton ?? "OK",
                onPressed: () {
                  if (onTap != null) {
                    onTap!();
                  }
                  Navigator.pop(context);
                })
          ],
        ),
      )),
    );
  }

  _success(BuildContext context) {
    return SizedBox(
      height: height ?? MediaQuery.of(context).size.height * 0.5,
      child: Center(
          child: Padding(
        padding: const EdgeInsets.only(left: 25, right: 25),
        child: Column(
          children: [
            const SizedBox(height: 20),
            Icon(icon ?? Icons.check_circle, color: Colors.green, size: 50),
            const SizedBox(height: 20),
            Text(title ?? '',
                style: TextStyle(
                  fontFamily: StyleManager.instance.fontFamily,
                  fontSize: 18,
                  fontWeight: FontWeight.w700,
                  color: Colors.white,
                )),
            const SizedBox(height: 10),
            Text(message ?? '',
                textAlign: TextAlign.center,
                style: TextStyle(
                    fontFamily: StyleManager.instance.fontFamily,
                    fontSize: 16,
                    color: Colors.white,
                    fontWeight: FontWeight.w500)),
            const SizedBox(height: 20),
            AppButton(
                text: textBotton ?? "OK",
                onPressed: () {
                  if (onTap != null) {
                    onTap!();
                  }
                  Navigator.pop(context);
                })
          ],
        ),
      )),
    );
  }

  _warning(BuildContext context) {
    return SizedBox(
      height: height ?? MediaQuery.of(context).size.height * 0.6,
      child: Center(
          child: Padding(
        padding: const EdgeInsets.only(left: 25, right: 25),
        child: Column(
          children: [
            const SizedBox(height: 20),
            Icon(icon ?? Icons.warning, color: Colors.orange, size: 50),
            const SizedBox(height: 20),
            Text(
              title ?? '',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontFamily: StyleManager.instance.fontFamily,
                fontSize: 18,
                fontWeight: FontWeight.w700,
                color: Colors.white,
              ),
            ),
            const SizedBox(height: 10),
            Text(message ?? '',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontFamily: StyleManager.instance.fontFamily,
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                  color: Colors.white,
                )),
            const SizedBox(height: 20),
            AppButton(
                text: textBotton ?? "OK",
                onPressed: () {
                  if (onTap != null) {
                    onTap!();
                  }
                  Navigator.pop(context);
                })
          ],
        ),
      )),
    );
  }

  _error(BuildContext context) {
    return SizedBox(
      height: height ?? MediaQuery.of(context).size.height * 0.5,
      child: Center(
          child: Padding(
        padding: const EdgeInsets.only(left: 25, right: 25),
        child: Column(
          children: [
            const SizedBox(height: 20),
            Icon(icon ?? Icons.error_outline,
                color: Colors.redAccent, size: 50),
            const SizedBox(height: 20),
            Text(title ?? '',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontFamily: StyleManager.instance.fontFamily,
                  fontSize: 18,
                  fontWeight: FontWeight.w700,
                  color: Colors.white,
                )),
            const SizedBox(height: 20),
            Text(message ?? '',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontFamily: StyleManager.instance.fontFamily,
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                  color: Colors.white,
                )),
            const SizedBox(height: 20),
            AppButton(
                text: textBotton ?? "OK",
                onPressed: () {
                  if (onTap != null) {
                    onTap!();
                  }
                  Navigator.pop(context);
                })
          ],
        ),
      )),
    );
  }

  _custom(BuildContext context) {
    return SizedBox(
      height: height ?? MediaQuery.of(context).size.height * 0.5,
      child: content,
    );
  }

  Future<void> successAlert(
    String? message,
    BuildContext context,
    OnTapCallback? onTap,
  ) async {
    AppBottomSheet(
      onTap: () {
        if (onTap != null) {
          onTap();
        }
        Navigator.pop(context);
      },
      type: BottomSheetType.success,
      title: "Pronto!",
      message: message,
    ).show(context);
  }

  Future<void> errorAlert(
    String? error,
    BuildContext context,
  ) async {
    AppBottomSheet(
      type: BottomSheetType.error,
      title: "Desculpe...",
      message: error,
    ).show(context);
  }
}
