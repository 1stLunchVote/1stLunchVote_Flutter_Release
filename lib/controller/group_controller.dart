import 'package:dio/dio.dart';
import 'package:lunch_vote/repository/lunch_vote_service.dart';
import 'package:lunch_vote/view/widget/utils/shared_pref_manager.dart';

class GroupController{
  late LunchVoteService _lunchVoteService;
  final SharedPrefManager _spfManager = SharedPrefManager();

  GroupController() {
    final dio = Dio();
    dio.options.headers["Content-Type"] = "application/json";
    _spfManager.getUserToken().then((value) => dio.options.headers["Authorization"] = value);
    dio.interceptors.add(LogInterceptor(responseBody: true, requestBody: true));
    _lunchVoteService = LunchVoteService(dio);
  }

  Future<String?> createGroup() async{
    var res = await _lunchVoteService.createGroup();
    if (res.success){
      return res.data.groupId;
    }
    return null;
  }

  Future<String?> searchUser(String groupId, String email) async{
    var res = await _lunchVoteService.searchUser(groupId, email);
    if (res.success){
      return res.data.nickname;
    }
    return null;
  }
}