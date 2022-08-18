import 'dart:convert';

import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:travel_hour/common/customFullScreenDialog.dart';
import 'package:travel_hour/controllers/home_controller.dart';
import 'package:travel_hour/models/customer_quest.dart';
import 'package:travel_hour/models/quest_detail.dart';

import '../api/api.dart';
import '../api/api_end_points.dart';
import '../controllers/login_controller_V2.dart';
import '../models/quest.dart';

class QuestService {
  static var client = http.Client();
  static Future<List<Quest>?> fetchQuestFeatureData(
      int areaId, int language) async {
    // WelcomeController homeController = Get.find<WelcomeController>();
    // print("Jwt Token in Quets Service:" +
    //     Get.find<LoginControllerV2>().jwtToken.value);
    var response = await http.get(
        Uri.parse(
            'https://citytourist.azurewebsites.net/api/v1/quests?AreaId=${areaId}&language=${language}'),
        headers: {
          "Accept": "application/json",
          "content-type": "application/json",
          'Authorization':
              'Bearer ' + Get.find<LoginControllerV2>().jwtToken.value
        });
    print("fetchQuestFeatureData Status_code: " '${response.statusCode}');
    if (response.statusCode == 200) {
    Map data = jsonDecode(response.body);
    Iterable list = data['data'];
   
    final questListCast = list.cast<Map<String, dynamic>>();
    final listQuest = await questListCast.map<Quest>((json) {
      return Quest.fromJson(json);
    }).toList();
    return listQuest;
    }
    return null;
  }
//https://citytourist.azurewebsites.net/api/v1/quests?QuestTypeId=2&AreaId=3&language=0
 static Future<List<Quest>?> fetchQuestDataByType(
      int areaId,int questTypeId) async {
    // WelcomeController homeController = Get.find<WelcomeController>();
    // print("Jwt Token in Quets Service:" +
    //     Get.find<LoginControllerV2>().jwtToken.value);
    var response = await http.get(
        Uri.parse(
          // 'https://citytourist.azurewebsites.net/api/v1/quests?QuestTypeId=2&AreaId=10&Status=Active&language=1'
            'https://citytourist.azurewebsites.net/api/v1/quests?QuestTypeId=${questTypeId}&AreaId=${areaId}&Status=Active&language=${Get.find<LoginControllerV2>().language.value}'),
        headers: {
          "Accept": "application/json",
          "content-type": "application/json",
          'Authorization':
              'Bearer ' + Get.find<LoginControllerV2>().jwtToken.value
        });
    print("fetchQuestFeatureData Status_code: " '${response.statusCode}');
    // if (response.statusCode == 200) {
    Map data = jsonDecode(response.body);
    Iterable list = data['data'];
   
    final questListCast = list.cast<Map<String, dynamic>>();
    final listQuest = await questListCast.map<Quest>((json) {
      return Quest.fromJson(json);
    }).toList();
    return listQuest;
    // }
  }

//Get QuestDetail By Id
  static Future<QuestDetail?> fetchQuestDetailById(int id) async{
     var response = await http.get(
        Uri.parse(
          "https://citytourist.azurewebsites.net/api/v1/quests/${id}?language=${Get.find<LoginControllerV2>().language.value}"
          ),
        headers: {
          "Content-Type": "application/json",
          'Authorization':
              'Bearer ' + Get.find<LoginControllerV2>().jwtToken.value
        });
         if (response.statusCode == 200) {
      var responseData = json.decode(response.body);
      QuestDetail rs = QuestDetail.fromJson(responseData["data"]);
      // print(quest.description);
      // CustomFullScreenDialog.cancelDialog();
      return rs;
    }
    // CustomFullScreenDialog.cancelDialog();
    return null;
  }
   static Future<int?> fetchTotalQuestItemByIdQuest(int id) async{
     var response = await http.get(
        Uri.parse(
          "https://citytourist.azurewebsites.net/api/v1/quests/${id}?language=${Get.find<LoginControllerV2>().language.value}"
          ),
        headers: {
          "Content-Type": "application/json",
          'Authorization':
              'Bearer ' + Get.find<LoginControllerV2>().jwtToken.value
        });
         if (response.statusCode == 200) {
      var responseData = json.decode(response.body);
      int rs = responseData["data"]['countQuestItem'];
      // print(quest.description);
      // CustomFullScreenDialog.cancelDialog();
      return rs;
    }
    // CustomFullScreenDialog.cancelDialog();
    return null;
  }


