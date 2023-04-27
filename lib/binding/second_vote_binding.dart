import 'package:get/get.dart';
import 'package:lunch_vote/controller/nickname_controller.dart';
import 'package:lunch_vote/controller/second_vote_controller.dart';
import 'package:lunch_vote/provider/lunch_vote_service_provider.dart';
import 'package:lunch_vote/repository/second_vote_repository.dart';

class SecondVoteBinding extends Bindings{
  @override
  void dependencies() {
    Get.put(SecondVoteController(
        repository: Get.put(SecondVoteRepository(
            lunchVoteService: LunchVoteServiceProvider.getInstance())),
        nicknameController: Get.find<NicknameController>())
    );
  }
}