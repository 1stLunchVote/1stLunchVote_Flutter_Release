import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_getx_widget.dart';
import 'package:lunch_vote/controller/template_controller.dart';
import 'package:lunch_vote/model/template/all_template_info.dart';
import 'package:lunch_vote/routes/app_pages.dart';
import 'package:lunch_vote/styles.dart';
import 'package:lunch_vote/view/screen/template/template_screen.dart';
import 'package:lunch_vote/view/widget/appbar_widget.dart';

class TemplateListScreen extends StatefulWidget {
  const TemplateListScreen({Key? key}) : super(key: key);

  @override
  State<TemplateListScreen> createState() => TemplateListScreenState();
}

class TemplateListScreenState extends State<TemplateListScreen> {
  final List<AllTemplateInfo> _templateList = [];

  void refreshTemplateList(TemplateController controller) {
    controller.getAllTemplateInfo().then((value) {
      if (value != null) {
        _templateList.clear();
        for (int i = 0; i < value.length; i++) {
          _templateList.add(value[i]);
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: BasicAppbar(
        backVisible: true,
        appbarTitle: "템플릿 관리",
        isTitleCenter: false,
        context: context,
      ),
      body: SafeArea(
        child: GetX<TemplateController>(
          initState: (state) {
            refreshTemplateList(state.controller!);
          },
          builder: (controller) {
            return Stack(
              children: [
                Visibility(
                  visible: !controller.isListLoaded,
                  child: const Center(
                    child: CircularProgressIndicator(),
                  ),
                ),
                Visibility(
                  visible: controller.isListLoaded && _templateList.isEmpty,
                  child: Center(
                    child: Text(
                      '현재 설정된 템플릿이 없습니다.\n+ 버튼을 눌러 새로운 템플릿을 생성해주세요.',
                      style: Theme.of(context).textTheme.titleMedium,
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
                Visibility(
                  visible: controller.isListLoaded,
                  child: ListView.separated(
                    itemCount: _templateList.length + 1,
                    itemBuilder: (BuildContext context, int index) {
                      if (index == 0) {
                        return Padding(
                          padding: EdgeInsets.symmetric(horizontal: 32.w,),
                          child: Row(
                            children: [
                              Text(
                                '내 템플릿 목록',
                                style: Theme.of(context).textTheme.titleLarge,
                              ),
                              const Spacer(),
                              IconButton(
                                onPressed: () async {
                                  Get.toNamed(Routes.template);
                                  refreshTemplateList(controller);
                                },
                                icon: Icon(
                                  Icons.add,
                                  color: Theme.of(context).brightness == Brightness.light ? textLightMain : textDarkMain,
                                ),
                              ),
                            ],
                          ),
                        );
                      } else {
                        return Padding(
                          padding: EdgeInsets.symmetric(horizontal: 32.w, vertical: 8.h),
                          child: ListTile(
                            title: Text(
                              _templateList[index - 1].templateName,
                              style: Theme.of(context).textTheme.titleMedium,
                            ),
                            trailing: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                IconButton(
                                  onPressed: () {
                                    Get.toNamed(
                                      Routes.template,
                                      arguments: {
                                        'templateId': _templateList[index - 1].lunchTemplateId,
                                        'templateName': _templateList[index - 1].templateName,
                                      }
                                    );
                                  },
                                  icon: Icon(
                                    Icons.mode_edit_outlined,
                                    color: Theme.of(context).brightness == Brightness.light ? textLightMain : textDarkMain,
                                  ),
                                ),
                                IconButton(
                                  onPressed: (){
                                    controller.deleteTemplate(_templateList[index - 1].lunchTemplateId).then((value) {
                                      setState(() {
                                        _templateList.removeAt(index - 1);
                                        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(value!)));
                                      });
                                    });
                                  },
                                  icon: Icon(
                                    Icons.delete_outlined,
                                    color: Theme.of(context).brightness == Brightness.light ? textLightMain : textDarkMain,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        );
                      }
                    },
                    separatorBuilder: (BuildContext context, int index) {
                      if (index == 0) {
                        return Padding(
                          padding: EdgeInsets.symmetric(horizontal: 32.w,),
                          child: const Divider(thickness: 1, color: Colors.transparent,),
                        );
                      } else {
                        return Padding(
                          padding: EdgeInsets.symmetric(horizontal: 32.w,),
                          child: const Divider(thickness: 1,),
                        );
                      }
                    },
                  ),
                ),
              ],
            );
          }
        ),
      ),
    );
  }
}
