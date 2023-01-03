import 'dart:collection';

import 'package:flutter/cupertino.dart';

import 'group_info.dart';

class GroupNotifier extends ChangeNotifier {
  late String _groupId = "";
  final List<MemberInfo> _members = [];

  bool _isEnabled = false;

  bool get isEnabled => _isEnabled;
  void setEnable() {
    _isEnabled = !_isEnabled;
    notifyListeners();
  }

  UnmodifiableListView<MemberInfo> get members => UnmodifiableListView(_members);
  String getMemberNickname(int memberIdx) {
    if (_members.length < memberIdx + 1) {
      return '참가자';
    } else {
      return _members[memberIdx].nickname;
    }
  }
  String getMemberProfileImage(int memberIdx) {
    if (_members.length < memberIdx + 1) {
      return "null";
    } else {
      return _members[memberIdx].profileImage;
    }
  }

  int get length => _members.length;
  String get groupId => _groupId;

  void setGroupId(String groupId) {
    _groupId = groupId;
  }

  void add(MemberInfo member) {
    _members.add(member);
    notifyListeners();
  }

  void set(List<MemberInfo> members) {
    _members.clear();
    for (int i = 0; i < members.length; i++) {
      _members.add(members[i]);
    }
    notifyListeners();
  }

  void remove(int memberIdx) {
    _members.removeAt(memberIdx);
    notifyListeners();
  }
}