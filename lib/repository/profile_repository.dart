import '../model/profile/profile_info.dart';
import '../provider/lunch_vote_service.dart';

class ProfileRepository{
  final LunchVoteService lunchVoteService;

  ProfileRepository({required this.lunchVoteService});

  Future<NicknameResponse> patchNickname(String nickname){
    return lunchVoteService.patchNickname(Nickname(nickname: nickname));
  }

  Future<ProfileInfoResponse> getProfileInfo(){
    return lunchVoteService.getProfileInfo();
  }
}