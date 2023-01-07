// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:lunch_vote/controller/template_controller.dart';
import 'package:lunch_vote/model/template/template_info.dart';
import 'package:lunch_vote/model/template/template_notifier.dart';
import 'package:lunch_vote/view/widget/appbar_widget.dart';
import 'package:lunch_vote/view/widget/lunch_button.dart';
import 'package:lunch_vote/view/widget/template_tile.dart';
import 'package:provider/provider.dart';

class TemplateScreen extends StatelessWidget {
  final String templateId;
  final String templateName;

  const TemplateScreen({
    super.key,
    required this.templateId,
    required this.templateName,
  });

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => TemplateNotifier(),
      builder: (context, child) {
        context.read<TemplateNotifier>().setTemplateId(templateId);
        context.read<TemplateNotifier>().setTemplateName(templateName);
        return const _TemplateScreen();
      }
    );
  }
}

class _TemplateScreen extends StatefulWidget {
  const _TemplateScreen({Key? key}) : super(key: key);

  @override
  State<_TemplateScreen> createState() => _TemplateScreenState();
}

class _TemplateScreenState extends State<_TemplateScreen> {
  final TemplateController _templateController = TemplateController();
  final _formKey = GlobalKey<FormState>();

  bool _isMenuLoaded = false;
  bool _isTemplateLoaded = false;

  @override
  void initState(){
    super.initState();
    _templateController.getMenuInfo().then((value) {
      if (value != null) {
        for (int i = 0; i < value.length; i++) {
          context.read<TemplateNotifier>().addList(value[i]);
        }
      }
      setState(() {
        _isMenuLoaded = true;
      });
    });
    if (context.read<TemplateNotifier>().templateId != "") {
      _templateController.getOneTemplateInfo(context.read<TemplateNotifier>().templateId).then((value) {
        if (value != null) {
          context.read<TemplateNotifier>().clearList();
          for (int i = 0; i < value.length; i++) {
            context.read<TemplateNotifier>().addListWithStatus(value[i]);
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
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: BasicAppbar(
        backVisible: true,
        appbarTitle: (context.read<TemplateNotifier>().templateId == "") ? "템플릿 생성하기" : "템플릿 수정하기",
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
              child: GridView.builder(
                cacheExtent: 999999999999999,
                physics: const ScrollPhysics(),
                shrinkWrap: true,
                itemCount: context.read<TemplateNotifier>().length,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3,
                  mainAxisSpacing: 4,
                  crossAxisSpacing: 4,
                ),
                itemBuilder: (BuildContext context, int index){
                  return TemplateTile(menuIdx: index);
                },
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: LunchButton(
        context: context,
        isEnabled: context.watch<TemplateNotifier>().visibility,
        enabledText: '저장하기',
        disabledText: '저장 불가',
        pressedCallback: () async {
          if (context.read<TemplateNotifier>().templateId == "") {
            showDialog(
              context: context,
              builder: (BuildContext context1) {
                return AlertDialog(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  title: const Text("템플릿 이름 설정"),
                  content: Form(
                    key: _formKey,
                    child: TextFormField(
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: '템플릿명',
                        hintText: '2~10 자로 입력해주세요.',
                        helperText: '',
                      ),
                      onSaved: (value) {
                        context.read<TemplateNotifier>().setTemplateName(value!);
                      },
                      validator: (value) {
                        if (value == null) {
                          return "이름을 입력해주세요.";
                        } else if (value.isEmpty) {
                          return "이름을 입력해주세요.";
                        } else if (value.length < 2 || value.length > 10) {
                          return "2~10 자로 입력해주세요.";
                        }
                        return null;
                      },
                    ),
                  ),
                  actions: [
                    TextButton(
                      child: const Text("확인"),
                      onPressed: () async {
                        if (_formKey.currentState!.validate()) {
                          _formKey.currentState!.save();
                          final message = await _templateController.createTemplate(TemplateInfo(
                            templateName: context.read<TemplateNotifier>().templateName,
                            likesMenu: context.read<TemplateNotifier>().getLikeMenu(),
                            dislikesMenu: context.read<TemplateNotifier>().getDislikeMenu(),
                          ));
                          ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(message!)));
                          Navigator.pop(context1);
                          Navigator.pop(context);
                        }
                      },
                    ),
                  ],
                );
              },
            );
          } else {
            final message = await _templateController.modifyTemplate(
              context.read<TemplateNotifier>().templateId,
              TemplateInfo(
                templateName: context.read<TemplateNotifier>().templateName,
                likesMenu: context.read<TemplateNotifier>().getLikeMenu(),
                dislikesMenu: context.read<TemplateNotifier>().getDislikeMenu(),
              ),
            );
            ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(message!)));
            Navigator.pop(context);
          }
        },
        notifyText: '최소 1가지의 아이템을 선택해야 저장할 수 있습니다.',
      ),
    );
  }
}