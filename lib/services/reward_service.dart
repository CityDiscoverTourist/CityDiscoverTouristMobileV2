import 'dart:convert';

import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:travel_hour/controllers/home_controller.dart';
import 'package:travel_hour/models/reward.dart';

import '../api/api.dart';
import '../api/api_end_points.dart';
import '../controllers/login_controller_V2.dart';
import '../models/quest.dart';

class RewardService {
  static Future<List<Reward>?> fetchRewardByCustomerId(
      String customerId) async {
    var myController = Get.find<LoginControllerV2>();
    var response = await http.get(
        Uri.parse(
            Api.baseUrl + ApiEndPoints.getRewardByCustomerId + customerId),
        headers: {
          "Content-Type": "application/json",
          'Authorization': 'Bearer ' + myController.jwtToken.value
        });
    // print(Api.baseUrl + ApiEndPoints.getSuggestion + customerId);
    if (response.statusCode == 200) {
      List<Reward> listReward = new List.empty(growable: true);
      // print("OKkkkkkkkkkkkkkkkkkkkkk");
      // var data = json.decode(response.body);
      Map<String, dynamic> map = json.decode(response.body);
      List<dynamic> data = map["data"];
      for (var element in data) {
        if (element["status"] == "Active") {
          Reward reward = Reward.fromJson(element);
          // print(reward.receivedDate);
          listReward.add(reward);
        }
      }

      Get.find<HomeController>().rewardList.value = listReward;
      return Future<List<Reward>>.value(listReward);
    }
    return Future<List<Reward>>.value(null);
  }
}
