import 'package:get/get.dart';

class NicknameController extends GetxController{
  final RxString _nickname = ''.obs;
  String get nickname => _nickname.value;

  void setNickname(String name){
    _nickname.value = name;
  }
}