import 'package:flutter/material.dart';
import 'package:lunch_vote/model/template/all_template_info.dart';
import '../menu/menu_info.dart';

class FirstVoteNotifier extends ChangeNotifier {
  final List<MenuStatus> _allMenus = [];
  final List<MenuStatus> _menus = [];
  bool _isLoading = false;

  void addList(MenuInfo menuInfo) {
    _menus.add(MenuStatus(menuInfo: menuInfo, status: 0,));
    _allMenus.add(MenuStatus(menuInfo: menuInfo, status: 0,));
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

    _allMenus.add(MenuStatus(menuInfo: MenuInfo(
      menuId: menu.menuId,
      menuName: menu.menuName,
      image: menu.image,
    ), status: status,));
    notifyListeners();
  }

  void clearList() {
    _menus.clear();
    _allMenus.clear();
    notifyListeners();
  }

  void updateStatus(int menuIdx) {
    _menus[menuIdx].status = (_menus[menuIdx].status + 1) % 3;
    //_allMenus[menuIdx].status = (_allMenus[menuIdx].status + 1) % 3;
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
    return likesMenu.isNotEmpty && dislikesMenu.isNotEmpty;
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
    for (int i = 0; i < _allMenus.length; i++) {
      if (_allMenus[i].status == 1) {
        res.add(_allMenus[i].menuInfo.menuId);
      }
    }
    for (int i = 0; i < _menus.length; i++) {
      if (_menus[i].status == 1) {
        if (!res.contains(_menus[i].menuInfo.menuId)) {
          res.add(_menus[i].menuInfo.menuId);
        }
      }
    }
    return res;
  }

  List<String> getDislikeMenu() {
    List<String> res = [];
    for (int i = 0; i < _allMenus.length; i++) {
      if (_allMenus[i].status == 2) {
        res.add(_allMenus[i].menuInfo.menuId);
      }
    }
    for (int i = 0; i < _menus.length; i++) {
      if (_menus[i].status == 2) {
        if (!res.contains(_menus[i].menuInfo.menuId)) {
          res.add(_menus[i].menuInfo.menuId);
        }
      }
    }
    return res;
  }

  void resetTemplate() {
    for (int i = 0; i < _menus.length; i++) {
      _menus[i].status = 0;
    }
    for (int i = 0; i < _allMenus.length; i++) {
      _allMenus[i].status = 0;
    }
    notifyListeners();
  }

  void searchMenu(String text) {
    if (text.isEmpty) {
      _menus.clear();
      for (int i = 0; i < _allMenus.length; i++) {
        _menus.add(_allMenus[i]);
      }
    } else {
      _menus.clear();
      for (int i = 0; i < _allMenus.length; i++) {
        if (_allMenus[i].menuInfo.menuName.contains(text)) {
          _menus.add(_allMenus[i]);
        }
      }
    }
    notifyListeners();
  }
}

class MenuStatus {
  final MenuInfo menuInfo;
  int status;

  MenuStatus({required this.menuInfo, required this.status});
}