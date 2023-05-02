import 'package:firebase_auth/firebase_auth.dart';

import '../model/profile/profile_info.dart';
import '../source/user_remote_data_source.dart';

class ProfileRepository{
  final UserRemoteDataSource _userRemoteDataSource;
  ProfileRepository(this._userRemoteDataSource);

  // Future<NicknameResponse> patchNickname(String nickname){
  //   return lunchVoteService.patchNickname(Nickname(nickname: nickname));
  // }
  //
  // Future<ProfileInfoResponse> getProfileInfo(){
  //   return lunchVoteService.getProfileInfo();
  // }

  Stream<ProfileInfo> getUserInfo(String uid) async*{
    await for (var event in _userRemoteDataSource.getUserInfo(uid)){
      yield ProfileInfo.fromJson(Map<String, dynamic>.from(event.snapshot.value as dynamic));
    }
  }

  Future<void> updateUserNickname(String uid, String nickname) async{
    return _userRemoteDataSource.updateUserNickname(uid, nickname);
  }
}