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
import '../models/questItem.dart';

class PlayController extends GetxController {
  var isLoading = false.obs;
  late QuestItem questItem;
  var clickAns = false.obs;
  var correctAns = false.obs;

  var currentAns = "".obs;
  var typeQuestItem = 1.obs;
  var lat;
  var long;
  var checkLocation = false.obs;
  late Widget BodyType;

  //Test List
  var qItem = List<QuestItem>.empty().obs;
  var index = 0.obs;
  @override
  void onInit() async {
    super.onInit();
    fetchQuestItemTest();
  }

  @override
  void onReady() async {
    super.onReady();
    print('TextInit');
    questItem = qItem[index.value];
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
    correctAns.value = qItem[index.value].ans == currentAns.value;
    if (correctAns.value == true) {
      //Prepare data for nextQuestItem
      print("handleAuthStateChanged - dòng 50 TRUE");
      //Check câu cuối
      if (index.value != qItem.length - 1) {
        fetchNextQuestItem();
        print(questItem.id);
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
    questItem = qItem[index.value];
  }

//Check Location of customer
  void checkLocatCustomer() async {
    checkLocation.value = await PlayService().checkLocation("9");
  }

//Check currentAns
  void checkAnswer() async {
    try {
      isLoading(true);
      correctAns.value = await PlayService().checkAnswer();
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
    questItem = qItem[index.value];
  }

  void increaseIndex() {
    index = index + 1;
  }
}
