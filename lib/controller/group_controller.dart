import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:get/get.dart';
import 'package:lunch_vote/model/group/group_info.dart';
import 'package:lunch_vote/model/group/user_manage.dart';
import 'package:lunch_vote/provider/lunch_vote_service.dart';
import 'package:lunch_vote/repository/group_repository.dart';
import 'package:lunch_vote/repository/home_repository.dart';

import '../utils/shared_pref_manager.dart';

class GroupController extends GetxController {
  final GroupRepository repository;

  final dio = Dio();
  late LunchVoteService _lunchVoteService;
  final SharedPrefManager _spfManager = SharedPrefManager();

  GroupController({required this.repository});

  final Rx<GroupInfo> _groupInfo = GroupInfo(groupId: '', members: []).obs;
  GroupInfo get groupInfo => _groupInfo.value;
  final Rx<MemberInfo> _myProfileInfo = MemberInfo(email: '', nickname: '', profileImage: '').obs;
  MemberInfo get myProfileInfo => _myProfileInfo.value;

  final _members = [].obs;
  List get members => _members;
  final _allReady = false.obs;
  bool get isAllReady => _allReady.value;

  createGroup() {
    repository.createGroup().then((res) {
      _groupInfo.value = res.data;
    });
  }

  getGroupInfo(String groupId) {
    repository.getGroupInfo(groupId).then((res) {
      _groupInfo.value = res.data;
    });
  }

  inviteUser(String groupId, String email) {
    repository.inviteUser(groupId, email).then((res) {
      return res.message;
    });
  }

  getMyProfile(){
    repository.getMyProfile().then((res) {
      _myProfileInfo.value = MemberInfo(email: res.data.email, nickname: res.data.nickname, profileImage: res.data.profileImage,);
    });
  }

  withdrawalUser(String groupId){
    repository.withdrawalUser(groupId).then((res) {
      return res.message;
    });
  }

  setGroupId(String groupId) {
    _groupInfo.value = GroupInfo(groupId: groupId, members: _groupInfo.value.members);
  }

  add(MemberInfo member) {
    _members.add(Member(isReady: _members.isEmpty, memberInfo: member));
  }

  // TODO: 사용자 정보 받을 때 준비 완료 여부도 받기
  set(List<MemberInfo> member) {
    _members.clear();
    for (int i = 0; i < member.length; i++) {
      _members.add(Member(isReady: _members.isEmpty, memberInfo: member[i]));
    }
  }

  remove(int memberIdx) {
    _members.removeAt(memberIdx);
  }

  changeMemberIsReady(int memberIdx) {
    _members[memberIdx].isReady = !_members[memberIdx].isReady;
    checkReady();
  }

  checkReady() {
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