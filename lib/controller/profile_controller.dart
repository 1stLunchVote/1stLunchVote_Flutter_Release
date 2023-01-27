import 'package:flutter/services.dart';
import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:kakao_flutter_sdk/kakao_flutter_sdk.dart';
import 'package:lunch_vote/model/profile/profile_info.dart';
import 'package:lunch_vote/provider/lunch_vote_service.dart';

import '../utils/shared_pref_manager.dart';

class ProfileController{
  final dio = Dio();
  late LunchVoteService _lunchVoteService;
  final SharedPrefManager _spfManager = SharedPrefManager();

  ProfileController() {
    dio.options.headers["Content-Type"] = "application/json";
  }

  Future<String?> changeNickname(String nickname) async{
    var res = await _lunchVoteService.patchNickname(Nickname(nickname: nickname));
    if (res.success){
      return res.data.nickname;
    }
    return null;
  }

  Future<ProfileInfo?> getProfileInfo() async{
    dio.options.headers["Authorization"] = await _spfManager.getUserToken();
    dio.interceptors.add(LogInterceptor(responseBody: true, requestBody: true));
    _lunchVoteService = LunchVoteService(dio, baseUrl: dotenv.get('BASE_URL'));

    var res = await _lunchVoteService.getProfileInfo();
    if (res.success){
      return res.data;
    }
    return null;
  }

  Future<void> logout() async{
    _spfManager.clearUserToken();
  }
}