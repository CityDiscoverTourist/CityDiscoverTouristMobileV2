// import 'package:citydiscovertourist/models/customer.dart';
// import 'package:citydiscovertourist/screen/welcome/welcome_Screen.dart';
// import 'package:citydiscovertourist/screen/profile/profile.dart';
// import 'package:dio/dio.dart';
import 'package:get/get.dart';
import 'package:travel_hour/controllers/login_controller_V2.dart';
import 'package:travel_hour/models/reward.dart';

import '../services/reward_service.dart';
// import '../screen/login/login_screen.dart';

// import 'package:shared_preferences/shared_preferences.dart';

class RewardController extends GetxController {
  List rewardsList = List<Reward>.empty().obs;
  var isLoading = false.obs;
  void onInit() async {
    super.onInit();
    await fetchRewardByCustomerId(Get.find<LoginControllerV2>().sp.id);
  }

  void onReady() {
    update();
  }

  fetchRewardByCustomerId(String customerId) async {
    try {
      isLoading(true);
    var listReward=  await RewardService.fetchRewardByCustomerId(customerId);
      if (listReward != null) {
        rewardsList.assignAll(listReward);
      }
    } finally {
      isLoading(false);
    }
  }
}
