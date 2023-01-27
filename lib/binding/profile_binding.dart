import 'package:get/get.dart';
import 'package:lunch_vote/controller/nickname_controller.dart';
import 'package:lunch_vote/controller/profile_controller.dart';
import 'package:lunch_vote/provider/lunch_vote_service_provider.dart';
import 'package:lunch_vote/repository/profile_repository.dart';
import 'package:lunch_vote/utils/shared_pref_manager.dart';

class ProfileBinding extends Bindings{
  @override
  void dependencies() {
    Get.put(ProfileController(
      repository: ProfileRepository(
          lunchVoteService: LunchVoteServiceProvider.getInstance()
      ),
      nicknameController: Get.find<NicknameController>()
    ));
    Get.lazyPut(() => SharedPrefManager());
  }
}