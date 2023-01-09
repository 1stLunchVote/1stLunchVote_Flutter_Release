import 'package:flutter/material.dart';
import 'package:lunch_vote/view/widget/lunch_button.dart';

class LunchDialog extends StatefulWidget {
  const LunchDialog({
    Key? key,
    required this.title,
    required this.labelText,
    required this.disabledText,
    required this.enabledText,

  }) : super(key: key);

  final String title;
  final String labelText;
  final String disabledText;
  final String enabledText;


  @override
  State<LunchDialog> createState() => _LunchDialogState();
}

class _LunchDialogState extends State<LunchDialog> {

  final TextEditingController _emailController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    String title = widget.title;
    String labelText = widget.labelText;
    String disabledText = widget.disabledText;
    String enabledText = widget.enabledText;
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
              controller: _emailController,
              decoration: InputDecoration(
                border: const OutlineInputBorder(),
                labelText: labelText,
                helperText: '',
                suffixIcon: IconButton(
                  onPressed: _emailController.clear,
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
                child: Text(disabledText,
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    color: Theme.of(context).primaryColor,
                  ),
                ),
              ),
              LunchButton(
                  context: context,
                  isEnabled: true,
                  enabledText: enabledText,
                  disabledText: 'disabledText',
                  pressedCallback: () {
                    Navigator.pop(context);
                    // TODO 서버로 친구 추가 요청 보내는 작업 처리해야 함!
                    },
                  notifyText: 'notifyText'
              ),
            ],
          )
        ],
      ),
    );
  }
}
