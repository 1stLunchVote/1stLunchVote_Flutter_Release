// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lunch_vote/controller/template_controller.dart';
import 'package:lunch_vote/model/template/template_info.dart';
import 'package:lunch_vote/view/widget/appbar_widget.dart';
import 'package:lunch_vote/view/widget/lunch_button.dart';
import 'package:lunch_vote/view/widget/lunch_dialog.dart';
import 'package:lunch_vote/view/widget/template_tile.dart';

class TemplateScreen extends StatefulWidget {
  final String templateId;
  final String templateName;

  const TemplateScreen({
    super.key,
    required this.templateId,
    required this.templateName,
  });

  @override
  State<TemplateScreen> createState() => TemplateScreenState();
}

class TemplateScreenState extends State<TemplateScreen> {
  final _templateController = Get.put(TemplateController());
  final _formKey = GlobalKey<FormState>();

  bool _isMenuLoaded = false;
  bool _isTemplateLoaded = false;

  @override
  void initState()  {
    super.initState();
    _templateController.initController().then((value) {
      _templateController.setTemplateId(widget.templateId);
      _templateController.setTemplateName(widget.templateName);
      _templateController.getMenuInfo().then((value) {
        if (value != null) {
          for (int i = 0; i < value.length; i++) {
            _templateController.addList(value[i]);
          }
        }
        setState(() {
          _isMenuLoaded = true;
        });
      });
      if (_templateController.templateId != "") {
        _templateController.getOneTemplateInfo(_templateController.templateId).then((value) {
          if (value != null) {
            _templateController.clearList();
            for (int i = 0; i < value.length; i++) {
              _templateController.addListWithStatus(value[i]);
            }
          }
          setState(() {
            _isTemplateLoaded = true;
          });
        });
      } else {
        setState(() {
          _isTemplateLoaded = true;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: BasicAppbar(
        backVisible: true,
        appbarTitle: (_templateController.templateId == "") ? "????????? ????????????" : "????????? ????????????",
        isTitleCenter: false,
        context: context,
        trailingList: [
          IconButton(
            onPressed: (){},
            icon: const Icon(Icons.more_vert),
          ),
        ],
      ),
      body: SafeArea(
        child: Stack(
          children: [
            Visibility(
              visible: !(_isMenuLoaded && _isTemplateLoaded),
              child: const Center(
                child: CircularProgressIndicator(),
              ),
            ),
            Visibility(
              visible: _isMenuLoaded && _isTemplateLoaded,
              child: ListView(
                children: [
                  const SizedBox(height: 24,),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 24),
                    child: GridView.builder(
                      cacheExtent: 999999999999999,
                      physics: const ScrollPhysics(),
                      shrinkWrap: true,
                      itemCount: _templateController.length,
                      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 3,
                        childAspectRatio: 9/10,
                        mainAxisSpacing: 4,
                        crossAxisSpacing: 4,
                      ),
                      itemBuilder: (BuildContext context, int index){
                        return TemplateTile(templateController: _templateController, menuIdx: index);
                      },
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: Obx(() => LunchButton(
        context: context,
        isEnabled: _templateController.visibility,
        enabledText: '????????????',
        disabledText: '?????? ??????',
        pressedCallback: () async {
          if (_templateController.templateId == "") {
            showDialog(
              context: context,
              builder: (BuildContext context1) {
                return LunchDialog(
                  context: context,
                  titleText: "????????? ?????? ??????",
                  labelText: "????????????",
                  okBtnText: "??????",
                  onSaved: (value) {
                    _templateController.setTemplateName(value!);
                  },
                  validator: (value) {
                    if (value == null) {
                      return "????????? ??????????????????.";
                    } else if (value.isEmpty) {
                      return "????????? ??????????????????.";
                    } else if (value.length < 2 || value.length > 10) {
                      return "2~10 ?????? ??????????????????.";
                    }
                    return null;
                  },
                  okOnPressed: () async {
                    final message = await _templateController.createTemplate(TemplateInfo(
                      templateName: _templateController.templateName,
                      likesMenu: _templateController.getLikeMenu(),
                      dislikesMenu: _templateController.getDislikeMenu(),
                    ));
                    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(message!)));
                    Navigator.pop(context1);
                    Navigator.pop(context);
                  },
                );
              },
            );
          } else {
            final message = await _templateController.modifyTemplate(
              _templateController.templateId,
              TemplateInfo(
                templateName: _templateController.templateName,
                likesMenu: _templateController.getLikeMenu(),
                dislikesMenu: _templateController.getDislikeMenu(),
              ),
            );
            ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(message!)));
            Navigator.pop(context);
          }
        },
        notifyText: '?????? 1????????? ???????????? ???????????? ????????? ??? ????????????.',
      ),)
    );
  }
}