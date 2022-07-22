import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:travel_hour/controllers/home_controller.dart';
import 'package:travel_hour/controllers/login_controller_V2.dart';
import 'package:travel_hour/models/purchased_quest.dart';
import 'package:travel_hour/pages/answer_questitem.dart';
import 'package:travel_hour/pages/completed_quest.dart';
import 'package:travel_hour/pages/ingroress.dart';
import 'package:travel_hour/services/play_service.dart';
import 'package:http/http.dart' as http;

import '../api/api.dart';
import '../api/api_end_points.dart';
import '../models/customer_task.dart';
import '../models/quest.dart';
import '../models/questItem.dart';

class PlayControllerV2 extends GetxController {
  //Bool check status show SplashPage await result from API
  var isLoading = false.obs;

  late PurchasedQuest pQuest;

  late CustomerTask cusTask;

  var customerQuestID = 0.obs;

  var isLoadQuestItem = false.obs;
  late QuestItem questItemCurrent;
 var sugggestion="".obs;
 var isShowSuggestion=false.obs;
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
  // var suggesstion = "".obs;
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
  var numQuest;

  void changeIsLoading() {
    isLoading(true);
    Future.delayed(Duration(seconds: 3));
    isLoading(false);
  }

  void clickAnswer() {
    if (clickAns.value == true) {
      clickAns(false);
    } else {
      clickAns(true);
    }
  }
  //   void showSuggestion() {
  //   if (clickAns.value == true) {
  //     clickAns(false);
  //   } else {
  //     clickAns(true);
  //   }
  // }

  @override
  void onInit() async {
    super.onInit();

    //B1 Fetch data the first QuestItem 1
    // PlayService().fetchDataQuestItem();
  }

  @override
  void onReady() async {
    onInitPlayQuest();
    super.onReady();
    update();

    ever(clickAns, handleAuthStateChanged);
    ever(isLoadQuestItem, (_) {
      if (isLoadQuestItem.value == true) {
        loadDataQuestItem() async {
          questItemCurrent =
              await PlayService.fetchQuestItem(cusTask.questItemId);
          if (questItemCurrent != null) {
            print('OKKKKK');
            //Chuyen du lieu
            isLoading(false);
          }
        }
      }
    });
  }

  @override
  void onClose() async {
    super.onClose();
  }

//handleAuthStateChanged
  void handleAuthStateChanged(clickAns) async {
    //Check câu trả lời
    try {
      isLoading(true);
      print('handleAuthStateChanged ' +
          customerQuestID.value.toString() +
          "/" +
          currentAns.value +
          "/" +
          questItemCurrent.id.toString());
      cusTask = await PlayService().checkAnswer(
          customerQuestID.value, currentAns.value, questItemCurrent.id);
      correctAns.value = cusTask.isFinished;

      print('handleAuthStateChanged ' + customerQuestID.toString());
      // correctAns.value = qItem[index.value].ans == currentAns.value;
      Future.delayed(Duration(seconds: 2));
      print(correctAns.value);
      if (correctAns.value == true) {
        isShowSuggestion(false);
         Get.snackbar('Right Ans', 'Congratulations',
            duration: Duration(seconds: 2),
            backgroundColor: Colors.black,
            colorText: Colors.white,
            snackPosition: SnackPosition.TOP,
            icon: Icon(
              Icons.golf_course,
              color: Colors.greenAccent,
            ));
        //Prepare data for nextQuestItem
        print("handleAuthStateChanged - dòng 50 TRUE");
        //gọi hàm move next
        int nextQuestItemId = await PlayService()
            .moveNextQuestItem(customerQuestID.value, pQuest.questId);
        print('nextQuestItemId ' + nextQuestItemId.toString());
        if(nextQuestItemId!=-1){
        //gọi hàm getQuestItem
        isLoading(true);
        questItemCurrent = await PlayService.fetchQuestItem(nextQuestItemId);
        sugggestion.value=await PlayService().getSuggestion(questItemCurrent.id);
        isLoading(false);
        //Check câu cuối
        }else{
            Get.to(CompletedPage());
        }
      
        print(questItemCurrent.id);
        //refeshCurrentAns
        currentAns.value = "";
        update();
        //Get to next
       
        // Get.to(IngrogressPage());
        // } else {
        // Get.to(CompletedPage());
        // }
      } else {
        print(correctAns.value);
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
    } finally {
      isLoading(false);
    }
  }

  void showSuggestion()async{
    if(isShowSuggestion.value==false){
      try{
        isLoading(true);
  cusTask=await PlayService().decreasePointSuggestion(customerQuestID.value);
isShowSuggestion(true);
      }finally{
        isLoading(false);
      }
  
    }
  }

//Add Customer to Quest
  onInitPlayQuest() async {
    //tạo quyền sở hữu lượt chơi cho customer
    customerQuestID.value = await PlayService.createCustomerQuest(
        Get.find<LoginControllerV2>().sp.id, pQuest);
    if (customerQuestID.value != 0) {
      print('onInitPlayQuest: No Empty');
      //Xác nhận đã StartQuest
      cusTask = await PlayService.confirmTheFirstStart(
          pQuest.questId, customerQuestID.value);
      if (cusTask != null) {
        print('Ok');
        questItemCurrent =
            await PlayService.fetchQuestItem(cusTask.questItemId);
        if (questItemCurrent != null){
            sugggestion.value=await PlayService().getSuggestion(questItemCurrent.id);

        }
      }
    }
    // void checkAnswer(){
    //     // String customerQuestId, String customerReply, String questItemId) async {
    //   try {
    //     isLoading(true);
    //     // Xài tạm dữ liệu cứng để trả về true
    //     // correctAns.value =
    //     //     await PlayService().checkAnswer("3", "stringgggdd", "42");
    //       if(currentAns.value==questItemCurrent.rightAnswer){
    //       correctAns.value=true;
    //     }else{correctAns(false);}
    //   } finally {
    //     isLoading(false);
    //   }
    // }

    // PlayService().

    //Lay latlong bo vo
    // var checkLocationStartQuest = false.obs;
    // checkLocationStartQuest.value = PlayService()
    //     .checkLocation(idQuest.value, "1873774", "6626262") as bool;
    // if (checkLocationStartQuest.value != false) {
    //   //Api sta

    // }else{

    // }
  }
}
