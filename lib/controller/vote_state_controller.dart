import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:lunch_vote/repository/lunch_vote_service.dart';
import 'package:lunch_vote/view/widget/utils/shared_pref_manager.dart';

class VoteStateController {
  final dio = Dio();
  late LunchVoteService _lunchVoteService;
  final SharedPrefManager _spfManager = SharedPrefManager();

  VoteStateController(){
    dio.options.headers["Content-Type"] = "application/json";
  }

  Future<bool?> fetchFirstVoteResult(String groupId) async{
    dio.options.headers["Authorization"] = await _spfManager.getUserToken();
    dio.interceptors.add(LogInterceptor(responseBody: true, requestBody: true));
    _lunchVoteService = LunchVoteService(dio, baseUrl: dotenv.get('BASE_URL'));
    var res = await _lunchVoteService.getFirstVoteState(groupId);
    if (res.success){
      return res.data.finish;
    }
    return null;
  }

  Future<bool?> fetchSecondVoteResult(String groupId) async{
    dio.options.headers["Authorization"] = await _spfManager.getUserToken();
    dio.interceptors.add(LogInterceptor(responseBody: true, requestBody: true));
    _lunchVoteService = LunchVoteService(dio, baseUrl: dotenv.get('BASE_URL'));
    var res = await _lunchVoteService.getSecondVoteState(groupId);
    if (res.success){
      return res.data.finish;
    }
    return null;
  }
}