import 'package:get/get.dart';
import 'package:travel_hour/controllers/questpurchased_controller.dart';
import 'package:travel_hour/controllers/login_controller_V2.dart';
import 'package:travel_hour/controllers/login_controller.dart';


class PurchasedBinding implements Bindings {
  @override
  void dependencies() {
    // Get.put(() => LoginController(), permanent: true);
    Get.put( QuestPurchasedController());
  }
}
