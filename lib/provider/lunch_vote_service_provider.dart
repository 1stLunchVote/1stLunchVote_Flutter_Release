import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:lunch_vote/provider/lunch_vote_dio_provider.dart';
import 'package:lunch_vote/provider/lunch_vote_service.dart';

class LunchVoteServiceProvider{
  static LunchVoteService? instance;
  static LunchVoteService? loginInstance;
  // final storage = const FlutterSecureStorage();

  static LunchVoteService getInstance() {
    if (instance == null){
      Dio dio = LunchVoteDioProvider.getInstance();
      instance = LunchVoteService(dio, baseUrl: dotenv.get('BASE_URL'));
    }
    return instance!;
  }

  static LunchVoteService getLoginInstance(){
    if (loginInstance == null){
      final dio = Dio();
      dio.options.headers["Content-Type"] = "application/json";
      dio.interceptors.add(LogInterceptor(responseBody: true, requestBody: true));
      loginInstance = LunchVoteService(dio, baseUrl: dotenv.get('BASE_URL'));
    }
    return loginInstance!;
  }
}