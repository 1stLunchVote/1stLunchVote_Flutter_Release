import 'package:dio/dio.dart';
import 'package:kakao_flutter_sdk/kakao_flutter_sdk.dart';
import 'package:lunch_vote/model/profile/profile_info.dart';
import 'package:lunch_vote/model/vote/second_vote.dart';
import 'package:retrofit/retrofit.dart';
import 'package:lunch_vote/model/login/user_info.dart';

import '../model/vote/final_result.dart';
import '../model/vote/first_vote_result.dart';

part 'lunch_vote_service.g.dart';

@RestApi(baseUrl: "http://54.173.224.149:8000")
abstract class LunchVoteService{
  factory LunchVoteService(Dio dio) = _LunchVoteService;

  // 카카오 로그인 및 토큰 생성
  @POST('/auth/login/KAKAO')
  Future<UserInfoResponse> postUserToken(@Body() SocialToken socialToken);

  // 유저 닉네임 변경
  @PATCH('/user/nickname')
  Future<NicknameResponse> patchNickname(@Body() Nickname nickname);

  // 유저 프로필 조회
  @GET('/user')
  Future<ProfileInfoResponse> getProfileInfo();

  // 1차 투표 결과 조회
  @GET('/group/{groupId}/vote/first/result')
  Future<FirstVoteResultResponse> getFirstVoteResult(@Path() String groupId);

  // 2차 투표
  @PATCH('/group/{groupId}/vote/second')
  Future<SecondVoteResponse> secondVoteItem(@Path() String groupId, @Body() SecondVoteItem voteItem);

  // 2차 투표 상태 조회
  @GET('/group/{groupId}/vote/second/status')
  Future<SecondVoteStateResponse> getSecondVoteState(@Path() String groupId);

  // 최종 결과 조회
  @GET('/group/{groupId}/vote/second/result')
  Future<FinalResultResponse> getFinalResult(@Path() String groupId);
}
