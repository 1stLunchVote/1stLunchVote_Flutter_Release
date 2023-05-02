import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:lunch_vote/repository/home_repository.dart';

class HomeController extends GetxController{
  final HomeRepository _repository;
  HomeController(this._repository);

  final FirebaseAuth _auth = FirebaseAuth.instance;

  final RxString _nickname = "".obs;
  String get nickname => _nickname.value;

  getNickname(){
    _repository.getUserNickName(_auth.currentUser?.uid).listen((event) {
      _nickname.value = event;
      print("name : ${event}, length : ${event.length}");
    }, onError: (e) {
      _nickname.value = "회원";
    });
  }

  // joinGroup(String groupId){
  //   // Todo : toNamed로 바꾸기
  //   repository.joinGroup(groupId).then((value) =>
  //       Get.to(() => GroupScreen(), arguments: {'groupId': groupId})
  //   );
  // }
  // getNickname(){
  //   repository.getNickname().then((value) {
  //       nicknameController.setNickname(value.data.nickname);
  //       FlutterNativeSplash.remove();
  //     }, onError: (e) => FlutterNativeSplash.remove()
  //   );
  // }
}