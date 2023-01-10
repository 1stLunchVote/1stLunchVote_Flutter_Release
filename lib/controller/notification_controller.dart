import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:get/get.dart';

import '../repository/lunch_vote_service.dart';
import '../view/widget/utils/shared_pref_manager.dart';

class NotificationController extends GetxController{
  final dio = Dio();
  bool firstCalled = true;
  late LunchVoteService _lunchVoteService;
  final SharedPrefManager _spfManager = SharedPrefManager();

  NotificationController() {
    dio.options.headers["Content-Type"] = "application/json";
  }

  Future<bool?> joinGroup(String groupId) async{
    dio.options.headers["Authorization"] = await _spfManager.getUserToken();
    dio.interceptors.add(LogInterceptor(responseBody: true, requestBody: true));
    _lunchVoteService = LunchVoteService(dio, baseUrl: dotenv.get('BASE_URL'));

    var res = await _lunchVoteService.joinGroup(groupId);
    if (res.success){
      return true;
    }
    return null;
  }
}