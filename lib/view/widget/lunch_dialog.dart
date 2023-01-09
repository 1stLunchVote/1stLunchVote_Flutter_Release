import 'package:flutter/material.dart';
import 'package:lunch_vote/view/widget/lunch_button.dart';

class LunchDialog extends StatefulWidget {
  const LunchDialog({
    Key? key,
    required this.title,
    required this.labelText,
    required this.textButtonText,
    required this.enabledText,
    required this.disabledText,
    required this.notifyText,
    required this.pressedCallback,

  }) : super(key: key);

  final String title;
  final String labelText;
  final String textButtonText;
  final String enabledText;
  final String disabledText;
  final String notifyText;
  final VoidCallback pressedCallback;


  @override
  State<LunchDialog> createState() => _LunchDialogState();
}

class _LunchDialogState extends State<LunchDialog> {

  final TextEditingController _textController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  bool enabled = false;

  @override
  Widget build(BuildContext context) {
    String title = widget.title;
    String labelText = widget.labelText;
    String textButtonText = widget.textButtonText;
    String disabledText = widget.disabledText;
    String enabledText = widget.enabledText;
    String notifyText = widget.notifyText;
    VoidCallback pressedCallback = widget.pressedCallback;

    return AlertDialog(
      titlePadding: EdgeInsets.all(24), //24
      contentPadding: EdgeInsets.all(24), // 24 0 24 0
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
      ),
      //backgroundColor: primary4, // TODO 색상 하드코딩으로 되어 있음. 고치자!
      title: Text(title,
        style: Theme
            .of(context)
            .textTheme
            .titleLarge,
      ),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Form(
            key: _formKey,
            child: TextFormField(
              controller: _textController,
              onChanged: (value){
                setState(() {
                  if(value.isEmpty){
                    enabled = false;
                  }
                  else {
                    enabled = true;
                  }
                });
              },
              decoration: InputDecoration(
                border: const OutlineInputBorder(),
                labelText: labelText,
                helperText: '',
                suffixIcon: IconButton(
                  onPressed: _textController.clear,
                  icon: const Icon(Icons.highlight_remove),
                ),
              ),
            ),
          ),
          Row(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              TextButton(
                onPressed: (){
                  Navigator.pop(context);
                },
                style: TextButton.styleFrom(),
                child: Text(textButtonText,
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    color: Theme.of(context).primaryColor,
                  ),
                ),
              ),
              LunchButton(
                  context: context,
                  isEnabled: enabled,
                  enabledText: enabledText,
                  disabledText: disabledText,
                  notifyText: notifyText,
                  pressedCallback: pressedCallback,
              ),
            ],
          )
        ],
      ),
    );
  }
}
