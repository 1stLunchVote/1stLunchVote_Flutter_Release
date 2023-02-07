import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:lunch_vote/styles.dart';

class SecondVoteTile extends StatelessWidget {
  String foodName = '';
  String? imgUrl;
  int index;
  String menuId;
  Function(String menuId) onVote;
  Function() clearVote;
  Function(String menuId) isVoted;

  SecondVoteTile({super.key,
    required this.foodName,
    required this.imgUrl,
    required this.index,
    required this.menuId,
    required this.onVote,
    required this.clearVote,
    required this.isVoted
  });

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
              if (!isVoted(menuId)){
                onVote(menuId);
              } else {
                clearVote();
              }
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
                    child: imgUrl != null ? CachedNetworkImage(
                      imageUrl: imgUrl!,
                      placeholder: (context, url) => Image.asset("assets/images/default_food.png"),
                    ) : Image.network(imgUrl!)
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
                      foodName,
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
                      child: Visibility(
                        visible: isVoted(menuId),
                        child: Image.asset("assets/images/lunch_vote_splash.png"),
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
