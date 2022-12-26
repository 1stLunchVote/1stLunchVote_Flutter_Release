import 'package:flutter/services.dart';
import 'package:dio/dio.dart';
import 'package:lunch_vote/repository/lunch_vote_service.dart';
import 'package:lunch_vote/view/widget/utils/shared_pref_manager.dart';

import '../model/menu/menu_info.dart';

class MenuController{
  final dio = Dio();
  late LunchVoteService _lunchVoteService;
  final SharedPrefManager _spfManager = SharedPrefManager();

  MenuController() {
    dio.options.headers["Content-Type"] = "application/json";
  }

  Future<List<MenuInfo>?> getMenuInfo() async{
    dio.options.headers["Authorization"] = await _spfManager.getUserToken();
    dio.interceptors.add(LogInterceptor(responseBody: true, requestBody: true));
    _lunchVoteService = LunchVoteService(dio);

    var res = await _lunchVoteService.getMenuInfo();
    if (res.success){
      return res.data;
    }
    return null;
  }
}