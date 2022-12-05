import 'package:flutter/material.dart';

class VoteItemNotifier extends ChangeNotifier{
  int _index = -1;
  int get index => _index;

  void setIndex(int idx){
    _index = idx;
    notifyListeners();
  }

  void clearIndex(){
    _index = -1;
    notifyListeners();
  }
}