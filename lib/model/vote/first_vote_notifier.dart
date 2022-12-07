import 'package:flutter/material.dart';
import '../menu/menu_info.dart';

class FirstVoteNotifier extends ChangeNotifier {
  final List<MenuStatus> _menus = [];
  bool _isLoading = false;

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

  bool get isLoading => _isLoading;

  bool get visibility {
    if (_isLoading) {
      return false;
    }
    List<String> likesMenu = getLikeMenu();
    List<String> dislikesMenu = getDislikeMenu();
    for (int i = 0; i < _menus.length; i++) {
      if (likesMenu.isNotEmpty && dislikesMenu.isNotEmpty) {
        return true;
      }
    }
    return false;
  }

  void startLoading() {
    _isLoading = true;
    notifyListeners();
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