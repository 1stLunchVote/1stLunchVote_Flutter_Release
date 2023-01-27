import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:get/get.dart';
import 'package:lunch_vote/controller/nickname_controller.dart';
import 'package:lunch_vote/repository/home_repository.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';

import '../view/screen/group/group_screen.dart';


class HomeController extends GetxController{
  final HomeRepository repository;
  final NicknameController nicknameController;
  String get nickname => nicknameController.nickname;
  HomeController({required this.repository, required this.nicknameController});

  getNickname(){
    repository.getNickname().then((value) {
        nicknameController.setNickname(value.data.nickname);
        FlutterNativeSplash.remove();
      }, onError: (e) => FlutterNativeSplash.remove()
    );
  }

  joinGroup(String groupId){
    // Todo : toNamed로 바꾸기
    repository.joinGroup(groupId).then((value) =>
        Get.to(() => GroupScreen(isLeader: false, groupId: groupId))
    );
  }

}