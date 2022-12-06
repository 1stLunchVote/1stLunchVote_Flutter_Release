import 'package:flutter/material.dart';

class GroupIdNotifier extends ChangeNotifier {
  String _groupId = '';
  String get groupId => _groupId;

  void setIndex(String id){
    _groupId = id;
    print("provider id set : $id, _groupId : ${groupId.isNotEmpty}");
    notifyListeners();
  }

  void clearIndex(){
    _groupId = '';
    notifyListeners();
  }
}
