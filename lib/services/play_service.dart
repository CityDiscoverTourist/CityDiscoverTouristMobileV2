import 'dart:convert';
import 'dart:ffi';

import 'package:easy_localization/easy_localization.dart';
import 'package:geolocator/geolocator.dart';
import 'package:travel_hour/models/customer.dart';
import 'package:travel_hour/models/customer_task.dart';
import 'package:travel_hour/models/purchased_quest.dart';
import 'package:travel_hour/models/questItem.dart';
import 'package:http/http.dart' as http;

import '../api/api.dart';
import '../api/api_end_points.dart';

class PlayService {
//Tạo sở hữu lượt chơi
  static Future<int> createCustomerQuest(
      String customerID, PurchasedQuest pQ) async {
    int questID = pQ.questId;
    String paymentID = pQ.id;
    print("createCustomerQuest " +
        customerID +
        "/" +
        questID.toString() +
        paymentID);
    Map body = {
      'customerId': customerID,
      'questId': questID,
      'paymentId': paymentID
    };
    var response = await http.post(
        Uri.parse(
            "https://citytourist.azurewebsites.net/api/v1/customer-quests"),
        headers: {
          "Accept": "application/json",
          "content-type": "application/json"
        },
        body: jsonEncode(body));
    print('createCustomerQuest StatusCode: ' + response.statusCode.toString());
    if (response.statusCode == 200) {
      Map data = jsonDecode(response.body);
      // Iterable list = dbc;
      int idCusQuest = data['data']['id'];
      return Future<int>.value(idCusQuest);
    }
    return Future<int>.value(0);
  }

//Load câu đầu lần đầu start quest
  static Future<CustomerTask> confirmTheFirstStart(
      int questID, int customerQuestID) async {
    print("confirmTheFirstStart" +
        customerQuestID.toString() +
        "/" +
        questID.toString());
    CustomerTask rs;
    Map body = {'customerQuestId': customerQuestID};
    var response = await http.post(
        Uri.parse(
            "https://citytourist.azurewebsites.net/api/v1/customer-tasks/" +
                questID.toString()),
        headers: {
          "Accept": "application/json",
          "content-type": "application/json"
        },
        body: jsonEncode(body));
    print('confirmTheFirstStart StatusCode: ' + response.statusCode.toString());
    if (response.statusCode == 200) {
      Map data = jsonDecode(response.body);
      rs = CustomerTask.fromJson(data['data']);

      return Future<CustomerTask>.value(rs);
    }
    return Future<CustomerTask>.value(null);
  }

  static Future<QuestItem> fetchQuestItem(int questItemId) async {
    QuestItem rs;
    var response = await http.get(
        Uri.parse('https://citytourist.azurewebsites.net/api/v1/quest-items/' +
            questItemId.toString() +
            '?language=0'),
        headers: {"Content-Type": "application/json"});
    if (response.statusCode == 200) {
      final responseData = json.decode(response.body);
      final rs = QuestItem.fromJson(responseData['data']);
      // print('object');
      print("fetchQuestItem OK" + rs.content);
      return Future<QuestItem>.value(rs);
    } else {
      print('fail');
      return Future<QuestItem>.value(null);
    }
  }
  // static void startQuest(String questID,String idPayment,String customer)async{
  //   Map body={
  //     'id':''
  //   };
  //   var response=await http.post(Uri.parse("https://citytourist.azurewebsites.net/api/v1/customer-tasks/questId=${questID}"),headers:{"Content-Type": "application/json" },body: )
  // }

  Future<QuestItem> fetchDataQuestItem() {
    QuestItem? questItem;
    return Future<QuestItem>.value(questItem);
  }

  // Future<bool> checkAnswer() {
  //   return Future<bool>.value(false);
  // }

