import 'package:get/get.dart';

class NicknameController extends GetxController{
  var nickname = ''.obs;

  void setNickname(String name){
    nickname.value = name;
  }
}