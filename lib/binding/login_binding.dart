import 'package:get/get.dart';
import 'package:lunch_vote/controller/login_controller.dart';

class LoginBinding implements Bindings{
  @override
  void dependencies() {
    // https://mugon-devlog.tistory.com/74
    // Get.lazyPut<LoginController>(() => )
  }
}