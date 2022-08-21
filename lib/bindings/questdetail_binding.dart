import 'package:get/get.dart';
import 'package:travel_hour/controllers/questdetail_controller.dart';


class QuestDetailBinding implements Bindings {
  @override
  void dependencies() {
    Get.put(QuestDetailController());
  }
}
