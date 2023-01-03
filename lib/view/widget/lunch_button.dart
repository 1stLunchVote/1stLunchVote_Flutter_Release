import 'package:flutter/material.dart';
import 'package:lunch_vote/styles.dart';

class LunchButton extends ElevatedButton {
  final BuildContext context;
  final bool isEnabled;
  final String text;
  final Function() pressedCallback;
  final String? notifyText;

  const LunchButton({
    super.key,
    super.child,
    super.onPressed,
    required this.context,
    required this.isEnabled,
    required this.text,
    required this.pressedCallback,
    this.notifyText,
  });

  @override
  Widget? get child => Text(
    text,
    style: Theme.of(context).textTheme.titleSmall?.copyWith(color: textDarkMain,),
  );

  @override
  VoidCallback? get onPressed {
    if (isEnabled) {
      return pressedCallback;
    } else {
      return () {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(text)));
      };
    }
  }

  @override
  ButtonStyle? get style => ElevatedButton.styleFrom(
    backgroundColor: primary1,
    textStyle: Theme.of(context).textTheme.titleSmall?.copyWith(color: textDarkMain,),
  );
}