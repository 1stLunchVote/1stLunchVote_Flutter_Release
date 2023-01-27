import 'package:dio/dio.dart';

class LunchVoteDioProvider{
  static Dio? dio;
  static setOptions(String idToken){
    dio = Dio();
    dio?.options.headers["Content-Type"] = "application/json";
    dio?.options.headers["Authorization"] = idToken;
    dio?.interceptors.add(LogInterceptor(responseBody: true, requestBody: true));
  }

  static getInstance() {
    return dio;
  }
}