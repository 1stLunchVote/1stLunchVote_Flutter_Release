import 'dart:async';
import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:lunch_vote/model/vote/first_vote.dart';
import 'package:get/get.dart';
import '../model/vote/first_vote_result.dart';
import '../provider/lunch_vote_service.dart';
import '../utils/shared_pref_manager.dart';


class FirstVoteController extends GetxController{
  final dio = Dio();
  late Timer _timer;

  late String groupId;
  late LunchVoteService _lunchVoteService;
  final SharedPrefManager _spfManager = SharedPrefManager();

  final RxString _selectedId = "".obs;
  final RxInt _timeCount = 60.obs;
  String get selectedId => _selectedId.value;
  int get timeCount => _timeCount.value;

  FirstVoteController(){
    _timer = Timer.periodic(const Duration(milliseconds: 1000), (timer) {
      if (_timeCount.value > 0){
        _timeCount.value -= 1;
      } else{
        _timer.cancel();
      }
    });
    dio.options.headers["Content-Type"] = "application/json";
  }

  @override
  void dispose(){
    super.dispose();
    _timer?.cancel();
  }

  Future<String?> submitFirstVote(String groupId, List<String> likesMenu, List<String> dislikesMenu) async{
    dio.options.headers["Authorization"] = await _spfManager.getUserToken();
    dio.interceptors.add(LogInterceptor(responseBody: true, requestBody: true));
    _lunchVoteService = LunchVoteService(dio, baseUrl: dotenv.get('BASE_URL'));

    var res = await _lunchVoteService.submitFirstVote(groupId, FirstVoteItem(likesMenu: likesMenu, dislikesMenu: dislikesMenu));

    return res.message;
  }
}