import 'package:get/get.dart';
import 'package:lunch_vote/controller/group_controller.dart';
import 'package:lunch_vote/provider/lunch_vote_service_provider.dart';
import 'package:lunch_vote/repository/group_repository.dart';

class GroupBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(GroupController(
        repository: GroupRepository(
          lunchVoteService: LunchVoteServiceProvider.getInstance(),
        ),
    ));
  }
}