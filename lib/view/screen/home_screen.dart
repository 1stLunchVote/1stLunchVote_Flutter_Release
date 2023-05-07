import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:lunch_vote/controller/home_controller.dart';
import 'package:lunch_vote/routes/app_pages.dart';
import 'package:lunch_vote/styles.dart';
import 'package:lunch_vote/view/screen/friend/friendlist_screen.dart';
import 'package:lunch_vote/view/screen/template/template_list_screen.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(context, designSize: const Size(412, 812));
    return GetX<HomeController>(initState: (state) {
      state.controller?.getNickname();
    }, builder: (controller) {
      if (controller.nickname.isNotEmpty) {
        FlutterNativeSplash.remove();
      }
      return Scaffold(
          // 앱바 기본 높이 56dp
          appBar: AppBar(),
          body: SafeArea(
              child: Padding(
            padding: const EdgeInsets.fromLTRB(24, 44, 24, 100),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  mainAxisSize: MainAxisSize.max,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text.rich(
                      TextSpan(
                        text : controller.nickname,
                        style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                            color: Theme
                                .of(context)
                                .primaryColor),
                        children: [
                          TextSpan(
                            text: '님, 환영합니다!',
                            style: Theme.of(context).textTheme.headlineMedium,
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 8),
                    Row(
                      children: [
                        Text(
                          "저희 앱이 처음이신가요?",
                          style:
                              Theme.of(context).textTheme.titleMedium?.copyWith(
                                    color: Theme.of(context).hintColor,
                                  ),
                        ),
                      ],
                    ),
                  ],
                ),
                Column(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    FloatingActionButton.large(
                      backgroundColor: primary1,
                      onPressed: () {
                        Get.toNamed(Routes.group);
                      },
                      child: Icon(Icons.add,
                          color: Theme.of(context).scaffoldBackgroundColor),
                    ),
                    const SizedBox(height: 12),
                    Text(
                      '새로운 투표 생성하기',
                      style: Theme.of(context).textTheme.titleLarge,
                    ),
                    const SizedBox(height: 4),
                    Text(
                      '버튼을 눌러 새로운 투표를 시작하세요!',
                      style: Theme.of(context).textTheme.titleMedium?.copyWith(
                            color: Theme.of(context).hintColor,
                          ),
                    ),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 22),
                  child: Row(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        children: [
                          FloatingActionButton(
                            onPressed: () {
                              Navigator.of(context).push(MaterialPageRoute(
                                  builder: (context) =>
                                      const TemplateListScreen()));
                            },
                            backgroundColor: primary1,
                            heroTag: null,
                            child: Icon(Icons.mode_edit,
                                color:
                                    Theme.of(context).scaffoldBackgroundColor),
                          ),
                          const SizedBox(height: 8),
                          Text(
                            '템플릿 설정',
                            style: Theme.of(context).textTheme.titleSmall,
                          ),
                        ],
                      ),
                      Column(
                        children: [
                          FloatingActionButton(
                            onPressed: () {
                              Get.to(const FriendlistScreen());
                            },
                            backgroundColor: secondary1,
                            heroTag: null,
                            child: Icon(
                              Icons.person_outline,
                              color: Theme.of(context).scaffoldBackgroundColor,
                            ),
                          ),
                          const SizedBox(height: 8),
                          Text(
                            '친구 관리',
                            style: Theme.of(context).textTheme.titleSmall,
                          ),
                        ],
                      ),
                      Column(
                        children: [
                          FloatingActionButton(
                            onPressed: () {
                              Get.toNamed(Routes.profile);
                            },
                            heroTag: null,
                            backgroundColor: secondary1,
                            child: Icon(Icons.settings,
                                color:
                                    Theme.of(context).scaffoldBackgroundColor),
                          ),
                          const SizedBox(height: 8),
                          Text(
                            '마이페이지',
                            style: Theme.of(context).textTheme.titleSmall,
                          ),
                        ],
                      ),
                    ],
                  ),
                )
              ],
            ),
          )));
    });
  }
}
