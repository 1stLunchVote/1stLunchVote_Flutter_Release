import 'package:get/get.dart';
import 'package:lunch_vote/binding/home_binding.dart';
import 'package:lunch_vote/binding/login_binding.dart';
import 'package:lunch_vote/binding/profile_binding.dart';
import 'package:lunch_vote/binding/second_vote_binding.dart';
import 'package:lunch_vote/view/screen/home_screen.dart';
import 'package:lunch_vote/view/screen/login/login_screen.dart';
import 'package:lunch_vote/view/screen/profile_screen.dart';
import 'package:lunch_vote/view/screen/vote/result_screen.dart';
import 'package:lunch_vote/view/screen/vote/second_vote_screen.dart';
part './app_routes.dart';

class AppPages{
  static final pages = [
    GetPage(name: Routes.login, page: () => const LoginScreen(), binding: LoginBinding()),
    GetPage(name: Routes.home, page: () => const HomeScreen(), binding: HomeBinding()),
    // Todo : ToNamed 사용시 인자 붙이도록 변경해주세요! (ex. GroupScreen, FirstVoteScreen)
    GetPage(name: Routes.profile, page: () => const ProfileScreen(), binding: ProfileBinding()),
    GetPage(name: Routes.secondVote, page: () => const SecondVoteScreen(), binding: SecondVoteBinding()),
    GetPage(name: Routes.result, page: ()=> const ResultScreen(groupId: "63e2020dafdd6d981a88f547"))
  ];
}