import 'dart:convert';
import 'dart:io';

import 'package:easy_localization/easy_localization.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';
import 'package:travel_hour/controllers/login_controller_V2.dart';
import 'package:travel_hour/models/customer_task.dart';
import 'package:travel_hour/models/purchased_quest.dart';
import 'package:travel_hour/models/questItem.dart';
import 'package:http/http.dart' as http;
import 'package:path/path.dart';

import '../api/api.dart';
import '../api/api_end_points.dart';
import '../common/customFullScreenDialog.dart';

class PlayService {
//Tạo sở hữu lượt chơi
  static Future<String> createCustomerQuest(
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
          "content-type": "application/json",
          'Authorization':
              'Bearer ' + Get.find<LoginControllerV2>().jwtToken.value
        },
        body: jsonEncode(body));
    print('createCustomerQuest StatusCode: ' + response.statusCode.toString());
    if (response.statusCode == 200) {
      Map data = jsonDecode(response.body);

      int idCusQuest = data['data']['id'];
      return Future<String>.value(idCusQuest.toString());
    } else if (response.statusCode == 400) {
      Map data = jsonDecode(response.body);
      String rs = data["message"];
      return Future<String>.value(rs);
    }
    return Future<String>.value("");
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
          "content-type": "application/json",
          'Authorization':
              'Bearer ' + Get.find<LoginControllerV2>().jwtToken.value
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
            '?language=' +
            Get.find<LoginControllerV2>().language.value.toString()),
        headers: {
          "Content-Type": "application/json",
          'Authorization':
              'Bearer ' + Get.find<LoginControllerV2>().jwtToken.value
        });
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
        headers: {
          "Content-Type": "application/json",
          'Authorization':
              'Bearer ' + Get.find<LoginControllerV2>().jwtToken.value
        });
    // print(Api.baseUrl +
    //     ApiEndPoints.checkAnswer +
    //     customerQuestId +
    //     "?customerReply=" +
    //     customerReply +
    //     "&questItemId=" +
    //     questItemId);
    print("checkAnswer " + response.statusCode.toString());
    if (response.statusCode == 200) {
      print("OKkkkkkkkkkkkkkkkkkkkkk");
      Map data = jsonDecode(response.body);
      rs = CustomerTask.fromJson(data['data']);
      // print(rs.toString());    // print(data);
      print("checkAnswer " + rs.countWrongAnswer.toString());
      print("checkAnswer " + rs.countWrongAnswer.toString());
      return Future<CustomerTask>.value(rs);
    }
    return Future<CustomerTask>.value(null);
  }

  static Future<String> updateEndPoint(int customerQuestId) async {
    String rs;
    var response = await http.put(
        Uri.parse(
            'https://citytourist.azurewebsites.net/api/v1/customer-quests/update-end-point/${customerQuestId}'),
        headers: {
          "Content-Type": "application/json",
          'Authorization':
              'Bearer ' + Get.find<LoginControllerV2>().jwtToken.value
        });
    print("updateEndPoint Statuscode" + response.statusCode.toString());
    if (response.statusCode == 200) {
      // final responseData = json.decode(response.body);
      // final rs = QuestItem.fromJson(responseData['data']);
      // print('object');
      print("updateEndPoint OK");
      Map data = jsonDecode(response.body);
      rs = data['data']['endPoint'];
      return Future<String>.value(rs);
    } else {
      print('fail');
      return Future<String>.value("");
    }
  }

  Future<CustomerTask> decreasePointSuggestion(int customerQuestId) async {
    CustomerTask rs;
    var response = await http.put(
        Uri.parse(
            "https://citytourist.azurewebsites.net/api/v1/customer-tasks/decrease-point-suggestion/${customerQuestId}"),
        headers: {
          "Content-Type": "application/json",
          'Authorization':
              'Bearer ' + Get.find<LoginControllerV2>().jwtToken.value
        });
    if (response.statusCode == 200) {
      Map data = jsonDecode(response.body);
      rs = CustomerTask.fromJson(data['data']);
      // print(rs.toString());    // print(data);
      return Future<CustomerTask>.value(rs);
    }
    return Future<CustomerTask>.value(null);
  }

  Future<String> moveNextQuestItem(int customerQuestId, int questId) async {
    CustomerTask rs;
    var response = await http.put(
        Uri.parse(
            "https://citytourist.azurewebsites.net/api/v1/customer-tasks/move-next-task?questId=${questId}&customerQuestId=${customerQuestId}"),
        headers: {
          "Content-Type": "application/json",
          'Authorization':
              'Bearer ' + Get.find<LoginControllerV2>().jwtToken.value
        });
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
      return Future<String>.value(rs.toString());
    } else if (response.statusCode == 400) {
      return Future<String>.value("-1");
    }
    return Future<String>.value("0");
  }

  Future<String> getSuggestion(int questItemId) async {
    String rs;
    var response = await http.get(
        Uri.parse(
            "https://citytourist.azurewebsites.net/api/v1/customer-tasks/show-suggestion/${questItemId}"),
        headers: {
          "Content-Type": "application/json",
          'Authorization':
              'Bearer ' + Get.find<LoginControllerV2>().jwtToken.value
        });
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

  Future<List?> buyQuest(var id, String customerId, String questID,
      int quantity, var totalAmout, var discountCode) async {
    CustomFullScreenDialog.showDialog();
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
    if (discountCode != "") {
      httpString = httpString + "?discountCode=" + discountCode;
    }
    var response = await http.post(Uri.parse(httpString),
        headers: {
          "Content-Type": "application/json",
          'Authorization':
              'Bearer ' + Get.find<LoginControllerV2>().jwtToken.value
        },
        body: body);
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
      CustomFullScreenDialog.cancelDialog();
      return returnData;
    }
    print("Error");
    return returnData;
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
        headers: {
          "Content-Type": "application/json",
          'Authorization':
              'Bearer ' + Get.find<LoginControllerV2>().jwtToken.value
        },
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
    // CustomFullScreenDialog.showDialog();
    Position? pos = await getCurrentPosition();
    var lat = pos?.latitude.toString();
    var long = pos?.longitude.toString();
    print("lat : " + lat!);
    print("long : " + long!);
    var response = await http.get(
        Uri.parse(Api.baseUrl +
                ApiEndPoints.checkUserLocationQuest +
                questID +
                //Cái này để tạm latlong cứng để trả về true
                "?latitude=" +
                lat.toString() +
                // lat! +
                "&longitude=" +
                long.toString()
            // +
            // long!
            ),
        headers: {
          "Content-Type": "application/json",
          'Authorization':
              'Bearer ' + Get.find<LoginControllerV2>().jwtToken.value
        });

    if (response.statusCode == 200) {
      // print("OKkkkkkkkkkkkkkkkkkkkkk");
      // var data = json.decode(response.body);
      // print(data);
      print("True");
      // CustomFullScreenDialog.showDialog();
      return Future<bool>.value(true);
    }
    // CustomFullScreenDialog.showDialog();
    print("False");
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
        headers: {
          "Content-Type": "application/json",
          'Authorization':
              'Bearer ' + Get.find<LoginControllerV2>().jwtToken.value
        });

    if (response.statusCode == 200) {
      // print("OKkkkkkkkkkkkkkkkkkkkkk");
      return Future<bool>.value(true);
    }
    return Future<bool>.value(false);
  }

  Future<bool> checkPaymentStatus(String paymentId) async {
    // CustomFullScreenDialog.showDialog();
    var response = await http.get(
      Uri.parse(Api.baseUrl + ApiEndPoints.checkPaymentStatus + paymentId),
      headers: {
        "Content-Type": "application/json",
        'Authorization':
            'Bearer ' + Get.find<LoginControllerV2>().jwtToken.value
      },
    );
    print(Api.baseUrl + ApiEndPoints.checkPaymentStatus + paymentId);
    if (response.statusCode == 200) {
      var data = json.decode(response.body);

      // print("Get Data ok");
      print(data["data"]);
      if (data["data"]["status"] == "Success") {
        // CustomFullScreenDialog.cancelDialog();
        return true;
      }
      // CustomFullScreenDialog.cancelDialog();
      return false;
    }
    // CustomFullScreenDialog.cancelDialog();
    return Future<bool>.value(false);
  }

  Future<CustomerTask> checkAnswerV2(String customerQuestId, String questItemId,
      String customerReply, int questTypeId) async {
    String requestUrl;
    CustomerTask? rs;
    print("customerQuestId:" + customerQuestId);
    print("questItemId:" + questItemId);
    print("customerReply:" + customerReply);
    if (questTypeId == 1) {
      requestUrl = Api.baseUrl +
          ApiEndPoints.checkAnswer +
          customerQuestId.toString() +
          "?customerReply=" +
          customerReply +
          "&questItemId=" +
          questItemId.toString();
      var request = new http.MultipartRequest("PUT", Uri.parse(requestUrl));
      request.headers["accept"] = "text/plain";
      request.headers["Content-Type"] = "multipart/form-data";
      request.headers["Authorization"] =
          "Bearer " + Get.find<LoginControllerV2>().jwtToken.value;
      print("Request:" + request.toString());
      var response = await request.send();
      print("Status code:" + response.statusCode.toString());
      if (response.statusCode == 200) {
        String reply = await response.stream.transform(utf8.decoder).join();
        Map<String, dynamic> result = jsonDecode(reply);
        print(result["data"]);
        rs = CustomerTask.fromJson(result["data"]);
        return Future<CustomerTask>.value(rs);
      }
    } else {
      requestUrl = Api.baseUrl +
          ApiEndPoints.checkAnswer +
          customerQuestId.toString() +
          "?customerReply=" +
          "1" +
          "&questItemId=" +
          questItemId.toString();
      // requestUrl =
      //     "https://citytourist.azurewebsites.net/weather-forecast/demo2?api-version=1";
      // final ImagePicker imagePicker = ImagePicker();
      // List<XFile>? imageFileList = [];
      // final List<XFile>? selectedImages = await imagePicker.pickMultiImage(
      //     maxHeight: 480, maxWidth: 640, imageQuality: 50);
      // if (selectedImages!.isNotEmpty) {
      //   imageFileList.addAll(selectedImages);
      // }
      final ImagePicker _picker = ImagePicker();
      print(requestUrl);

      //maxHeight: 2560, maxWidth: 1152
      final XFile? pickedFile =
          await _picker.pickImage(source: ImageSource.camera);
      if (pickedFile != null) {
        final LostDataResponse response2 = await _picker.retrieveLostData();
        File file = File(pickedFile.path);
        if (file != null) {
          print("Not ok");
        } else {
          print("Ok");
        }
        print("Path" + pickedFile.path);
        var request = new http.MultipartRequest("PUT", Uri.parse(requestUrl));
        // request.files
        //     .add(await http.MultipartFile.fromPath("files", file.path));
        request.headers["accept"] = "text/plain";
        request.headers["Content-Type"] = "multipart/form-data";
        request.headers["Authorization"] =
            "Bearer " + Get.find<LoginControllerV2>().jwtToken.value;
        print("Request:" + request.toString());
        if (response2.files != null) {
          final XFile file2 = response2.files as XFile;
          print(file2.path);
          request.files
              .add(await http.MultipartFile.fromPath("files", file2.path));
          print(request.files);
        } else {
          var pic = await http.MultipartFile.fromPath("files", file.path);
          request.files.add(pic);
          print(request.files.first.filename);
        }
        // for (var element in imageFileList) {
        //   var file2 = File(element.path);
        //   request.files
        //       .add(await http.MultipartFile.fromPath("files", file2.path));
        // }
        var response = await request.send().timeout(Duration(minutes: 15));
        print("Status code:" + response.statusCode.toString());
        String reply = await response.stream.transform(utf8.decoder).join();
        print(reply);
        if (response.statusCode == 200) {
          // String reply = await response.stream.transform(utf8.decoder).join();
          Map<String, dynamic> result = jsonDecode(reply);
          print(result["data"]);
          rs = CustomerTask.fromJson(result["data"]);
          return Future<CustomerTask>.value(rs);
        }
      }
    }
    return Future<CustomerTask>.value(null);
  }
}
