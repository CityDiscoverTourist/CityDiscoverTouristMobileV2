import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:travel_hour/pages/completed_quest.dart';
import 'package:travel_hour/pages/ingroress.dart';
import 'package:travel_hour/services/play_service.dart';
import 'package:http/http.dart' as http;

import '../api/api.dart';
import '../api/api_end_points.dart';
import '../models/quest.dart';
import '../models/questItem.dart';

class PlayController extends GetxController {
  //Bool check status show SplashPage await result from API
  var isLoading = false.obs;
  //QuestItem current
  late QuestItem questItemCurrent;
  //Handle button submit Answer in Answer_questItem Page
  var clickAns = false.obs;
  //Bool check status when Answer Correct
  var correctAns = false.obs;
  //Information of Quest current
  Quest? questCurrent;
  //Current Ans of Customer
  var currentAns = "".obs;
  //Type Quest Item :
  //1.Text
  //2.Compare Image
  var suggesstion = "".obs;
  var typeQuestItem = 1.obs;
  //Lat long -Location of Customer
  var lat;
  var long;
  //Check Location same Location of QuestItem
  var checkLocation = false.obs;
  //Widget change when typeQuestItem change
  late Widget BodyType;

  //Test List
  var qItem = List<QuestItem>.empty().obs;
  var index = 0.obs;
  @override
  void onInit() async {
    super.onInit();
    fetchQuestItemTest();

    //B1 Fetch data the first QuestItem 1
    PlayService().fetchDataQuestItem();
  }

  @override
  void onReady() async {
    super.onReady();
    print('TextInit');
    questItemCurrent = qItem[index.value];
    ever(clickAns, handleAuthStateChanged);
    // ever(correctAns, handleAuthStateChanged);
  }

  @override
  void onClose() async {
    super.onClose();
  }

  //handleAuthStateChanged
  void handleAuthStateChanged(clickAns) async {
    //Check câu trả lời
    correctAns.value =
        await PlayService().checkAnswer("3", "stringgggdd", "42");
    // correctAns.value = qItem[index.value].ans == currentAns.value;
    if (correctAns.value == true) {
      //Prepare data for nextQuestItem
      print("handleAuthStateChanged - dòng 50 TRUE");
      //Check câu cuối
      if (index.value != qItem.length - 1) {
        fetchNextQuestItem();
        print(questItemCurrent.id);
        //refeshCurrentAns
        currentAns.value = "";
        update();
        //Get to next
        Get.snackbar('Right Ans', 'Congratulations',
            duration: Duration(seconds: 2),
            backgroundColor: Colors.black,
            colorText: Colors.white,
            snackPosition: SnackPosition.TOP,
            icon: Icon(
              Icons.golf_course,
              color: Colors.greenAccent,
            ));
        Get.to(IngrogressPage());
      } else {
        Get.to(CompletedPage());
      }
    } else {
      Get.snackbar('Wrong Ans', 'Try Again',
          duration: Duration(seconds: 2),
          backgroundColor: Colors.black,
          colorText: Colors.white,
          snackPosition: SnackPosition.BOTTOM,
          icon: Icon(
            Icons.error,
            color: Colors.red,
          ));
    }
  }

//Fetch information of next questItem
  void fetchNextQuestItem() async {
    //main
    //  questItem = await PlayService().fetchDataQuestItem();

    //test
    increaseIndex();
    questItemCurrent = qItem[index.value];
  }

//Check Location of customer
  void checkLocatCustomer() async {
    checkLocation.value = await PlayService().checkLocation("9");
  }

//Check currentAns
  void checkAnswer(
      String customerQuestId, String customerReply, String questItemId) async {
    try {
      isLoading(true);
      // Xài tạm dữ liệu cứng để trả về true
      correctAns.value =
          await PlayService().checkAnswer("3", "stringgggdd", "42");
    } finally {
      isLoading(false);
    }
  }

  //ClickAns
  void clickAnswer() {
    if (clickAns.value == true) {
      clickAns(false);
    } else {
      clickAns(true);
    }
  }

//Test
  void fetchQuestItemTest() async {
    var qItemApi = await PlayService.fetchTestData();
    if (qItemApi != null) qItem.assignAll(qItemApi);
    questItemCurrent = qItem[index.value];
  }

  void getSuggestion(String questItemId) async {
    try {
      isLoading(true);
      suggesstion.value = await PlayService().getSuggestion(questItemId);
    } finally {
      isLoading(false);
    }
  }

  void increaseIndex() {
    index = index + 1;
  }
}
