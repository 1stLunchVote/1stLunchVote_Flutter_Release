import 'package:get/get.dart';

class FriendsController extends GetxController{
  final RxList<String> _friendList = <String>[].obs;
  List<String> get friendList => _friendList;
  final RxString _email = ''.obs;
  String get email => _email.value;

  void setFriendList(List<String> friendArray){
    _friendList.value = friendArray;
  }

  void setEmail(String mail){
    _email.value = mail;
  }

  void addFriend(String email) {
    friendList.add(email);
    //TODO 위의 email이란 변수 대신 서버로부터 해당 유저의 이름이 받아지게 하기
  }

  void deleteFriend(String name){
    friendList.remove(name);
  }

  void test(){
    print(friendList);
  }

}