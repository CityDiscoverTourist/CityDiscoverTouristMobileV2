import 'dart:convert';

import 'package:get/get.dart';
import 'package:http/http.dart' as http;

import '../models/city.dart';



class CityService {
 
  static var client = http.Client();
  static Future<List<City>?> fetchCityData() async {
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
       Iterable list =
[
    {
      "id": 1,
      "name": "Hồ Chí Minh",
      "status": "1"
    },
    {
      "id": 2,
      "name": "Hà Nội",
      "status": "2"
    },
    {
      "id": 3,
      "name": "Phú Quốc",
      "status": "string"
    },
    {
      "id": 4,
      "name": "Đà Lạt",
      "status": "string"
    }
  ];
      final cityMap = list.cast<Map<String, dynamic>>();
      final cityList = await cityMap.map<City>((json) {
        return City.fromJson(json);
      }).toList();
      // print('object');
      return cityList;
    // }
  }
}
