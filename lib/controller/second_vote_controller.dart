import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:get/get.dart';
import 'package:lunch_vote/model/vote/second_vote.dart';

import '../model/vote/first_vote_result.dart';
import '../repository/lunch_vote_service.dart';
import '../view/widget/utils/shared_pref_manager.dart';

class SecondVoteController extends GetxController{
  final dio = Dio();
  late String groupId;
  late LunchVoteService _lunchVoteService;
  final SharedPrefManager _spfManager = SharedPrefManager();

  var selectedId = "".obs;

  SecondVoteController(){
    dio.options.headers["Content-Type"] = "application/json";
  }

  void setVotedId(String menuId){
    selectedId.value = menuId;
  }

  void clearVotedId(){
    selectedId.value = "";
  }

  Future<List<MenuInfo>?> getMenuInfo(String groupId) async {
    this.groupId = groupId;
    dio.options.headers["Authorization"] = await _spfManager.getUserToken();
    dio.interceptors.add(LogInterceptor(responseBody: true, requestBody: true));
    _lunchVoteService = LunchVoteService(dio, baseUrl: dotenv.get('BASE_URL'));

    var res = await _lunchVoteService.getFirstVoteResult(groupId);
    if (res.success){
      return res.data.menuInfos;
    }
    return null;
  }

  Future<int?> voteItem() async{
    var res = await _lunchVoteService.secondVoteItem(groupId, SecondVoteItem(menuId: selectedId.value));
    if (res.success){
      return res.data.count;
    }
    return null;
  }
}