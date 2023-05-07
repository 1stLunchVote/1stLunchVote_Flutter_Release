import 'package:firebase_auth/firebase_auth.dart';

import '../model/profile/profile_info.dart';
import '../source/user_remote_data_source.dart';

class ProfileRepository{
  final UserRemoteDataSource _userRemoteDataSource;
  ProfileRepository(this._userRemoteDataSource);

  final FirebaseAuth _auth = FirebaseAuth.instance;
  String get uid => _auth.currentUser?.uid ?? "";

  // Future<NicknameResponse> patchNickname(String nickname){
  //   return lunchVoteService.patchNickname(Nickname(nickname: nickname));
  // }
  //
  // Future<ProfileInfoResponse> getProfileInfo(){
  //   return lunchVoteService.getProfileInfo();
  // }

  Stream<ProfileInfo> getUserInfo() async*{
    await for (var event in _userRemoteDataSource.getUserInfo(uid)){
      yield ProfileInfo.fromJson(Map<String, dynamic>.from(event.snapshot.value as dynamic));
    }
  }

  Future<void> updateUserNickname(String nickname) async{
    return _userRemoteDataSource.updateUserNickname(uid, nickname);
  }

  Future<void> logout() async{
    return _auth.signOut();
  }
}