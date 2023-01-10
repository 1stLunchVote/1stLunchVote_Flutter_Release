import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lunch_vote/styles.dart';
import 'package:provider/provider.dart';

import '../../controller/second_vote_controller.dart';

class SecondVoteTile extends StatefulWidget {
  String foodName = '';
  String? imgUrl;
  int index;
  String menuId;
  SecondVoteController controller;

  SecondVoteTile({super.key,
    required this.foodName,
    required this.imgUrl,
    required this.index,
    required this.menuId,
    required this.controller
  });

  @override
  State<SecondVoteTile> createState() => _SecondVoteTileState();
}

class _SecondVoteTileState extends State<SecondVoteTile> {
  bool isVoted = false;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Divider(
          height: 1,
          thickness: 1,
          color: Theme.of(context).brightness == Brightness.light ? textLightSecondary : textDarkSecondary,
        ),
        IntrinsicHeight(
          child: InkWell(
            onTap: (){
              setState(() {
                if (!isVoted) {
                  widget.controller.setVotedId(widget.menuId);
                } else {
                  widget.controller.clearVotedId();
                }
                isVoted = !isVoted;
              });
            },
            child: Row(
              children: [
                VerticalDivider(
                  thickness: 1,
                  width: 1,
                  color: Theme.of(context).brightness == Brightness.light ? textLightSecondary : textDarkSecondary,
                ),
                Expanded(
                  flex: 8,
                  child: widget.imgUrl != null ? CachedNetworkImage(
                    imageUrl: widget.imgUrl!,
                    placeholder: (context, url) => Image.asset("assets/images/default_food.png"),
                  ) : Image.network(widget.imgUrl!)
                ),
                VerticalDivider(
                  thickness: 1,
                  width: 1,
                  color: Theme.of(context).brightness == Brightness.light ? textLightSecondary : textDarkSecondary,
                ),
                Expanded(
                  flex: 17,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Text(
                      widget.foodName,
                      style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                        color: Theme.of(context).colorScheme.onSurface
                      ),
                    ),
                  ),
                ),
                VerticalDivider(
                  thickness: 1,
                  width: 1,
                  color: Theme.of(context).brightness == Brightness.light ? textLightSecondary : textDarkSecondary,
                ),
                Expanded(
                    flex: 8,
                    child: Padding(
                      padding: const EdgeInsets.all(5.0),
                      child: Obx(() => Visibility(
                          visible: widget.controller.selectedId == widget.menuId,
                          child: Image.asset("assets/images/lunch_vote_splash.png"),
                        ),
                      ),
                    )
                ),
                VerticalDivider(
                  thickness: 1,
                  width: 1,
                  color: Theme.of(context).brightness == Brightness.light ? textLightSecondary : textDarkSecondary,
                ),
              ],
            ),
          ),
        ),
        Divider(
          height: 1,
          thickness: 1,
          color: Theme.of(context).brightness == Brightness.light ? textLightSecondary : textDarkSecondary,
        ),
      ],
    );
  }
}