  Future<CustomerTask> checkAnswer(
      int customerQuestId, String customerReply, int questItemId) async {
    CustomerTask rs;
    var response = await http.put(
        Uri.parse(Api.baseUrl +
            ApiEndPoints.checkAnswer +
            customerQuestId.toString() +
            "?customerReply=" +
            customerReply +
            "&questItemId=" +
            questItemId.toString()),
        headers: {"Content-Type": "application/json"});
    // print(Api.baseUrl +
    //     ApiEndPoints.checkAnswer +
    //     customerQuestId +
    //     "?customerReply=" +
    //     customerReply +
    //     "&questItemId=" +
    //     questItemId);
    if (response.statusCode == 200) {
      print("OKkkkkkkkkkkkkkkkkkkkkk");
      Map data = jsonDecode(response.body);
      rs = CustomerTask.fromJson(data['data']);
      // print(rs.toString());    // print(data);
      return Future<CustomerTask>.value(rs);
    }
    return Future<CustomerTask>.value(null);
  }

  Future<CustomerTask> decreasePointSuggestion(int customerQuestId) async {
    CustomerTask rs;
    var response = await http.put(
        Uri.parse(
            "https://citytourist.azurewebsites.net/api/v1/customer-tasks/decrease-point-suggestion/${customerQuestId}"),
        headers: {"Content-Type": "application/json"});
    if (response.statusCode == 200) {
      Map data = jsonDecode(response.body);
      rs = CustomerTask.fromJson(data['data']);
      // print(rs.toString());    // print(data);
      return Future<CustomerTask>.value(rs);
    }
    return Future<CustomerTask>.value(null);
  }

  Future<int> moveNextQuestItem(int customerQuestId, int questId) async {
    CustomerTask rs;
    var response = await http.put(
        Uri.parse(
            "https://citytourist.azurewebsites.net/api/v1/customer-tasks/move-next-task?questId=${questId}&customerQuestId=${customerQuestId}"),
        headers: {"Content-Type": "application/json"});
    // print(Api.baseUrl +
    //     ApiEndPoints.checkAnswer +
    //     customerQuestId +
    //     "?customerReply=" +
    //     customerReply +
    //     "&questItemId=" +
    //     questItemId);
    print("moveNextQuestItem :  Status Code:" + response.statusCode.toString());
    print("moveNextQuestItem :  " + response.statusCode.toString());
    if (response.statusCode == 200) {
      print("moveNextQuestItem ok");
      int rs = jsonDecode(response.body);
      print(rs);
      // print(rs.toString());    // print(data);
      return Future<int>.value(rs);
    } else if (response.statusCode == 400) {
      return Future<int>.value(-1);
    }
    return Future<int>.value(0);
  }

  Future<String> getSuggestion(int questItemId) async {
    String rs;
    var response = await http.get(
        Uri.parse(
            "https://citytourist.azurewebsites.net/api/v1/customer-tasks/show-suggestion/${questItemId}"),
        headers: {"Content-Type": "application/json"});
    // print(Api.baseUrl +
    //     ApiEndPoints.checkAnswer +
    //     customerQuestId +
    //     "?customerReply=" +
    //     customerReply +
    //     "&questItemId=" +
    //     questItemId);
    print("getSuggestion :  Status Code:" + response.statusCode.toString());
    //  print("getSuggestion :  "+response.statusCode.toString());
    if (response.statusCode == 200) {
      print("getSuggestion ok");
      rs = jsonDecode(response.body);
      print(rs);
      // print(rs.toString());    // print(data);
      return Future<String>.value(rs);
    }
    return Future<String>.value("");
  }

  Future<bool> buyQuest(String customerId, String questID) async {
    var now = new DateTime.now();
    var dateFormatted = DateFormat("yyyy-MM-ddTHH:mm:ss").format(now);
    print(dateFormatted);
    Map mydata = {
      'createdDate': dateFormatted,
      'customerId': customerId,
      'questId': questID
    };
    var body = json.encode(mydata);
    var response = await http.post(
        Uri.parse(Api.baseUrl + ApiEndPoints.buyQuest),
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

  Future<bool> checkLocation(int questID, String lat, String long) async {
    Position? pos = await getCurrentPosition();
    var lat = pos?.latitude.toString();
    var long = pos?.longitude.toString();
    var response = await http.get(
        Uri.parse(Api.baseUrl +
                ApiEndPoints.checkUserLocationQuest +
                questID.toString() +
                //Cái này để tạm latlong cứng để trả về true
                "?latitude=" +
                lat.toString() +
                // lat! +
                "&longitude=" +
                long.toString()
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
}
