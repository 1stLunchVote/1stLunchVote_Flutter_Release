import 'package:flutter/material.dart';
import 'package:lunch_vote/styles.dart';
import 'package:lunch_vote/view/widget/lunch_button.dart';

class LunchDialog extends AlertDialog {
  final BuildContext context;
  final String titleText;
  final String labelText;
  final String okBtnText;
  final FormFieldSetter<String>? onSaved;
  final FormFieldValidator<String>? validator;
  final VoidCallback? okOnPressed;

  final bool removable;

  LunchDialog({
    super.key,
    required this.context,
    required this.titleText,
    required this.labelText,
    required this.okBtnText,
    required this.onSaved,
    required this.validator,
    required this.okOnPressed,
    this.removable = false,
  });

  @override
  ShapeBorder? get shape => RoundedRectangleBorder(
    borderRadius: BorderRadius.circular(10.0),
  );

  @override
  Widget? get title => Text(
    titleText,
    style: Theme.of(context).textTheme.titleLarge,
  );

  final _formKey = GlobalKey<FormState>();
  final _controller = TextEditingController();
  @override
  Widget? get content => Form(
    key: _formKey,
    child: TextFormField(
      decoration: InputDecoration(
        border: const OutlineInputBorder(),
        labelText: labelText,
        suffixIcon: removable ? IconButton(
          onPressed: _controller.clear,
          icon: const Icon(Icons.highlight_remove),
        ) : null,
      ),
      onSaved: onSaved,
      validator: validator,
    ),
  );

  @override
  List<Widget>? get actions => [
    TextButton(
      onPressed: (){
        Navigator.pop(context);
      },
      child: Text(
        "취소",
        style: Theme.of(context).textTheme.titleSmall?.copyWith(color: primary1),
      ),
    ),
    LunchButton(
      context: context,
      isEnabled: true,
      enabledText: okBtnText,
      pressedCallback: () {
        if (_formKey.currentState!.validate()) {
          _formKey.currentState!.save();
          okOnPressed!();
        }
      },
    ),
  ];
}