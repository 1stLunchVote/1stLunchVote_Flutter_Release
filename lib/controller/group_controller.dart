import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:get/get.dart';
import 'package:lunch_vote/model/group/group_info.dart';
import 'package:lunch_vote/model/group/user_manage.dart';
import 'package:lunch_vote/repository/lunch_vote_service.dart';
import 'package:lunch_vote/view/widget/utils/shared_pref_manager.dart';

class GroupController extends GetxController {
  final dio = Dio();
  late LunchVoteService _lunchVoteService;
  final SharedPrefManager _spfManager = SharedPrefManager();

  GroupController() {
    dio.options.headers["Content-Type"] = "application/json";
  }

  Future<String?> createGroup() async{
    dio.options.headers["Authorization"] = await _spfManager.getUserToken();
    dio.interceptors.add(LogInterceptor(responseBody: true, requestBody: true));
    _lunchVoteService = LunchVoteService(dio, baseUrl: dotenv.get('BASE_URL'));

    var res = await _lunchVoteService.createGroup();
    if (res.success){
      return res.data.groupId;
    }
    return null;
  }

  Future<GroupInfo?> getGroupInfo(String groupId) async{
    dio.options.headers["Authorization"] = await _spfManager.getUserToken();
    dio.interceptors.add(LogInterceptor(responseBody: true, requestBody: true));
    _lunchVoteService = LunchVoteService(dio, baseUrl: dotenv.get('BASE_URL'));

    var res = await _lunchVoteService.getGroupInfo(groupId);
    if (res.success){
      return res.data;
    }
    return null;
  }

  Future<String> inviteUser(String groupId, String email) async{
    var res = await _lunchVoteService.inviteUser(groupId, UserEmail(email: email));
    return res.message;
  }

  Future<MemberInfo?> getMyProfile() async {
    var res = await _lunchVoteService.getProfileInfo();
    if (res.success) {
      return MemberInfo(email: res.data.email, nickname: res.data.nickname, profileImage: res.data.profileImage,);
    }
    return null;
  }

  Future<String> withdrawalUser(String groupId) async {
    dio.options.headers["Authorization"] = await _spfManager.getUserToken();
    dio.interceptors.add(LogInterceptor(responseBody: true, requestBody: true));
    _lunchVoteService = LunchVoteService(dio, baseUrl: dotenv.get('BASE_URL'));
    var res = await _lunchVoteService.withdrawalUser(groupId);
    return res.message;
  }

  late final _groupId = "".obs;
  final _members = [].obs;
  final _allReady = false.obs;

  List get members => _members;
  String get groupId => _groupId.value;
  bool get isAllReady => _allReady.value;

  void setGroupId(String groupId) {
    _groupId.value = groupId;
  }

  void add(MemberInfo member) {
    _members.add(Member(isReady: _members.isEmpty, memberInfo: member));
  }

  // TODO: 사용자 정보 받을 때 준비 완료 여부도 받기
  void set(List<MemberInfo> member) {
    _members.clear();
    for (int i = 0; i < member.length; i++) {
      _members.add(Member(isReady: _members.isEmpty, memberInfo: member[i]));
    }
  }

  void remove(int memberIdx) {
    _members.removeAt(memberIdx);
  }

  void changeMemberIsReady(int memberIdx) {
    _members[memberIdx].isReady = !_members[memberIdx].isReady;
    checkReady();
  }

  void checkReady() {
    int cnt = 0;
    for (int i = 0; i < _members.length; i++) {
      if (!_members[i].isReady) {
        cnt++;
      }
    }
    _allReady.value = cnt == 0;
  }
}

// TODO: 임시
class Member {
  bool isReady;
  final MemberInfo memberInfo;

  Member({
    required this.isReady,
    required this.memberInfo,
  });
}