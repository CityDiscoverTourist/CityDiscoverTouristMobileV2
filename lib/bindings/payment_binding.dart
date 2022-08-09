import 'package:get/get.dart';
import 'package:travel_hour/controllers/questpurchased_controller.dart';
import 'package:travel_hour/controllers/login_controller_V2.dart';
import 'package:travel_hour/controllers/login_controller.dart';
import 'package:travel_hour/controllers/payment_controller.dart';
import 'package:travel_hour/controllers/questdetail_controller.dart';
import 'package:travel_hour/controllers/voucher_controller.dart';
import 'package:travel_hour/models/quest_detail.dart';


class PaymentBinding implements Bindings {
  @override
  void dependencies() {
    Get.put(PaymentController());
    Get.put(RewardController());
  }
}