  static Future<List<Quest>?> fetchQuestFeatureDataV2(String name) async {
    // WelcomeController homeController = Get.find<WelcomeController>();
    var response = await http.get(
        Uri.parse(
            'https://citytourist.azurewebsites.net/api/v1/quests?Name=${name}&Status=Active&language=' +
                Get.find<LoginControllerV2>().language.value.toString()),
        headers: {
          "Accept": "application/json",
          "content-type": "application/json",
          'Authorization':
              'Bearer ' + Get.find<LoginControllerV2>().jwtToken.value
        });
    print("fetchQuestFeatureDataV2 - 79 questService.dart: "
        '${response.statusCode}');
    // if (response.statusCode == 200) {
    Map data = jsonDecode(response.body);
    // Iterable list = dbc;
    Iterable list = data['data'];

    final bookingsAccept = list.cast<Map<String, dynamic>>();
    final listOfBookings_Accept = await bookingsAccept.map<Quest>((json) {
      return Quest.fromJson(json);
    }).toList();
    // print('object');
    return listOfBookings_Accept;
    // }
  }

  static Future<List<Quest>?> fetchPuQuestFeatureData(
      String customerId, var language) async {
    // var lang = 0;
    // if (language == true) {
    //   lang = 1;
    // }
    print(language.toString());
    var response = await http.get(
        Uri.parse(Api.baseUrl +
            ApiEndPoints.getCustomerQuestByCustomerId +
            customerId),
        headers: {
          "Content-Type": "application/json",
          'Authorization':
              'Bearer ' + Get.find<LoginControllerV2>().jwtToken.value
        });
    print(Api.baseUrl +
        ApiEndPoints.getCustomerQuestByCustomerId +
        customerId +
        "?language=" +
        language.toString());
    if (response.statusCode == 200) {
      List<Quest> listQuest = new List.empty(growable: true);
      // print("OKkkkkkkkkkkkkkkkkkkkkk");
      // var data = json.decode(response.body);
      Map<String, dynamic> map = json.decode(response.body);
      List<dynamic> data = map["data"];
      for (var element in data) {
        var response2 = await http.get(
            Uri.parse(Api.baseUrl +
                ApiEndPoints.getQuestById +
                element["questId"].toString() +
                "?language=" +
                language.toString()),
            headers: {"Content-Type": "application/json"});
        print(Api.baseUrl +
            ApiEndPoints.getQuestById +
            element["questId"].toString());
        if (response2.statusCode == 200 && element["isFinished"] == false) {
          var responseData2 = json.decode(response2.body);
          Quest quest = Quest.fromJson(responseData2["data"]);
          if (element["createdDate"] != null) {
            // quest.createdDate = DateTime.tryParse(element["createdDate"])!;
          }
          listQuest.add(quest);
          print(quest.description);
        }
      }
      // print(data);
      return Future<List<Quest>>.value(listQuest);
    }
    return Future<List<Quest>>.value(null);
  }

  static Future<List<Quest>?> fetchPlayingHistory(
      String customerId, var language) async {
    // var lang = 0;
    // if (language == true) {
    //   lang = 1;
    // }
    print(language.toString());
    var response = await http.get(
        Uri.parse(Api.baseUrl +
            ApiEndPoints.getCustomerQuestByCustomerId +
            customerId),
        headers: {
          "Content-Type": "application/json",
          'Authorization':
              'Bearer ' + Get.find<LoginControllerV2>().jwtToken.value
        });
    print(Api.baseUrl + ApiEndPoints.getCustomerQuestByCustomerId + customerId);
    if (response.statusCode == 200) {
      List<Quest> listQuest = new List.empty(growable: true);
      // print("OKkkkkkkkkkkkkkkkkkkkkk");
      // var data = json.decode(response.body);
      Map<String, dynamic> map = json.decode(response.body);
      List<dynamic> data = map["data"];
      for (var element in data) {
        var response2 = await http.get(
            Uri.parse(Api.baseUrl +
                ApiEndPoints.getQuestById +
                element["questId"].toString()),
            headers: {
              "Content-Type": "application/json",
              'Authorization':
                  'Bearer ' + Get.find<LoginControllerV2>().jwtToken.value
            });
        print(Api.baseUrl +
            ApiEndPoints.getQuestById +
            element["questId"].toString());
        if (response2.statusCode == 200 && element["isFinished"] == false) {
          var responseData2 = json.decode(response2.body);
          Quest quest = Quest.fromJson(responseData2["data"]);
          if (element["createdDate"] != null) {
            // quest.createdDate = DateTime.tryParse(element["createdDate"])!;
          }
          listQuest.add(quest);
          // print(quest.description);
        }
      }
      // print(data);
      // Get.find<HomeController>().hisQuestList.value = listQuest;
      return Future<List<Quest>>.value(listQuest);
    }
    return Future<List<Quest>>.value(null);
  }

