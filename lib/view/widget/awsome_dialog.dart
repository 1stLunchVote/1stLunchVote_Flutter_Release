import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/cupertino.dart';
import 'package:lunch_vote/styles.dart';

class LunchAwesomeDialog {
  final BuildContext context;
  final String title;
  final String body;
  final String okText;
  final String cancelText;

  LunchAwesomeDialog({
    required this.context,
    required this.title,
    required this.body,
    required this.okText,
    required this.cancelText,
  });

  Future<bool> showDialog() async{
    bool? canExit;
    AwesomeDialog dlg = AwesomeDialog(
      context: context,
      dialogType: DialogType.warning,
      animType: AnimType.scale,
      title: title,
      desc: body,
      dismissOnTouchOutside: true,
      btnCancelOnPress: () => canExit = false,
      btnOkOnPress: () => canExit = true,
      btnOkText: okText,
      btnOkColor: primary1,
      btnCancelText: cancelText,
      btnCancelColor: secondary3,
    );
    await dlg.show();
    return Future.value(canExit);
  }
}