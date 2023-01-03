import 'dart:collection';

import 'package:flutter/material.dart';

import 'group_info.dart';

class GroupNotifier extends ChangeNotifier {
  late String _groupId = "";
  final List<Member> _members = [];
  bool _allReady = false;

  UnmodifiableListView<Member> get members => UnmodifiableListView(_members);
  int get length => _members.length;
  String get groupId => _groupId;
  bool get isAllReady => _allReady;

  void setGroupId(String groupId) {
    _groupId = groupId;
  }

  void add(MemberInfo member) {
    _members.add(Member(isReady: _members.isEmpty, memberInfo: member));
    notifyListeners();
  }

  // TODO: 사용자 정보 받을 때 준비 완료 여부도 받기
  void set(List<MemberInfo> members) {
    _members.clear();
    for (int i = 0; i < members.length; i++) {
      _members.add(Member(isReady: _members.isEmpty, memberInfo: members[i]));
    }
    notifyListeners();
  }

  void remove(int memberIdx) {
    _members.removeAt(memberIdx);
    notifyListeners();
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
    _allReady = cnt == 0;
    notifyListeners();
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