import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

import '../../model/vote/first_vote_notifier.dart';

class FirstVoteTile extends StatefulWidget {
  final int menuIdx;
  const FirstVoteTile({super.key, required this.menuIdx});

  @override
  State<FirstVoteTile> createState() => _FirstVoteTileState();
}

class _FirstVoteTileState extends State<FirstVoteTile> {
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          width: 80.w,
          height: 80.w,
          decoration: BoxDecoration(
            borderRadius: const BorderRadius.all(Radius.circular(16.0)),
            border: Border.all(
              width: 2.0,
              color: context.watch<FirstVoteNotifier>().getColor(widget.menuIdx),
            ),
          ),
          child: Stack(
            children: [
              ClipRRect(
                borderRadius: const BorderRadius.all(Radius.circular(16.0)),
                child: CachedNetworkImage(imageUrl: context.watch<FirstVoteNotifier>().getImg(widget.menuIdx),),
              ),
              ClipRRect(
                borderRadius: const BorderRadius.all(Radius.circular(16.0)),
                child: Center(
                  child: Material(
                    color: Colors.transparent,
                    child: InkWell(
                      onTap: () {
                        setState(() {
                          context.read<FirstVoteNotifier>().updateStatus(widget.menuIdx);

                        });
                      },
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 4.0),
          child: Text(
            context.watch<FirstVoteNotifier>().getName(widget.menuIdx),
            style: Theme.of(context).textTheme.labelLarge,
          ),
        ),
      ],
    );
  }
}