import 'package:get/get.dart';
import 'package:travel_hour/controllers/payment_controller.dart';
import 'package:travel_hour/controllers/voucher_controller.dart';


class PaymentBinding implements Bindings {
  @override
  void dependencies() {
    Get.put(PaymentController());
    Get.put(RewardController());
  }
}
