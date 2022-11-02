import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:lunch_vote/styles.dart';

class BasicAppbar extends AppBar {
  final bool backVisible;
  final String appbarTitle;
  final bool isTitleCenter;
  final BuildContext context;

  BasicAppbar({super.key,
    required this.backVisible,
    required this.appbarTitle,
    required this.isTitleCenter,
    required this.context
  });

  @override
  double? get elevation => 0;

  @override
  Widget? get title => Text(appbarTitle,
      style: const TextStyle(
        fontSize: 22,
        color: voteBlackColor
  ));

  @override
  bool? get centerTitle => isTitleCenter;

  @override
  Widget? get leading => Visibility(
    visible: backVisible,
    child: IconButton(
      icon: SvgPicture.asset(
          'assets/images/ic_arrow_back.svg',
      ),
      onPressed: (){
        Navigator.of(context).pop();
      },
    ),
  );

  @override
  SystemUiOverlayStyle? get systemOverlayStyle => const SystemUiOverlayStyle(
    statusBarColor: Colors.transparent,
    statusBarIconBrightness: Brightness.dark
  );

  @override Color? get backgroundColor => Colors.white;
}
