import 'package:flutter/material.dart';
import 'package:lunch_vote/styles.dart';

class FriendTile extends StatefulWidget {
  const FriendTile({Key? key}) : super(key: key);

  @override
  State<FriendTile> createState() => _FriendTileState();
}

class _FriendTileState extends State<FriendTile> {
  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: CircleAvatar(
        radius: 24,
        backgroundImage: AssetImage("assets/images/friend_profile_default.png"),
      ),
      title: Text(
        '이동건',
        style: Theme
            .of(context)
            .textTheme
            .titleSmall,
      ),
    );
  }
}