  static Future<List<CustomerQuest>?> fetchPlayedQuestFeatureData(
      String customerId) async {
    var myController = Get.find<LoginControllerV2>();
    print("ngôn ngữ "+'${Get.find<LoginControllerV2>().language.value.toString()}');
    var response = await http.get(
        Uri.parse('https://citytourist.azurewebsites.net/api/v1/customer-quests/get-by-customer-id?id=${customerId}&language=${Get.find<LoginControllerV2>().language.value.toString()}'),
        headers: {
          "Content-Type": "application/json",
          'Authorization': 'Bearer ' + myController.jwtToken.value
        });
    // print(Api.baseUrl + ApiEndPoints.getSuggestion + customerId);
    print(response.statusCode.toString());
    if (response.statusCode == 200) {
      // List<Quest> listQuest = new List.empty(growable: true);
      // // print("OKkkkkkkkkkkkkkkkkkkkkk");
      // // var data = json.decode(response.body);
      // Map<String, dynamic> map = json.decode(response.body);
      // List<dynamic> data = map["data"];
      // for (var element in data) {
      //   var response2 = await http.get(
      //       Uri.parse(Api.baseUrl +
      //           ApiEndPoints.getQuestById +
      //           element["questId"].toString() +
      //           "?language=" +
      //           Get.find<LoginControllerV2>().language.value.toString()),
      //       headers: {
      //         "Content-Type": "application/json",
      //         'Authorization': 'Bearer ' + myController.jwtToken.value
      //       });
      //   // print(Api.baseUrl +
      //   //     ApiEndPoints.getQuestById +
      //   //     element["questId"].toString() +
      //   //     "?language=" +
      //   //     Get.find<LoginControllerV2>().language.value.toString());
      //   if (response2.statusCode == 200 && element["isFinished"] == true) {
      //     var responseData2 = json.decode(response2.body);
      //     Quest quest = Quest.fromJson(responseData2["data"]);
      //     listQuest.add(quest);
      //     // print(quest.createdDate);
      //   }
       Map data = jsonDecode(response.body);
    // Iterable list = dbc;
    Iterable list = data['data'];

    final historyPlayedData = list.cast<Map<String, dynamic>>();
    final listHistoryPlayedData = await historyPlayedData.map<CustomerQuest>((json) {
      return CustomerQuest.fromJson(json);
    }).toList();
      return listHistoryPlayedData;

    // print('object');
      }
      // print(data);
      // Get.find<HomeController>().hisQuestList.value = listQuest;
      return null;
    }
  static Future<Quest?> fetchQuestDetail(String questId, var language) async {
    // var lang = 0;
    // if (language == true) {
    //   lang = 1;
    // }
    // print(language.toString());

    // var myController = Get.find<LoginControllerV2>();
    // print(myController.jwtToken.value);
    var response = await http.get(
        Uri.parse(Api.baseUrl +
            ApiEndPoints.getQuestById +
            questId +
            "?language=" +
            language.toString()),
        headers: {
          "Content-Type": "application/json",
          'Authorization':
              'Bearer ' + Get.find<LoginControllerV2>().jwtToken.value
        });
    // print(Api.baseUrl +
    //     ApiEndPoints.getQuestById +
    //     questId +
    //     "?language=" +
    //     language.toString());
    // print(response.body);
    if (response.statusCode == 200) {
      var responseData = json.decode(response.body);
      Quest quest = Quest.fromJson(responseData["data"]);
      // print(quest.description);
      // CustomFullScreenDialog.cancelDialog();
      return quest;
    }
    // CustomFullScreenDialog.cancelDialog();
    return null;
  }
}
