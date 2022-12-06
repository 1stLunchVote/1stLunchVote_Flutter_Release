import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

class FirstVoteTile extends StatefulWidget {
  String menuName = '';
  String menuId = '';
  String? imgUrl;
  int? index;

  FirstVoteTile({
    super.key,
    required this.menuName,
    required this.menuId,
    required this.imgUrl,
    required this.index,
  });

  @override
  State<FirstVoteTile> createState() => _FirstVoteTileState();
}

class _FirstVoteTileState extends State<FirstVoteTile> {
  bool isVoted = false;
  int check = 0;
  Color border_color = Colors.black;
  double border_width = 0.0;
  @override
  Widget build(BuildContext context) {
    return IntrinsicHeight(
      child: InkWell(
        onTap: () {
          setState(() {
            if (check % 3 == 0) {
              border_color = Colors.black;
              border_width = 0;
              check %= 3;
              check++;
            }
            else if (check % 3 == 1) {
              border_color = Colors.green;
              border_width = 3;
              check %= 3;
              check++;
            }
            else if (check % 3 == 2) {
              border_color = Colors.red;
              border_width = 3;
              check %= 3;
              check++;
            }
            isVoted = !isVoted;
          });
        },
        child: Column(
          children: [
            Expanded(
                flex: 80,
                child: Container(
                  decoration: BoxDecoration(
                    border: Border.all(color: border_color, width: border_width),
                  ),
                  child: widget.imgUrl != null
                      ? CachedNetworkImage(
                          imageUrl: widget.imgUrl!,
                          placeholder: (context, url) =>
                              Image.asset("assets/images/default_food.png"),
                        )
                      : Image.asset("assets/images/default_food.png"),
                ),
            ),
            Expanded(
              flex: 16,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
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
