import 'package:get/get.dart';
import 'package:travel_hour/controllers/loadquest_controller.dart';


class QuestBinding implements Bindings {
  @override
  void dependencies() {
    Get.put(LoadQuestController());
  }
}
