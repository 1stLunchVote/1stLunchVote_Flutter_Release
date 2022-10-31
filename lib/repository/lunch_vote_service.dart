import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';
import 'package:lunch_vote/model/user_info.dart';

part 'lunch_vote_service.g.dart';

@RestApi(baseUrl: "http://54.173.224.149:8000")
abstract class LunchVoteService{
  factory LunchVoteService(Dio dio) = _LunchVoteService;

  @POST('/auth/login/KAKAO')
  Future<UserInfoResponse> postUserToken(@Query('socialToken') String token);
}