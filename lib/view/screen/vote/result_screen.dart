import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:lunch_vote/controller/result_controller.dart';
import 'package:lunch_vote/model/vote/final_result.dart';
import 'package:lunch_vote/styles.dart';
import 'package:lunch_vote/view/widget/appbar_widget.dart';
import 'package:lunch_vote/view/widget/lunch_button.dart';

class ResultScreen extends StatefulWidget {
  const ResultScreen({Key? key, required this.groupId}) : super(key: key);
  final String groupId;

  @override
  State<ResultScreen> createState() => _ResultScreenState();
}

class _ResultScreenState extends State<ResultScreen> {
  final ResultController _resultController = Get.put(ResultController());

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        Navigator.of(context).popUntil((route) => route.isFirst);
        return false;
      },
      child: Scaffold(
        appBar: BasicAppbar(
          appbarTitle: "최종 결과",
          backVisible: false,
          isTitleCenter: true,
          context: context,
          trailingList: null,
        ),
        body: SafeArea(
           child: FutureBuilder(
             future: _resultController.getFinalResult(widget.groupId),
             builder: (context, snapshot){
               if (snapshot.data == null){
                 return Center(
                   child: Column(
                     mainAxisAlignment: MainAxisAlignment.center,
                     children: [

                     ],
                   ),
                 );
               } else {
                 return Column(
                   children: [
                     const Spacer(),
                     Center(
                       child: Column(
                         mainAxisAlignment: MainAxisAlignment.center,
                         children: [
                           Text('오늘 식사 메뉴는...', style: Theme.of(context).textTheme.titleLarge),
                           const SizedBox(height: 18),
                           // 이미지와 결과 나옴
                           ResultImage(imgRes: snapshot.data?.image),
                           const SizedBox(height: 14),
                           Text("${snapshot.data?.menuName}", style: Theme.of(context).textTheme.titleLarge,)
                         ],
                       ),
                     ),
                     const Spacer(),
                     Align(
                       alignment: Alignment.bottomCenter,
                       child: LunchButton(
                         context: context,
                         isEnabled: true,
                         enabledText: "홈 화면으로 돌아가기",
                         pressedCallback: () {
                           Navigator.of(context).popUntil((route) => route.isFirst);
                         },
                       ),
                     ),
                     const SizedBox(height: 120),

                   ],
                 );
               }
             },
           ),
           // child: Column(
           //   children: [
           //     Center(
           //       child: FutureBuilder(
           //           future: future,
           //           builder: (context, snapshot) {
           //             if (snapshot.data == null) {
           //               return Center(
           //                   child: Column(
           //                     mainAxisAlignment: MainAxisAlignment.center,
           //                     children: [
           //                       const SizedBox(
           //                         height: 100,
           //                       ),
           //                       const CircularProgressIndicator(),
           //                       const SizedBox(
           //                         height: 10,
           //                       ),
           //                       Text("결과를 불러오는중입니다.",
           //                           textAlign: TextAlign.center,
           //                           style: Theme.of(context)
           //                               .textTheme
           //                               .titleLarge
           //                               ?.copyWith(
           //                               color: Theme.of(context)
           //                                   .colorScheme
           //                                   .outline))
           //                     ],
           //                   ));
           //             } else {
           //               FinalResult res = snapshot.data;
           //               SchedulerBinding.instance.addPostFrameCallback((_) {
           //                 setState(() {
           //                   _isLoading = true;
           //                 });
           //               });
           //               return Column(
           //                 mainAxisAlignment: MainAxisAlignment.center,
           //                 children: [
           //                   Text("투표 결과",
           //                       style: Theme.of(context)
           //                           .textTheme
           //                           .displayMedium
           //                           ?.copyWith(
           //                           color: Theme.of(context)
           //                               .colorScheme
           //                               .onSurfaceVariant)),
           //                   const SizedBox(
           //                     height: 40,
           //                   ),
           //                   Container(
           //                     width: 200,
           //                     height: 200,
           //                     decoration: BoxDecoration(
           //                       image: DecorationImage(
           //                           image: NetworkImage(res.image)),
           //                     ),
           //                   ),
           //                   const SizedBox(
           //                     height: 10,
           //                   ),
           //                   Text(res.menuName,
           //                       style: Theme.of(context)
           //                           .textTheme
           //                           .headlineLarge
           //                           ?.copyWith(
           //                           color: Theme.of(context)
           //                               .colorScheme
           //                               .onSurfaceVariant))
           //                 ],
           //               );
           //             }
           //           }),
           //     ),
           //     Visibility(
           //       visible: _isLoading,
           //       child: Align(
           //         alignment: Alignment.bottomCenter,
           //         child: Padding(
           //           padding: const EdgeInsets.only(bottom: 50),
           //           child: ElevatedButton(
           //             onPressed: () {
           //               Navigator.of(context).popUntil((route) => route.isFirst);
           //             },
           //             child: Padding(
           //               padding: const EdgeInsets.fromLTRB(12, 8, 12, 8),
           //               child: Text("투표 종료",
           //                   style: TextStyle(
           //                       fontWeight: FontWeight.bold,
           //                       fontSize: 14,
           //                       color: Theme.of(context).colorScheme.error)),
           //             ),
           //           ),
           //         ),
           //       ),
           //     )
           //   ],
           // ),
        ),
      ),
    );
  }
}

class ResultImage extends StatelessWidget {
  final String? imgRes;
  const ResultImage({Key? key, required this.imgRes}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Todo : 투표 율로 바꿔야 함
    const int voteRate = 75;
    return Padding(
      padding: EdgeInsets.only(left: 50.w),
      child: SizedBox(
        width: 210.w,
        height: 164.h,
        child: Stack(
          children: [
            Container(
              width: 160.w,
              height: 160.h,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: imgRes != null ? NetworkImage(imgRes!)
                      : const AssetImage("assets/images/food_default.png") as ImageProvider
                )
              )
            ),
            Align(
              alignment: Alignment.bottomRight,
              child: Stack(
                alignment: Alignment.center,
                children: [
                  SvgPicture.asset("assets/images/bg_result_rate.svg", width: 100.w, height: 100.h),
                  Text("$voteRate%의\n선택!!", textAlign: TextAlign.center, textScaleFactor: 1.0,
                    style: TextStyle(
                      fontSize: 20.w,
                      fontWeight: FontWeight.w900,
                      color: Theme.of(context).brightness == Brightness.light ? textDarkMain : textLightMain
                    ),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
