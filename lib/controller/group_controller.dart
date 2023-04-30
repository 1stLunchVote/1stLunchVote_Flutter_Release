import 'package:get/get.dart';
import 'package:lunch_vote/model/group/group_info.dart';
import 'package:lunch_vote/repository/group_repository.dart';

class GroupController extends GetxController {
  final GroupRepository repository;
  GroupController({required this.repository});

  final Rx<GroupInfo> _groupInfo = GroupInfo(groupId: '', members: []).obs;
  GroupInfo get groupInfo => _groupInfo.value;
  final Rx<MemberInfo> _myProfileInfo = MemberInfo(email: '', nickname: '', profileImage: '').obs;
  MemberInfo get myProfileInfo => _myProfileInfo.value;
  final Rx<bool> _isGroupCreated = false.obs;
  bool get isGroupCreated => _isGroupCreated.value;
  final Rx<bool> _allReady = false.obs;
  bool get isAllReady => _allReady.value;

  final _members = [].obs;
  List get members => _members;

  // 방장이 새로 그룹을 생성하는 메서드
  createGroup() async {
    try {
      var group = await repository.createGroup();
      _groupInfo.value = group.data;

      var myProfile = await repository.getMyProfile();
      _myProfileInfo.value = MemberInfo(email: myProfile.data.email, nickname: myProfile.data.nickname, profileImage: myProfile.data.profileImage);
      _members.add(Member(isReady: true, memberInfo: myProfileInfo));
    } catch (e) {
      return false;
    }
    _isGroupCreated.value = true;
    return true;
  }

  // 이미 있는 그룹에 참여하는 메서드
  joinGroup(String groupId) async {
    try {
      var group = await repository.getGroupInfo(groupId);
      _groupInfo.value = group.data;

      for (var member in groupInfo.members) {
        _members.add(Member(isReady: members.isEmpty, memberInfo: member));
      }
    } catch (e) {
      return false;
    }
    _isGroupCreated.value = true;
    return true;
  }

  // 주기적으로 그룹 정보를 받아오는 메서드
  getGroupInfo() async {
    try {
      var group = await repository.getGroupInfo(groupInfo.groupId);
      _groupInfo.value = group.data;

      _members.clear();
      for (var member in groupInfo.members) {
        _members.add(Member(isReady: members.isEmpty, memberInfo: member));
      }
    } catch (e) {
      return false;
    }
    return true;
  }

  // 새로운 유저를 초대하는 메서드
  inviteUser(String email) async {
    var res = await repository.inviteUser(_groupInfo.value.groupId, email);
    return res.message;
  }

  // 방을 나가는 메서드
  withdrawalUser() async {
    var res = await repository.withdrawalUser(_groupInfo.value.groupId);
    return res.message;
  }

  // 멤버가 전부 좋아요를 눌렀는지 확인하는 메서드
  checkReady() {
    _allReady.value = _members.every((member) => member.isReady);
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