import 'package:flutter/material.dart';
import 'package:lunch_vote/styles.dart';
import 'package:lunch_vote/view/screen/home_screen.dart';
import 'package:lunch_vote/view/widget/appbar_widget.dart';
import 'package:lunch_vote/view/widget/custom_clip_path.dart';

class ResultScreen extends StatelessWidget {
  const ResultScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
              child: Column(
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
                      image: const DecorationImage(image:
                        AssetImage('assets/images/food_default.png', )
                      ),
                      border: Border.all(color: Theme.of(context).colorScheme.outline, width: 2)
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Text("햄버거", style: Theme.of(context).textTheme.headlineLarge
                    ?.copyWith(color: Theme.of(context).colorScheme.outline)
                  )
                ],
              ),
            ),
            Align(
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
            )
          ],
        )
      ),
    );
  }
}
