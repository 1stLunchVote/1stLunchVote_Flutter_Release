import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';
import 'package:lunch_vote/model/profile/profile_info.dart';
import 'package:lunch_vote/model/template/template_info.dart';
import 'package:lunch_vote/model/vote/second_vote.dart';
import 'package:lunch_vote/model/vote/vote_state.dart';
import 'package:lunch_vote/model/login/user_info.dart';
import 'package:lunch_vote/model/group/group_info.dart';
import 'package:lunch_vote/model/group/user_manage.dart';
import 'package:lunch_vote/model/group/group_join_response.dart';
import 'package:lunch_vote/model/template/all_template_info.dart';
import 'package:lunch_vote/model/vote/final_result.dart';
import 'package:lunch_vote/model/vote/first_vote.dart';
import 'package:lunch_vote/model/vote/first_vote_result.dart';
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

  // 그룹 생성
  @POST('/group')
  Future<GroupInfoResponse> createGroup();

  // 그룹 정보 조회
  @GET('/group/{groupId}')
  Future<GroupInfoResponse> getGroupInfo(@Path() String groupId);

  // 유저 초대
  @PATCH('/group/{groupId}/invite')
  Future<UserInviteResponse> inviteUser(@Path() String groupId, @Body() UserEmail email);

  // 그룹 탈퇴
  @PATCH('/group/{groupId}/withdrawal')
  Future<UserWithdrawalResponse> withdrawalUser(@Path() String groupId);

  // 유저 프로필 조회
  @GET('/user')
  Future<ProfileInfoResponse> getProfileInfo();

  // 메뉴 정보 가져오기
  @GET('/menu')
  Future<MenuInfoResponse> getMenuInfo();

  // 1차 투표
  @PATCH('/group/{groupId}/vote/first')
  Future<FirstVoteResponse> submitFirstVote(@Path() String groupId, @Body() FirstVoteItem voteItem);

  // 전체 템플릿 조회
  @GET('/lunchTemplate')
  Future<AllTemplateResponse> getAllTemplateInfo();

  // 템플릿 하나 조회
  @GET('/lunchTemplate/{lunchTemplateId}')
  Future<OneTemplateResponse> getOneTemplateInfo(@Path() String lunchTemplateId);

  // 템플릿 생성
  @POST('/lunchTemplate')
  Future<TemplateInfoResponse> createTemplate(@Body() TemplateInfo templateInfo);

  // 템플릿 수정
  @PUT('/lunchTemplate/{lunchTemplateId}')
  Future<TemplateInfoResponse> modifyTemplate(@Path() String lunchTemplateId, @Body() TemplateInfo templateInfo);

  @DELETE('/lunchTemplate/{lunchTemplateId}')
  Future<TemplateDeleteResponse> deleteTemplate(@Path() String lunchTemplateId);

  // 1차 투표 상태 조회
  @GET('/group/{groupId}/vote/first/status')
  Future<VoteStateResponse> getFirstVoteState(@Path() String groupId);

  // 1차 투표 결과 조회
  @GET('/group/{groupId}/vote/first/result')
  Future<FirstVoteResultResponse> getFirstVoteResult(@Path() String groupId);

  // 2차 투표
  @PATCH('/group/{groupId}/vote/second')
  Future<SecondVoteResponse> secondVoteItem(@Path() String groupId, @Body() SecondVoteItem voteItem);

  // 2차 투표 상태 조회
  @GET('/group/{groupId}/vote/second/status')
  Future<VoteStateResponse> getSecondVoteState(@Path() String groupId);

  // 최종 결과 조회
  @GET('/group/{groupId}/vote/second/result')
  Future<FinalResultResponse> getFinalResult(@Path() String groupId);

  @PATCH('/group/{groupId}/join')
  Future<GroupJoinResponse> joinGroup(@Path() String groupId);
}
