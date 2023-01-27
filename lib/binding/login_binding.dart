import 'package:get/get.dart';

class LoginBinding implements Bindings{
  @override
  void dependencies() {
    // https://mugon-devlog.tistory.com/74
    // Get.lazyPut<LoginController>(() => LoginController )
  }
}