import 'package:flutter/material.dart';
import 'package:lunch_vote/model/menu/menu_info.dart';
import 'package:lunch_vote/model/template/all_template_info.dart';

class TemplateNotifier extends ChangeNotifier {
  String _templateId = "";
  String _templateName = "";
  final List<MenuStatus> _menus = [];

  void setTemplateId(String id) {
    _templateId = id;
  }

  void setTemplateName(String name) {
    _templateName = name;
  }

  void addList(MenuInfo menuInfo) {
    _menus.add(MenuStatus(menuInfo: menuInfo, status: 0,));
    notifyListeners();
  }

  void addListWithStatus(Menu menu) {
    int status = -1;
    if (menu.likesAndDislikes == "NORMAL") {
      status = 0;
    } else if (menu.likesAndDislikes == "LIKES") {
      status = 1;
    } else {
      status = 2;
    }
    _menus.add(MenuStatus(menuInfo: MenuInfo(
      menuId: menu.menuId,
      menuName: menu.menuName,
      image: menu.image,
    ), status: status,));
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

  String get templateId => _templateId;
  String get templateName => _templateName;
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

  double getWidth(int menuIdx){
    if (_menus[menuIdx].status == 0) {
      return 1.0;
    } else if (_menus[menuIdx].status == 1) {
      return 2.0;
    } else {
      return 2.0;
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