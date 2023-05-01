import 'package:lunch_vote/model/group/group_info.dart';
import 'package:lunch_vote/model/group/user_manage.dart';
import 'package:lunch_vote/model/profile/profile_info.dart';
import 'package:lunch_vote/provider/lunch_vote_service.dart';

class GroupRepository {
  final LunchVoteService lunchVoteService;

  GroupRepository({required this.lunchVoteService});

  Future<GroupInfoResponse> createGroup() {
    return lunchVoteService.createGroup();
  }

  Future<GroupInfoResponse> getGroupInfo(String groupId) {
    return lunchVoteService.getGroupInfo(groupId);
  }

  Future<UserInviteResponse> inviteUser(String groupId, String email) {
    return lunchVoteService.inviteUser(groupId, UserEmail(email: email));
  }

  Future<ProfileInfoResponse> getMyProfile() {
    return lunchVoteService.getProfileInfo();
  }

  Future<UserWithdrawalResponse> withdrawalUser(String groupId) {
    return lunchVoteService.withdrawalUser(groupId);
  }
}