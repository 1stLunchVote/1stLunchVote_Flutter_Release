import 'package:flutter/services.dart';
import 'package:dio/dio.dart';
import 'package:lunch_vote/model/profile/profile_info.dart';
import 'package:lunch_vote/repository/lunch_vote_service.dart';
import 'package:lunch_vote/view/widget/utils/shared_pref_manager.dart';

class ProfileController{
  late LunchVoteService _lunchVoteService;
  final SharedPrefManager _spfManager = SharedPrefManager();

  ProfileController() {
    final dio = Dio();
    dio.options.headers["Content-Type"] = "application/json";
    _spfManager.getUserToken().then((value) => dio.options.headers["Authorization"] = value);
    dio.interceptors.add(LogInterceptor(responseBody: true, requestBody: true));
    _lunchVoteService = LunchVoteService(dio);
  }

  Future<String?> changeNickname(String nickname) async{
    var res = await _lunchVoteService.patchNickname(Nickname(nickname: nickname));
    if (res.success){
      return res.data.nickname;
    }
    return null;
  }
}