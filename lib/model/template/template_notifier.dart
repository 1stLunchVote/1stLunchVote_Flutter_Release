import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import '../menu/menu_info.dart';

class TemplateNotifier extends ChangeNotifier {
  final List<MenuStatus> _menus = [];

  void addList(MenuInfo menuInfo) {
    _menus.add(MenuStatus(menuInfo: menuInfo, status: 0,));
    notifyListeners();
  }

  void clearList() {
    _menus.clear();
    notifyListeners();
  }

  void updateStatus(int menuIdx) {
    _menus[menuIdx].status = (_menus[menuIdx].status + 1) % 3;
    notifyListeners();
  }

  int get length => _menus.length;

  bool get visibility {
    for (int i = 0; i < _menus.length; i++) {
      if (_menus[i].status != 0) {
        return true;
      }
    }
    return false;
  }

  String getName(int menuIdx) {
    return _menus[menuIdx].menuInfo.menuName;
  }

  String getImg(int menuIdx) {
    return _menus[menuIdx].menuInfo.image;
  }

  Color getColor(int menuIdx) {
    if (_menus[menuIdx].status == 0) {
      return Colors.black;
    } else if (_menus[menuIdx].status == 1) {
      return Colors.green;
    } else {
      return Colors.red;
    }
  }

  List<String> getLikeMenu() {
    List<String> res = [];
    for (int i = 0; i < _menus.length; i++) {
      if (_menus[i].status == 1) {
        res.add(_menus[i].menuInfo.menuId);
      }
    }
    return res;
  }

  List<String> getDislikeMenu() {
    List<String> res = [];
    for (int i = 0; i < _menus.length; i++) {
      if (_menus[i].status == 2) {
        res.add(_menus[i].menuInfo.menuId);
      }
    }
    return res;
  }
}

class MenuStatus {
  final MenuInfo menuInfo;
  int status;

  MenuStatus({required this.menuInfo, required this.status});
}