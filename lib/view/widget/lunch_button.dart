import 'package:flutter/material.dart';
import 'package:lunch_vote/styles.dart';

class LunchButton extends ElevatedButton {
  final BuildContext context;
  final bool isEnabled;
  final String enabledText;
  final String disabledText;
  final Function() pressedCallback;
  final String notifyText;

  const LunchButton({
    super.key,
    super.child,
    super.onPressed,
    required this.context,
    required this.isEnabled,
    required this.enabledText,
    required this.disabledText,
    required this.pressedCallback,
    required this.notifyText,
  });

  @override
  Widget? get child => Text(
    isEnabled ? enabledText : disabledText,
    style: Theme.of(context).textTheme.titleSmall?.copyWith(color: textDarkMain,),
  );

  @override
  VoidCallback? get onPressed => isEnabled ? pressedCallback : () {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(notifyText)));
  };

  @override
  ButtonStyle? get style => ElevatedButton.styleFrom(
    backgroundColor: isEnabled? primary1 : primary3,
    textStyle: Theme.of(context).textTheme.titleSmall?.copyWith(color: textDarkMain,),
  );
}