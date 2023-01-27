import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:lunch_vote/provider/lunch_vote_dio_provider.dart';
import 'package:lunch_vote/provider/lunch_vote_service.dart';

class LunchVoteServiceProvider{
  static LunchVoteService? instance;
  // final storage = const FlutterSecureStorage();

  static LunchVoteService getInstance() {
    if (instance == null){
      Dio dio = LunchVoteDioProvider.getInstance();
      instance = LunchVoteService(dio, baseUrl: dotenv.get('BASE_URL'));
    }
    return instance!;
  }
}