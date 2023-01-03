import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:lunch_vote/styles.dart';

class BasicAppbar extends AppBar {
  final bool backVisible;
  final String appbarTitle;
  final bool isTitleCenter;
  final BuildContext context;
  final List<Widget>? trailingList;
  final Function()? popFunction;

  BasicAppbar(
      {super.key,
      required this.backVisible,
      required this.appbarTitle,
      required this.isTitleCenter,
      required this.context,
      this.trailingList,
      this.popFunction});

  @override
  double? get elevation => 0;

  @override
  Widget? get title => Text(appbarTitle,
    style: Theme.of(context).textTheme.titleLarge,
  );

  @override
  bool? get centerTitle => isTitleCenter;

  @override
  Widget? get leading {
    if (popFunction == null) {
      return Visibility(
        visible: backVisible,
        child: IconButton(
          icon: Icon(
            Icons.arrow_back,
            color: Theme.of(context).brightness == Brightness.light ? textLightMain : textDarkMain,
          ),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
      );
    } else {
      return Visibility(
        visible: backVisible,
        child: IconButton(
          icon: Icon(
            Icons.arrow_back,
            color: Theme.of(context).brightness == Brightness.light ? textLightMain : textDarkMain,
          ),
          onPressed: popFunction,
        ),
      );
    }
  }

  @override
  Color? get backgroundColor => Theme.of(context).backgroundColor;

  // @override
  // SystemUiOverlayStyle? get systemOverlayStyle => const SystemUiOverlayStyle(
  //     statusBarBrightness: Brightness.light,
  //     statusBarIconBrightness: Brightness.dark,
  //     statusBarColor: mainBackgroundColor
  // );

  @override
  List<Widget>? get actions => trailingList;
}
