import '../source/user_remote_data_source.dart';

class HomeRepository{
  final UserRemoteDataSource _userRemoteDataSource;

  HomeRepository(this._userRemoteDataSource);

  // Future<ProfileInfoResponse> getNickname(){
  //   return lunchVoteService.getProfileInfo();
  // }
  //
  // Future<GroupJoinResponse> joinGroup(String groupId){
  //   return lunchVoteService.joinGroup(groupId);
  // }
  Stream<String> getUserNickName(String? uid) async*{
    await for (var event in _userRemoteDataSource.getUserNickname(uid)){
      yield event.snapshot.value.toString();
    }
  }
}