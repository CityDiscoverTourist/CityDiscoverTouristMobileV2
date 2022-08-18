import 'package:get/get.dart';
import 'package:travel_hour/controllers/questpurchased_controller.dart';


class PurchasedBinding implements Bindings {
  @override
  void dependencies() {
    // Get.put(() => LoginController(), permanent: true);
    Get.put( QuestPurchasedController());
  }
}
