import 'package:get/get.dart';
import 'package:lunch_vote/controller/login_controller.dart';
import 'package:lunch_vote/controller/nickname_controller.dart';
import 'package:lunch_vote/provider/lunch_vote_service_provider.dart';
import 'package:lunch_vote/repository/login_repository.dart';

import '../utils/shared_pref_manager.dart';

class LoginBinding implements Bindings{
  @override
  void dependencies() {
    Get.put(LoginController(
      repository: LoginRepository(
          lunchVoteService: LunchVoteServiceProvider.getLoginInstance())
    ));
    Get.lazyPut(() => SharedPrefManager());
  }
}