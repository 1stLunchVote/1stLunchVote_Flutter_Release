import 'package:dio/dio.dart';
import 'package:kakao_flutter_sdk/kakao_flutter_sdk.dart';
import 'package:lunch_vote/model/profile/profile_info.dart';
import 'package:retrofit/retrofit.dart';
import 'package:lunch_vote/model/login/user_info.dart';
import 'package:lunch_vote/model/menu/menu_info.dart';

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

  // 메뉴 정보 가져오기
  @GET('/menu')
  Future<MenuInfoResponse> getMenuInfo();
}
