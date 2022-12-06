import 'package:flutter/material.dart';

class VoteItemNotifier extends ChangeNotifier{
  int _index = -1;
  int get index => _index;

  String _menuId = '';
  String get menuId => _menuId;

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
}