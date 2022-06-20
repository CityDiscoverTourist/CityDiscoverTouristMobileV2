import 'dart:convert';

import 'package:geolocator/geolocator.dart';
import 'package:travel_hour/models/questItem.dart';
import 'package:http/http.dart' as http;

import '../api/api.dart';
import '../api/api_end_points.dart';

class PlayService {
  static Future<List<QuestItem>?> fetchTestData() async {
    Iterable list = [
      {"id": 1, "name": "Quest1", "ans": "A"},
      {"id": 2, "name": "Quest2", "ans": "A"},
      {"id": 3, "name": "Quest3", "ans": "A"}
    ];
    final qItemMap = list.cast<Map<String, dynamic>>();
    final questItemList = await qItemMap.map<QuestItem>((json) {
      return QuestItem.fromJson(json);
    }).toList();
    // print('object');
    return questItemList;
    // }
  }

  //Cái này chưa xài đc tại trang api đang lỗi
  static Future<List<QuestItem>?> fetchTestData2(String questId) async {
    var response = await http.get(
        Uri.parse(Api.baseUrl + ApiEndPoints.checkAnswer + questId),
        headers: {"Content-Type": "application/json"});
    if (response.statusCode == 200) {
      final responseData = json.decode(response.body);
      final questItemList = await questItemFromJson(responseData['data']);
      // print('object');
      return questItemList;
    }
    return null;
  }

  Future<QuestItem> fetchDataQuestItem() {
    QuestItem? questItem;
    return Future<QuestItem>.value(questItem);
  }

  // Future<bool> checkAnswer() {
  //   return Future<bool>.value(false);
  // }

  Future<bool> checkAnswer(
      String customerQuestId, String customerReply, String questItemId) async {
    var response = await http.get(
        Uri.parse(Api.baseUrl +
            ApiEndPoints.checkAnswer +
            customerQuestId +
            "?customerReply=" +
            customerReply +
            "&questItemId=" +
            questItemId),
        headers: {"Content-Type": "application/json"});

    if (response.statusCode == 200) {
      // print("OKkkkkkkkkkkkkkkkkkkkkk");
      // var data = json.decode(response.body);
      // print(data);
      return Future<bool>.value(true);
    }
    return Future<bool>.value(false);
  }

  // Future<bool> checkLocation() {
  //   return Future<bool>.value(false);
  // }

  final GeolocatorPlatform _geolocatorPlatform = GeolocatorPlatform.instance;
  Future<bool> _handlePermission() async {
    bool serviceEnabled;
    LocationPermission permission;

    // Test if location services are enabled.
    serviceEnabled = await _geolocatorPlatform.isLocationServiceEnabled();
    if (!serviceEnabled) {
      // Location services are not enabled don't continue
      // accessing the position and request users of the
      // App to enable the location services.

      return false;
    }

    permission = await _geolocatorPlatform.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await _geolocatorPlatform.requestPermission();
      if (permission == LocationPermission.denied) {
        // Permissions are denied, next time you could try
        // requesting permissions again (this is also where
        // Android's shouldShowRequestPermissionRationale
        // returned true. According to Android guidelines
        // your App should show an explanatory UI now.

        return false;
      }
    }

    if (permission == LocationPermission.deniedForever) {
      // Permissions are denied forever, handle appropriately.
      return false;
    }

    // When we reach here, permissions are granted and we can
    // continue accessing the position of the device.
    return true;
  }

  Future<Position?> getCurrentPosition() async {
    final hasPermission = await _handlePermission();
    if (!hasPermission) {
      return null;
    }
    final position = await _geolocatorPlatform.getCurrentPosition();
    return position;
  }

  Future<bool> checkLocation(String questID) async {
    Position? pos = await getCurrentPosition();
    var lat = pos?.latitude.toString();
    var long = pos?.longitude.toString();
    var response = await http.get(
        Uri.parse(Api.baseUrl +
                ApiEndPoints.checkUserLocationQuest +
                questID +
                //Cái này để tạm latlong cứng để trả về true
                "?latitude=10.7801203" +
                // lat! +
                "&longitude=106.6995542"
            // +
            // long!
            ),
        headers: {"Content-Type": "application/json"});

    if (response.statusCode == 200) {
      // print("OKkkkkkkkkkkkkkkkkkkkkk");
      // var data = json.decode(response.body);
      // print(data);
      return Future<bool>.value(true);
    }
    return Future<bool>.value(false);
  }

  Future<bool> checkLocationWithQuestItem(String questItemID) async {
    Position? pos = await getCurrentPosition();
    var lat = pos?.latitude.toString();
    var long = pos?.longitude.toString();
    var response = await http.get(
        Uri.parse(Api.baseUrl +
                ApiEndPoints.checkUserLocationQuestItem +
                questItemID +
                //Cái này để tạm latlong cứng để trả về true
                "?latitude=10.7801203" +
                // lat! +
                "&longitude=106.6995542"
            // +
            // long!
            ),
        headers: {"Content-Type": "application/json"});

    if (response.statusCode == 200) {
      // print("OKkkkkkkkkkkkkkkkkkkkkk");
      return Future<bool>.value(true);
    }
    return Future<bool>.value(false);
  }

  Future<String> getSuggestion(String questItemId) async {
    var response = await http.get(
        Uri.parse(Api.baseUrl + ApiEndPoints.getSuggestion + questItemId),
        headers: {"Content-Type": "application/json"});
    print(Api.baseUrl + ApiEndPoints.getSuggestion + questItemId);
    if (response.statusCode == 200) {
      // print("OKkkkkkkkkkkkkkkkkkkkkk");
      var data = json.decode(response.body);
      print(data);
      return Future<String>.value(data);
    }
    return Future<String>.value(null);
  }

  Future<void> decreasePointSuggestion(String customerQuestId) async {
    var response = await http.put(
        Uri.parse(Api.baseUrl +
            ApiEndPoints.decreasePointSuggestion +
            customerQuestId),
        headers: {"Content-Type": "application/json"});

    if (response.statusCode == 200) {
      print("OKkkkkkkkkkkkkkkkkkkkkk");
      // var data = json.decode(response.body);
      // print(data);
      // return Future<bool>.value(true);
    }
    print("Failed");
    // return Future<bool>.value(false);
  }
}
