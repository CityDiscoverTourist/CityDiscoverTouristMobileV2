import 'dart:convert';

import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:travel_hour/models/customer_quest.dart';

import '../models/quest.dart';

class CustomerQuestService {
  static var client = http.Client();
  static Future<List<CustomerQuest>?> fetchQuestFeatureData() async {
    // WelcomeController homeController = Get.find<WelcomeController>();
    // var response = await http.get(
    //     Uri.parse('https://citytourist.azurewebsites.net/api/v1/quests'),
    //     headers: {
    //       "Accept": "application/json",
    //       "content-type": "application/json"
    //     });
    // print("API SCHEDULE Status_code: " '${response.statusCode}');
    // if (response.statusCode == 200) {
    // Map data = jsonDecode(response.body);
    // Iterable list = dbc;
    // Iterable list = data['data'];
    // Iterable list = json.decode(jsonString);
    Iterable list = [
      {
        "id": 3,
        "beginPoint": "1000",
        "endPoint": null,
        "createdDate": null,
        "rating": 10,
        "feedBack": "ok",
        "customerId": "zxc",
        "isFinished": false,
        "questId": 9,
        "status": null,
        "paymentMethod": null
      },
      {
        "id": 4,
        "beginPoint": "1000",
        "endPoint": null,
        "createdDate": null,
        "rating": 10,
        "feedBack": "ok",
        "customerId": "1d9f265d-fd25-44de-ab64-14fcc1719e02",
        "isFinished": false,
        "questId": 9,
        "status": null,
        "paymentMethod": null
      }
    ];
    final bookingsAccept = list.cast<Map<String, dynamic>>();
    final listCustomerQuest = await bookingsAccept.map<CustomerQuest>((json) {
      return CustomerQuest.fromJson(json);
    }).toList();
    // print('object');
    return listCustomerQuest;
    // }
  }
}
