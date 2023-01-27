import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:lunch_vote/provider/api/lunch_vote_api.dart';
import 'package:lunch_vote/utils/shared_pref_manager.dart';

class LunchVoteService{
  final SharedPrefManager _spfManager = SharedPrefManager();
  late LunchVoteApi _lunchVoteApi;
  LunchVoteApi get service => _lunchVoteApi;

  // Singleton
  static final LunchVoteService instance = LunchVoteService._internal();

  factory LunchVoteService() => instance;

  LunchVoteService._internal(){
    // 처음 인스턴스를 만들어 실행하는 코드
    final Dio dio = Dio();
    _spfManager.getUserToken().then((value) {
      dio.options.headers["Content-Type"] = "application/json";
      dio.options.headers["Authorization"] = value;
      dio.interceptors.add(LogInterceptor(responseBody: true, requestBody: true));
      _lunchVoteApi = LunchVoteApi(dio, baseUrl: dotenv.get('BASE_URL'));
      }
    );
  }
}