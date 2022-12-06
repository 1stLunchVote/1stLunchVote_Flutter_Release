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
}

class MenuStatus {
  final MenuInfo menuInfo;
  int status;

  MenuStatus({required this.menuInfo, required this.status});
}