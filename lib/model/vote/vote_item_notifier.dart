import 'package:flutter/material.dart';
import 'package:lunch_vote/model/menu/menu_info.dart';

class VoteItemNotifier extends ChangeNotifier{

  int _index = -1;
  int get index => _index;

  String _menuId = '';
  String get menuId => _menuId;

  int _checkTouch = 0;
  int get checkTouch => _checkTouch;

  void pushPreMenu(int index, String menuId){
    hateMenu[index] = '';
    preferMenu[index] = menuId;
    for(int i=0;i<preferMenu.length;i++){
      print(preferMenu[i]);
    }
    notifyListeners();
  }
  
  void pushHateMenu(int index, String menuId){
    preferMenu[index] = '';
    hateMenu[index] = menuId;
    notifyListeners();
  }

  void popMenu(int index){
    preferMenu.removeAt(index);
    hateMenu.removeAt(index);
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

  void updateMenu(){
    notifyListeners();
  }

}
