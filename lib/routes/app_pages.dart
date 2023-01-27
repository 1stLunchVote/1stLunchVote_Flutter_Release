import 'package:get/get.dart';
import 'package:lunch_vote/binding/home_binding.dart';
import 'package:lunch_vote/view/screen/home_screen.dart';
import 'package:lunch_vote/view/screen/login_screen.dart';
import 'package:lunch_vote/view/screen/profile_screen.dart';
import 'package:lunch_vote/view/screen/vote/first_vote_screen.dart';
part './app_routes.dart';

class AppPages{
  static final pages = [
    GetPage(name: Routes.login, page: () => const LoginScreen()),
    GetPage(name: Routes.home, page: () => const HomeScreen(), binding: HomeBinding()),
    // Todo : ToNamed 사용시 인자 붙이도록 변경해주세요! (ex. GroupScreen, FirstVoteScreen)
    GetPage(name: Routes.profile, page: () => const ProfileScreen())
  ];
}