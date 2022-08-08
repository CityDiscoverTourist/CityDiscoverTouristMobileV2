// import 'package:citydiscovertourist/models/customer.dart';
// import 'package:citydiscovertourist/screen/welcome/welcome_Screen.dart';
// import 'package:citydiscovertourist/screen/profile/profile.dart';
// import 'package:dio/dio.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:travel_hour/controllers/home_controller.dart';
import 'package:travel_hour/controllers/login_controller_V2.dart';
import 'package:travel_hour/models/purchased_quest.dart';
import 'package:travel_hour/models/quest.dart';
import 'package:travel_hour/models/reward.dart';
import 'package:travel_hour/pages/home.dart';
import 'package:travel_hour/services/purchased_service.dart';
import 'dart:convert';
// import 'package:citydiscovertourist/api/api.dart';
// import 'package:citydiscovertourist/api/api_end_points.dart';

import '../api/api.dart';
import '../api/api_end_points.dart';
import '../models/customer.dart';
import '../pages/profile.dart';
import '../pages/sign_in.dart';
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
        print('Co Roi Ne');
        rewardsList.assignAll(listReward);
      }
    } finally {
      isLoading(false);
    }
  }
}
