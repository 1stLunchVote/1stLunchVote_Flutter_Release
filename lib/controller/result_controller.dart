import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:get/get.dart';
import 'package:lunch_vote/utils/shared_pref_manager.dart';

import '../model/vote/final_result.dart';
import '../provider/lunch_vote_service.dart';

class ResultController extends GetxController{
  final dio = Dio();
  late String groupId;
  late LunchVoteService _lunchVoteService;
  final SharedPrefManager _spfManager = SharedPrefManager();

  ResultController(){
    dio.options.headers["Content-Type"] = "application/json";
  }

  Future<FinalResult?> getFinalResult(String groupId) async{
    this.groupId = groupId;
    dio.options.headers["Authorization"] = await _spfManager.getUserToken();
    dio.interceptors.add(LogInterceptor(responseBody: true, requestBody: true));
    _lunchVoteService = LunchVoteService(dio, baseUrl: dotenv.get('BASE_URL'));

    var res = await _lunchVoteService.getFinalResult(groupId);
    if (res.success){
      return res.data;
    }
    return null;
  }
}