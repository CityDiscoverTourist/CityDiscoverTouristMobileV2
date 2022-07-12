import 'dart:convert';

import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:travel_hour/controllers/login_controller_V2.dart';

import '../models/city.dart';



class CityService {
 
  static var client = http.Client();
   Future<List<City>?> fetchCityData() async {
    // var controller = Get.find<LoginControllerV2>();
    var response = await http.get(
        Uri.parse('https://citytourist.azurewebsites.net/api/v1/areas'),
        headers: {
          "Accept": "application/json",
          "content-type": "application/json",
           'Authorization': 'Bearer ' + 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJodHRwOi8vc2NoZW1hcy54bWxzb2FwLm9yZy93cy8yMDA1LzA1L2lkZW50aXR5L2NsYWltcy9uYW1lIjoiY3VvbmduaHRzZTE0MDgwNUBmcHQuZWR1LnZuIiwianRpIjoiMzQ0NzNkMDItNDliNi00NjI0LWI4NGYtODAxYzBiYzZhMGI0IiwiaHR0cDovL3NjaGVtYXMueG1sc29hcC5vcmcvd3MvMjAwNS8wNS9pZGVudGl0eS9jbGFpbXMvZW1haWxhZGRyZXNzIjoiY3VvbmduaHRzZTE0MDgwNUBmcHQuZWR1LnZuIiwiaHR0cDovL3NjaGVtYXMubWljcm9zb2Z0LmNvbS93cy8yMDA4LzA2L2lkZW50aXR5L2NsYWltcy9leHBpcmF0aW9uIjoiMDcvMTIvMjAyMiAxNDoyMzo0NyIsImV4cCI6MTY1NzYzNTgyNywiaXNzIjoiaHR0cHM6Ly9sb2NhbGhvc3Q6NzIxNSIsImF1ZCI6Imh0dHA6Ly9sb2NhbGhvc3Q6NTIxNSJ9.0paBqANcZyuovkGl2NfHC0RCTuBpytbXjIFkMcHy0nc'
        });
    print("API SCHEDULE Status_code: " '${response.statusCode}');
    // if (response.statusCode == 200) {
      Map data = jsonDecode(response.body);
      // Iterable list = dbc;
      Iterable list = data['data'];
      final cityMap = list.cast<Map<String, dynamic>>();
      final cityList = await cityMap.map<City>((json) {
        return City.fromJson(json);
      }).toList();
      // print('object');
      return cityList;
    // }
  }
}
