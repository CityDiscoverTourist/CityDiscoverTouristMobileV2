import 'dart:convert';
import 'dart:io';

import 'package:easy_localization/easy_localization.dart';
import 'package:geolocator/geolocator.dart';
import 'package:image_picker/image_picker.dart';
import 'package:travel_hour/models/questItem.dart';
import 'package:http/http.dart' as http;
import 'package:travel_hour/models/questItemV2.dart';

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
  static Future<List<QuestItem2>?> fetchQuestItemData(
      String questId, var language) async {
    var response = await http.get(
        Uri.parse(Api.baseUrl +
            ApiEndPoints.getQuestItemByQuestId +
            questId +
            "?language=" +
            language.toString()),
        headers: {
          "Content-Type": "application/json",
          'Authorization':
              'Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJodHRwOi8vc2NoZW1hcy54bWxzb2FwLm9yZy93cy8yMDA1LzA1L2lkZW50aXR5L2NsYWltcy9uYW1lIjoia2hhdGhpMjYwMTAwQGdtYWlsLmNvbSIsImp0aSI6IjYyMDQ5ODVlLTYxMTUtNDQzOC1hZDVlLTY1M2NjZDZmZDNkZSIsImh0dHA6Ly9zY2hlbWFzLnhtbHNvYXAub3JnL3dzLzIwMDUvMDUvaWRlbnRpdHkvY2xhaW1zL2VtYWlsYWRkcmVzcyI6ImtoYXRoaTI2MDEwMEBnbWFpbC5jb20iLCJodHRwOi8vc2NoZW1hcy5taWNyb3NvZnQuY29tL3dzLzIwMDgvMDYvaWRlbnRpdHkvY2xhaW1zL2V4cGlyYXRpb24iOiIwNy8xMi8yMDIyIDA0OjE3OjA3IiwiZXhwIjoxNjU3NTk5NDI3LCJpc3MiOiJodHRwczovL2xvY2FsaG9zdDo3MjE1IiwiYXVkIjoiaHR0cDovL2xvY2FsaG9zdDo1MjE1In0.EVdcvwUJbm5hhqg-RY21tItehRquGXtcnnQ_3C7Cr2U'
        });
    if (response.statusCode == 200) {
      List<QuestItem2> listQuest = new List.empty(growable: true);
      // final responseData = json.decode(response.body);
      print("Get Success");
      Map<String, dynamic> map = json.decode(response.body);
      List<dynamic> data = map["data"];
      for (var element in data) {
        // print(element.toString() + "/n");
        listQuest.add(QuestItem2.fromJson(element));
      }
      // for (var element in listQuest) {
      //   print(element.id);
      // }
      // print('object');
      return listQuest;
    }
    print("Get faild");
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
    var response = await http.put(
        Uri.parse(Api.baseUrl +
            ApiEndPoints.checkAnswer +
            customerQuestId +
            "?customerReply=" +
            customerReply +
            "&questItemId=" +
            questItemId),
        headers: {"Content-Type": "application/json"});
    // print(Api.baseUrl +
    //     ApiEndPoints.checkAnswer +
    //     customerQuestId +
    //     "?customerReply=" +
    //     customerReply +
    //     "&questItemId=" +
    //     questItemId);
    if (response.statusCode == 200) {
      // print("OKkkkkkkkkkkkkkkkkkkkkk");
      // var data = json.decode(response.body);
      // print(data);
      return Future<bool>.value(true);
    }
    return Future<bool>.value(false);
  }

  Future<List?> buyQuest(var id, String customerId, String questID,
      int quantity, var totalAmout, var discountCode) async {
    List returnData = new List.empty(growable: true);
    // var now = new DateTime.now();
    // var dateFormatted = DateFormat("yyyy-MM-ddTHH:mm:ss").format(now);
    // print(dateFormatted);
    Map mydata = {
      'id': id,
      'quantity': quantity,
      'totalAmount': totalAmout,
      'customerId': customerId,
      'isMobile': true,
      'questId': questID
    };
    var body = json.encode(mydata);
    String httpString = Api.baseUrl + ApiEndPoints.buyQuest;
    if (discountCode != null) {
      httpString = httpString + "?discountCode=" + discountCode;
    }
    var response = await http.post(Uri.parse(httpString),
        headers: {"Content-Type": "application/json"}, body: body);
    print(Api.baseUrl + ApiEndPoints.buyQuest);
    // print(Api.baseUrl +
    //     ApiEndPoints.checkAnswer +
    //     customerQuestId +
    //     "?customerReply=" +
    //     customerReply +
    //     "&questItemId=" +
    //     questItemId);
    print(response.body);
    if (response.statusCode == 200) {
      print("OKkkkkkkkkkkkkkkkkkkkkk");
      var data = json.decode(response.body);
      returnData = data["data"];
      // print(data);
      print(returnData);
      return returnData;
    }
    print("Error");
    return returnData;
  }

  Future<bool> checkPaymentStatus(String paymentId) async {
    var response = await http.get(
      Uri.parse(Api.baseUrl +
          ApiEndPoints.checkPaymentStatus +
          paymentId +
          "?language=0"),
      headers: {"Content-Type": "application/json"},
    );
    // print(Api.baseUrl + ApiEndPoints.checkPaymentStatus + paymentId);
    if (response.statusCode == 200) {
      var data = json.decode(response.body);
      print("Get Data ok");
      if (data["status"] == "success") {
        return true;
      }
      return false;
    }
    return Future<bool>.value(false);
  }

  Future<bool> customerStartQuest(
      String customerQuestId, String questID) async {
    var now = new DateTime.now();
    var dateFormatted = DateFormat("yyyy-MM-ddTHH:mm:ss").format(now);
    print(dateFormatted);
    Map mydata = {
      'createdDate': dateFormatted,
      'customerQuestId': customerQuestId,
    };
    var body = json.encode(mydata);
    var response = await http.post(
        Uri.parse(Api.baseUrl + ApiEndPoints.customerStartQuest + questID),
        headers: {"Content-Type": "application/json"},
        body: body);
    print(Api.baseUrl + ApiEndPoints.buyQuest);
    // print(Api.baseUrl +
    //     ApiEndPoints.checkAnswer +
    //     customerQuestId +
    //     "?customerReply=" +
    //     customerReply +
    //     "&questItemId=" +
    //     questItemId);
    if (response.statusCode == 200) {
      // print("OKkkkkkkkkkkkkkkkkkkkkk");
      var data = json.decode(response.body);
      print(data);
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

  Future<bool?> checkImage(String customerQuestId, String questItemId) async {
    final ImagePicker _picker = ImagePicker();
    final XFile? pickedFile = await _picker.pickImage(
      source: ImageSource.camera,
    );
    if (pickedFile != null) {
      var file = File(pickedFile.path);
      var request = new http.MultipartRequest(
          "POST",
          Uri.parse(
              "https://citytourist.azurewebsites.net/weather-forecast/demo2?api-version=1"));
      request.files.add(await http.MultipartFile.fromPath("file", file.path));
      request.headers["accept"] = "text/plain";
      request.headers["Content-Type"] = "multipart/form-data";
      print("Request:" + request.toString());
      var response = await request.send();
      print("Status code:" + response.statusCode.toString());
      if (response.statusCode == 200) {
        response.stream.transform(utf8.decoder).listen((value) {
          print(value);
        });
        return Future<bool>.value(true);
      }
    }
    return Future<bool>.value(false);

    // var response = await http.post(
    //     Uri.parse(Api.baseUrl + ApiEndPoints.checkImage),
    //     headers: {"Content-Type": "application/json"});
    // print(Api.baseUrl + ApiEndPoints.buyQuest);
    // // print(Api.baseUrl +
    // //     ApiEndPoints.checkAnswer +
    // //     customerQuestId +
    // //     "?customerReply=" +
    // //     customerReply +
    // //     "&questItemId=" +
    // //     questItemId);
    // if (response.statusCode == 200) {
    //   // print("OKkkkkkkkkkkkkkkkkkkkkk");
    //   var data = json.decode(response.body);
    //   print(data);
    //   return Future<bool>.value(true);
    // }
    // return Future<bool>.value(false);
  }
}
