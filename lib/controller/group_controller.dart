import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:lunch_vote/repository/lunch_vote_service.dart';
import 'package:lunch_vote/view/widget/utils/shared_pref_manager.dart';

import '../model/group/group_info.dart';
import '../model/group/user_manage.dart';

class GroupController{
  final dio = Dio();
  late LunchVoteService _lunchVoteService;
  final SharedPrefManager _spfManager = SharedPrefManager();

  GroupController() {
    dio.options.headers["Content-Type"] = "application/json";
  }

  Future<String?> createGroup() async{
    dio.options.headers["Authorization"] = await _spfManager.getUserToken();
    dio.interceptors.add(LogInterceptor(responseBody: true, requestBody: true));
    _lunchVoteService = LunchVoteService(dio, baseUrl: dotenv.get('BASE_URL'));

    var res = await _lunchVoteService.createGroup();
    if (res.success){
      return res.data.groupId;
    }
    return null;
  }

  Future<GroupInfo?> getGroupInfo(String groupId) async{
    dio.options.headers["Authorization"] = await _spfManager.getUserToken();
    dio.interceptors.add(LogInterceptor(responseBody: true, requestBody: true));
    _lunchVoteService = LunchVoteService(dio, baseUrl: dotenv.get('BASE_URL'));

    var res = await _lunchVoteService.getGroupInfo(groupId);
    if (res.success){
      return res.data;
    }
    return null;
  }

  Future<String> inviteUser(String groupId, String email) async{
    var res = await _lunchVoteService.inviteUser(groupId, UserEmail(email: email));
    return res.message;
  }

  Future<MemberInfo?> getMyProfile() async {
    var res = await _lunchVoteService.getProfileInfo();
    if (res.success) {
      return MemberInfo(email: res.data.email, nickname: res.data.nickname, profileImage: res.data.profileImage,);
    }
    return null;
  }

  Future<String> withdrawalUser(String groupId) async {
    var res = await _lunchVoteService.withdrawalUser(groupId);
    return res.message;
  }
}