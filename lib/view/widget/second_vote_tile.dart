import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class SecondVoteTile extends StatefulWidget {
  String foodName = '';
  String? imgUrl;

  SecondVoteTile({super.key,
    required this.foodName,
    required this.imgUrl
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
          color: Theme.of(context).colorScheme.outline,
        ),
        IntrinsicHeight(
          child: InkWell(
            onTap: (){
              setState(() {
                isVoted = !isVoted;
              });
            },
            child: Row(
              children: [
                VerticalDivider(
                  thickness: 1,
                  width: 1,
                  color: Theme.of(context).colorScheme.outline,
                ),
                Expanded(
                  flex: 8,
                  child: widget.imgUrl != null ? CachedNetworkImage(
                    imageUrl: widget.imgUrl!,
                    placeholder: (context, url) => Image.asset("assets/images/default_food.png"),
                  ) : Image.asset("assets/images/default_food.png")
                ),
                VerticalDivider(
                  thickness: 1,
                  width: 1,
                  color: Theme.of(context).colorScheme.outline,
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
                  color: Theme.of(context).colorScheme.outline,
                ),
                Expanded(
                    flex: 8,
                    child: Padding(
                      padding: const EdgeInsets.all(5.0),
                      child: Visibility(
                        visible: isVoted,
                        child: Image.asset("assets/images/ic_launcher.png"),
                      ),
                    )
                ),
                VerticalDivider(
                  thickness: 1,
                  width: 1,
                  color: Theme.of(context).colorScheme.outline,
                ),
              ],
            ),
          ),
        ),
        Divider(
          height: 1,
          thickness: 1,
          color: Theme.of(context).colorScheme.outline,
        ),
      ],
    );
  }
}
