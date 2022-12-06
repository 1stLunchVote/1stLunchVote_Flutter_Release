import 'package:flutter/material.dart';

import 'package:lunch_vote/model/menu/menu_info.dart';

class VoteItemNotifier extends ChangeNotifier{
  int _index = -1;
  int get index => _index;

  String _menuId = '';
  String get menuId => _menuId;

  int _checkTouch = 0;
  int get checkTouch => _checkTouch;

  List<MenuInfo> selectedMenu = [];

  void pushMenu(int index, MenuInfo menuInfo){
    selectedMenu.add(menuInfo);
    notifyListeners();
  }

  void popMenu(int index){
    selectedMenu.removeAt(index);
    notifyListeners();
  }

  void setIndex(int idx, String menuId){
    _index = idx;
    _menuId = menuId;
    notifyListeners();
  }

  void clearIndex(){
    _index = -1;
    _menuId = '';
    notifyListeners();
  }

  void getselectedMenu(){
    notifyListeners();

  }

}