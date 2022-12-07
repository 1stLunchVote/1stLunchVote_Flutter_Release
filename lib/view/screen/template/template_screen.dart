import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:lunch_vote/controller/template_controller.dart';
import 'package:lunch_vote/model/template/template_info.dart';
import 'package:lunch_vote/view/widget/appbar_widget.dart';
import 'package:lunch_vote/view/widget/template_tile.dart';
import 'package:provider/provider.dart';

import '../../../model/template/template_notifier.dart';
import '../../widget/custom_clip_path.dart';

class TemplateScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => TemplateNotifier(),
      builder: (context, child) {
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

  bool isMenuLoaded = false;
  String name = '';

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
        isMenuLoaded = true;
      });
    });
  }

  @override
  Widget build(BuildContext context1) {
    return Scaffold(
      appBar: BasicAppbar(
        backVisible: false,
        appbarTitle: "템플릿 사전 설정",
        isTitleCenter: false,
        context: context1,
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
            ClipPath(
              clipper: CustomClipPath(),
              child: Container(
                alignment: Alignment.bottomCenter,
                width: double.infinity,
                height: double.infinity,
                color: Theme.of(context1).colorScheme.surfaceVariant,
              ),
            ),
            Stack(
              children: [
                Visibility(
                  visible: !isMenuLoaded,
                  child: const Center(
                    child: CircularProgressIndicator(),
                  ),
                ),
                Visibility(
                  visible: isMenuLoaded,
                  child: GridView.builder(
                    cacheExtent: 999999999999999,
                    physics: const ScrollPhysics(),
                    shrinkWrap: true,
                    itemCount: context1.read<TemplateNotifier>().length,
                    gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 3,
                      childAspectRatio: 1 / 1,
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
          ],
        ),
      ),
      floatingActionButton: ElevatedButton(
        child: const Text("저장하기"),
        onPressed: () {
          showDialog(
              context: context1,
              builder: (BuildContext context2) {
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
                        name = value!;
                      },
                      validator: (value) {
                        if (value == null) {
                          return "Please enter an name.";
                        } else if (value.isEmpty) {
                          return "Please enter an name";
                        } else if (value.length < 2 || value.length > 10) {
                          return "Please enter text 2 to 10.";
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
                          await _templateController.createTemplate(TemplateInfo(
                            templateName: name,
                            likesMenu: context1.read<TemplateNotifier>().getLikeMenu(),
                            dislikesMenu: context1.read<TemplateNotifier>().getDislikeMenu(),
                          ));
                          Navigator.popUntil(context2, (route) => route.isFirst);
                        }
                      },
                    ),
                  ],
                );
              }
          );
        },
      ),
    );
  }
}