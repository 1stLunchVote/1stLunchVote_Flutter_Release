import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:lunch_vote/controller/result_controller.dart';
import 'package:lunch_vote/model/vote/final_result.dart';
import 'package:lunch_vote/styles.dart';
import 'package:lunch_vote/view/screen/home_screen.dart';
import 'package:lunch_vote/view/widget/appbar_widget.dart';
import 'package:lunch_vote/view/widget/custom_clip_path.dart';

class ResultScreen extends StatefulWidget {
  const ResultScreen({Key? key, required this.groupId}) : super(key: key);
  final String groupId;

  @override
  State<ResultScreen> createState() => _ResultScreenState();
}

class _ResultScreenState extends State<ResultScreen> {
  final _controller = ResultController();
  late Future future;

  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    future = _controller.getFinalResult(widget.groupId);
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async{
        Navigator.of(context).popUntil((route) => route.isFirst);
        return false;
      },
      child: Scaffold(
        appBar: BasicAppbar(
          appbarTitle: "최종 투표 결과",
          backVisible: false,
          isTitleCenter: false,
          context: context,
          trailingList: null,
        ),
        backgroundColor: mainBackgroundColor,
        body: SafeArea(
          child: Stack(
            children: [
              ClipPath(
                clipper: CustomClipPath(),
                child: Container(
                  alignment: Alignment.bottomCenter,
                  width: double.infinity,
                  height: double.infinity,
                  color: Theme.of(context).colorScheme.surfaceVariant,
                ),
              ),
              Center(
                child: FutureBuilder(
                  future: future,
                  builder: (context, snapshot){
                     if (snapshot.data == null){
                       return Center(child: Column(
                         mainAxisAlignment: MainAxisAlignment.center,
                         children: [
                           const SizedBox(
                             height: 100,
                           ),
                           const CircularProgressIndicator(),
                           const SizedBox(
                             height: 10,
                           ),
                           Text("결과를 불러오는중입니다.",
                             textAlign: TextAlign.center,
                             style: Theme.of(context).textTheme.titleLarge?.copyWith(
                                 color: Theme.of(context).colorScheme.outline
                             )
                           )
                         ],
                       ));
                     }
                     else{
                       FinalResult res = snapshot.data;
                       SchedulerBinding.instance.addPostFrameCallback((_) {
                         setState(() {
                           _isLoading = true;
                         });
                       });
                       return Column(
                         mainAxisAlignment: MainAxisAlignment.center,
                         children: [
                           Text("투표 결과", style: Theme.of(context).textTheme.displayMedium
                               ?.copyWith(color: Theme.of(context).colorScheme.onSurfaceVariant)
                           ),
                           const SizedBox(
                             height: 40,
                           ),
                           Container(
                             width: 200,
                             height: 200,
                             decoration: BoxDecoration(
                                 image: DecorationImage(image:
                                  NetworkImage(res.image)
                                 ),
                             ),
                           ),
                           const SizedBox(
                             height: 10,
                           ),
                           Text(res.menuName, style: Theme.of(context).textTheme.headlineLarge
                               ?.copyWith(color: Theme.of(context).colorScheme.onSurfaceVariant)
                           )
                         ],
                       );
                     }
                  }
                ),
              ),
              Visibility(
                visible: _isLoading,
                child: Align(
                  alignment: Alignment.bottomCenter,
                  child: Padding(
                    padding: const EdgeInsets.only(bottom: 50),
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.of(context).popUntil((route) => route.isFirst);
                      },
                      child: Padding(
                        padding: const EdgeInsets.fromLTRB(12, 8, 12, 8),
                        child: Text("투표 종료", style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 14,
                          color: Theme.of(context).colorScheme.error
                          )
                        ),
                      ),
                    ),
                  ),
                ),
              )
            ],
          )
        ),
      ),
    );

  }
}
