import 'dart:convert';

import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:travel_hour/controllers/home_controller.dart';
import 'package:travel_hour/controllers/login_controller_V2.dart';

import '../models/city.dart';

class CityService {
  static var client = http.Client();
  Future<List<City>?> fetchCityData() async {
    
    var response = await http.get(
        Uri.parse('https://citytourist.azurewebsites.net/api/v1/areas' +
            "?language=" +
            Get.find<LoginControllerV2>().language.value.toString()),
        headers: {
          "Accept": "application/json",
          "content-type": "application/json",
          'Authorization':
              'Bearer ' + Get.find<LoginControllerV2>().jwtToken.value
        });
    Map data = jsonDecode(response.body);
    Iterable list = data['data'];
    final cityMap = list.cast<Map<String, dynamic>>();
    final cityList = await cityMap.map<City>((json) {
      return City.fromJson(json);
    }).toList();
    return cityList;
    // }
  }
}
