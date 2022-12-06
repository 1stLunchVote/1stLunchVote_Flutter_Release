import 'package:dio/dio.dart';

import '../model/vote/first_vote_result.dart';
import '../repository/lunch_vote_service.dart';
import '../view/widget/utils/shared_pref_manager.dart';

class SecondVoteController{
  final dio = Dio();
  late LunchVoteService _lunchVoteService;
  final SharedPrefManager _spfManager = SharedPrefManager();

  SecondVoteController(){
    dio.options.headers["Content-Type"] = "application/json";
  }

  Future<List<MenuInfo>?> getMenuInfo(String groupId) async {
    dio.options.headers["Authorization"] = await _spfManager.getUserToken();
    dio.interceptors.add(LogInterceptor(responseBody: true, requestBody: true));
    _lunchVoteService = LunchVoteService(dio);

    var res = await _lunchVoteService.getFirstVoteResult(groupId);
    if (res.success){
      return res.data.menuInfos;
    }
    return null;
  }
}