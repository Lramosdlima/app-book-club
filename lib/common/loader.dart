import 'package:bookclub/common/style_manager.dart';
import 'package:flutter/material.dart';
import 'package:ndialog/ndialog.dart';

class Loader {
  late CustomProgressDialog loader;
  late BuildContext pageContext;

  show(BuildContext context) {
    pageContext = context;
    loader = CustomProgressDialog(
      context,
      dismissable: false,
      loadingWidget: Center(
        child: Container(
            alignment: Alignment.center,
            child: CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation<Color>(
                    StyleManager.instance.primary))),
      ),
      backgroundColor: Colors.black.withOpacity(.80),
    );
    return loader.show();
  }

  hide() {
    Navigator.pop(pageContext);
    // loader.onDismiss();
  }

  pageLoading() {
    return Center(
      child: Container(
          alignment: Alignment.center,
          child: CircularProgressIndicator(
              valueColor: AlwaysStoppedAnimation<Color>(
                  StyleManager.instance.primary))),
    );
  }
}
