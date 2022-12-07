import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:lunch_vote/model/vote/vote_item_notifier.dart';
import 'package:provider/provider.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../controller/menu_controller.dart';
import '../../model/menu/menu_info.dart';
import '../../model/vote/first_vote_notifier.dart';

class FirstVoteTile extends StatefulWidget {
  String menuName = '';
  String menuId = '';
  String image = '';
  int index = 0;

  FirstVoteTile({
    super.key,
    required this.menuName,
    required this.menuId,
    required this.image,
    required this.index,
  });

  @override
  State<FirstVoteTile> createState() => _FirstVoteTileState();
}

class _FirstVoteTileState extends State<FirstVoteTile> {
  bool isVoted = false;
  int check = 0;
  Color border_color = Colors.black;
  double border_width = 1.0;
  final _controller = MenuController();
  late Future future;

  @override
  void initState(){
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return IntrinsicHeight(
      child: InkWell(
        onTap: () {
          setState(() {
            context.read<FirstVoteNotifier>().updateStatus(widget.index);
          });
        },
        child: Column(
          children: [
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: context.read<FirstVoteNotifier>().getColor(widget.index),
                      width: context.read<FirstVoteNotifier>().getWidth(widget.index),
                    ),
                  ),
                  child: widget.image != null
                      ? CachedNetworkImage(
                          width: 120.w,
                          height: 120.h,
                          fit: BoxFit.cover,
                          imageUrl: widget.image!,
                          placeholder: (context, url) =>
                              Image.asset("assets/images/default_food.png"),
                        )
                      : Image.asset("assets/images/default_food.png"),
                ),
              ),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(4),
                child: Text(
                  widget.menuName,
                  style: TextStyle(
                      fontSize: 12.sp,
                      fontWeight: FontWeight.bold,
                      color: Theme.of(context).colorScheme.onSurface),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
