import 'package:lunch_vote/model/group/group_join_response.dart';
import 'package:lunch_vote/model/profile/profile_info.dart';
import 'package:lunch_vote/provider/lunch_vote_service.dart';

class HomeRepository{
  final LunchVoteService lunchVoteService;

  HomeRepository({required this.lunchVoteService});

  Future<ProfileInfoResponse> getNickname(){
    return lunchVoteService.getProfileInfo();
  }

  Future<GroupJoinResponse> joinGroup(String groupId){
    return lunchVoteService.joinGroup(groupId);
  }
}