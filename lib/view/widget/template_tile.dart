import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:get/get.dart';
import 'package:lunch_vote/controller/template_controller.dart';

class TemplateTile extends StatefulWidget {
  final TemplateController templateController;
  final int menuIdx;
  const TemplateTile({
    super.key,
    required this.templateController,
    required this.menuIdx,
  });

  @override
  State<TemplateTile> createState() => _TemplateTileState();
}

class _TemplateTileState extends State<TemplateTile> {
  @override
  Widget build(BuildContext context) {
    return Obx(() =>Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          width: 80.w,
          height: 80.w,
          decoration: BoxDecoration(
            borderRadius: const BorderRadius.all(Radius.circular(16.0)),
            border: Border.all(
              width: 2.0,
              color: widget.templateController.getColor(widget.menuIdx),
            ),
          ),
          child: Stack(
            children: [
              ClipRRect(
                borderRadius: const BorderRadius.all(Radius.circular(16.0)),
                child: CachedNetworkImage(imageUrl: widget.templateController.getImg(widget.menuIdx),),
              ),
              ClipRRect(
                borderRadius: const BorderRadius.all(Radius.circular(16.0)),
                child: Center(
                  child: Material(
                    color: Colors.transparent,
                    child: InkWell(
                      onTap: () {
                        setState(() {
                          widget.templateController.updateStatus(widget.menuIdx);
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
            widget.templateController.getName(widget.menuIdx),
            style: Theme.of(context).textTheme.labelLarge,
          ),
        ),
      ],
    ));
  }
}