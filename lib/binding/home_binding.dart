import 'package:get/get.dart';
import 'package:lunch_vote/controller/home_controller.dart';
import 'package:lunch_vote/controller/nickname_controller.dart';
import 'package:lunch_vote/provider/lunch_vote_service_provider.dart';
import 'package:lunch_vote/repository/home_repository.dart';

class HomeBinding extends Bindings{
  @override
  void dependencies() {
    Get.put(HomeController(
        repository: HomeRepository(
            lunchVoteService: LunchVoteServiceProvider.getInstance()),
        nicknameController: Get.put(NicknameController())
      )
    );
  }
}