import 'package:lunch_vote/provider/lunch_vote_service.dart';
import '../model/vote/first_vote_result.dart';
import '../model/vote/second_vote.dart';
import '../model/vote/vote_state.dart';

class SecondVoteRepository{
  final LunchVoteService lunchVoteService;

  SecondVoteRepository({required this.lunchVoteService});

  Future<FirstVoteResultResponse> getFirstVoteResult(String groupId) {
    return lunchVoteService.getFirstVoteResult(groupId);
  }

  Future<SecondVoteResponse> secondVoteItem(String groupId, String menuId) {
    return lunchVoteService.secondVoteItem(groupId, SecondVoteItem(menuId: menuId));
  }

  Future<VoteStateResponse> fetchSecondVoteState(String groupId){
    return lunchVoteService.getSecondVoteState(groupId);
  }
}