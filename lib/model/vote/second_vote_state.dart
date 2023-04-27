import 'package:lunch_vote/model/vote/first_vote_result.dart';
import 'package:meta/meta.dart';


@sealed
abstract class SecondVoteState{}

class SecondVoteInitial extends SecondVoteState{}

class SecondVoteLoading extends SecondVoteState{}

class SecondVoteSuccess extends SecondVoteState{
  final List<MenuInfo> menuInfo;

  SecondVoteSuccess(this.menuInfo);
}

class SecondVoteCompleted extends SecondVoteState{
  final String votedItem;

  SecondVoteCompleted(this.votedItem);
}

class SecondVoteError extends SecondVoteState{
  final String msg;

  SecondVoteError(this.msg);
}