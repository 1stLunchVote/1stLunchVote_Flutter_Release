import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:lunch_vote/controller/home_controller.dart';
import 'package:lunch_vote/repository/home_repository.dart';
import 'package:lunch_vote/source/user_remote_data_source.dart';

class HomeBinding extends Bindings{
  @override
  void dependencies() {
    Get.put(HomeController(
        HomeRepository(UserRemoteDataSource.instance)
      )
    );
  }
}