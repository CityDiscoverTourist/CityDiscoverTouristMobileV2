import 'dart:convert';

import 'package:easy_localization/easy_localization.dart';
import 'package:geolocator/geolocator.dart';
import 'package:travel_hour/models/purchased_quest.dart';
import 'package:travel_hour/models/questItem.dart';
import 'package:http/http.dart' as http;

import '../api/api.dart';
import '../api/api_end_points.dart';
class PurchasedService {
  static var client = http.Client();
  static Future<List<PurchasedQuest>?> fetchPurchasedQuests(String customerId,int language,String jwt) async {
    // WelcomeController homeController = Get.find<WelcomeController>();
    print(customerId+"+");
    var response = await http.get(
        Uri.parse('https://citytourist.azurewebsites.net/api/v1/payments?Status=Success&CustomerId=${customerId}&language=${language.toString()}'),
        headers: {
          "Accept": "application/json",
          "content-type": "application/json",
          //  'Authorization': 'Bearer ' + jwt
        });
    print("fetchPurchasedQuests Status_code: " '${response.statusCode}');
    // if (response.statusCode == 200) {
    Map data = jsonDecode(response.body);
    // Iterable list = dbc;
    Iterable list = data['data'];
    final bookingsAccept = list.cast<Map<String, dynamic>>();
    final listOfBookings_Accept = await bookingsAccept.map<PurchasedQuest>((json) {
      return PurchasedQuest.fromJson(json);
    }).toList();
    // print('object');
    return listOfBookings_Accept;
    // }
  }
}