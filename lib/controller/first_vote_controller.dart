import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:lunch_vote/model/vote/first_vote.dart';
import 'package:lunch_vote/model/template/all_template_info.dart';

import '../model/vote/first_vote_result.dart';
import '../repository/lunch_vote_service.dart';
import '../view/widget/utils/shared_pref_manager.dart';

class FirstVoteController{
  final dio = Dio();
  late LunchVoteService _lunchVoteService;
  final SharedPrefManager _spfManager = SharedPrefManager();

  FirstVoteController(){
    dio.options.headers["Content-Type"] = "application/json";
  }

  Future<String?> submitFirstVote(String groupId, List<String> likesMenu, List<String> dislikesMenu) async{
    dio.options.headers["Authorization"] = await _spfManager.getUserToken();
    dio.interceptors.add(LogInterceptor(responseBody: true, requestBody: true));
    _lunchVoteService = LunchVoteService(dio, baseUrl: dotenv.get('BASE_URL'));

    var res = await _lunchVoteService.submitFirstVote(groupId, FirstVoteItem(likesMenu: likesMenu, dislikesMenu: dislikesMenu));

    return res.message;
  }
}