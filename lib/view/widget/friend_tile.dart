import 'package:flutter/material.dart';
import 'package:lunch_vote/styles.dart';

class FriendTile extends StatefulWidget {
  final String name;
  final String profileImage; // TODO 서버로부터 요청 받은 걸로 받을 수 있게 수정해야 함 (현재 임시)

  const FriendTile({
    Key? key,
    required this.name,
    required this.profileImage,
  }) : super(key: key);

  @override
  State<FriendTile> createState() => _FriendTileState();
}

class _FriendTileState extends State<FriendTile> {
  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: CircleAvatar(
        radius: 24,
        backgroundImage: AssetImage(widget.profileImage), // TODO 서버로부터 친구 프로필 사진 가져오기
      ),
      title: Text(
        widget.name,
        style: Theme
            .of(context)
            .textTheme
            .titleSmall,
      ),
    );
  }
}
