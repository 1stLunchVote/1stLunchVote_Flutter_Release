import 'package:get/get.dart';
import 'package:lunch_vote/controller/template_controller.dart';
import 'package:lunch_vote/provider/lunch_vote_service_provider.dart';
import 'package:lunch_vote/repository/template_repository.dart';

class TemplateBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(TemplateController(
      repository: TemplateRepository(
        lunchVoteService: LunchVoteServiceProvider.getInstance(),
      ),
    ));
  }
}