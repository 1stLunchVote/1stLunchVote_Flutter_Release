import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lunch_vote/model/group/group_notifier.dart';
import 'package:lunch_vote/model/template/template_notifier.dart';
import 'package:provider/provider.dart';

import '../../controller/group_controller.dart';
import '../../model/group/group_info.dart';

class TemplateTile extends StatefulWidget {
  final int menuIdx;
  const TemplateTile({super.key, required this.menuIdx});

  @override
  State<TemplateTile> createState() => _TemplateTileState();
}

class _TemplateTileState extends State<TemplateTile> {
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          width: 80.w,
          height: 80.w,
          decoration: BoxDecoration(
            borderRadius: const BorderRadius.all(Radius.circular(16.0)),
            border: Border.all(
              width: 2.0,
              color: context.watch<TemplateNotifier>().getColor(widget.menuIdx),
            ),
          ),
          child: Stack(
            children: [
              ClipRRect(
                borderRadius: const BorderRadius.all(Radius.circular(16.0)),
                child: Image(image: NetworkImage(context.watch<TemplateNotifier>().getImg(widget.menuIdx)),),
              ),
              ClipRRect(
                borderRadius: const BorderRadius.all(Radius.circular(16.0)),
                child: Center(
                  child: Material(
                    color: Colors.transparent,
                    child: InkWell(
                      onTap: () {
                        setState(() {
                          context.read<TemplateNotifier>().updateStatus(widget.menuIdx);
                        });
                      },
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 4.0),
          child: Text(
            context.watch<TemplateNotifier>().getName(widget.menuIdx),
            style: Theme.of(context).textTheme.labelLarge,
          ),
        ),
      ],
    );
  }
}