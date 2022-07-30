import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:stop_watch_timer/stop_watch_timer.dart';
import 'package:travel_hour/controllers/comment_controller.dart';
import 'package:travel_hour/controllers/history_controller.dart';
import 'package:travel_hour/controllers/login_controller_V2.dart';
import 'package:travel_hour/models/purchased_quest.dart';
import 'package:travel_hour/pages/completed_quest.dart';
import 'package:travel_hour/pages/completed_questV2.dart';
import 'package:travel_hour/pages/description_questitem.dart';
import 'package:travel_hour/pages/rulepage.dart';
import 'package:travel_hour/services/play_service.dart';

import '../models/customer_task.dart';
import '../models/quest.dart';
import '../models/questItem.dart';

class PlayControllerV2 extends GetxController {
  //Bool check status show SplashPage await result from API
  var isDisableTextField = false.obs;
  var isLoading = false.obs;

  late PurchasedQuest pQuest;

  late CustomerTask cusTask;

  var customerQuestID = 0.obs;

  var isLoadQuestItem = false.obs;
  late QuestItem questItemCurrent;
  var sugggestion = "".obs;
  var isShowSuggestion = false.obs;
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
  final StopWatchTimer _stopWatchTimer = StopWatchTimer(
    mode: StopWatchMode.countUp,
  );
  final isHours = true;

  //Test List
  var qItem = List<QuestItem>.empty().obs;
  var index = 0.obs;
  var numQuest;
  late String endPoint;
  var checkErr = "".obs;

  var ruleIndex = 1.obs;
  var displayTime = "".obs;
  increaseIndexRule() {
    print(ruleIndex);
    ruleIndex++;
    update();
  }

  decreaseIndexRule() {
    print(ruleIndex);
    ruleIndex--;
    update();
  }

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
    _stopWatchTimer.onExecute.add(StopWatchExecute.start);
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

//Add Customer to Quest
  onInitPlayQuest() async {
    checkErr.value = await PlayService.createCustomerQuest(
        Get.find<LoginControllerV2>().sp.id, pQuest);

    if (checkErr.value.isNotEmpty) {
      if (checkErr.value == "Previous quest is not finished") {
        print("Lỗi chưa kết thúc");
        Get.snackbar('Lỗi',
            'Quest Chưa Kết Thúc. Vui Lòng liên hệ tổng đài để được hỗ trợ',
            duration: Duration(seconds: 2),
            backgroundColor: Colors.black,
            colorText: Colors.white,
            snackPosition: SnackPosition.BOTTOM,
            icon: Icon(
              Icons.error,
              color: Colors.red,
            ));
        Get.delete<PlayControllerV2>();
        Get.find<HistoryController>().getPuschedQuests();
      } else if (checkErr.value == "Ticket quantity is not enough") {
        print("Lỗi chưa kết thúc");
        Get.snackbar('Lỗi', 'Vé lỗi',
            duration: Duration(seconds: 2),
            backgroundColor: Colors.black,
            colorText: Colors.white,
            snackPosition: SnackPosition.BOTTOM,
            icon: Icon(
              Icons.error,
              color: Colors.red,
            ));
        Get.delete<PlayControllerV2>();
      }
      //Xác nhận đã StartQuest
      else {
        Get.to(RulePage());
        customerQuestID.value = int.parse(checkErr.value);
        cusTask = await PlayService.confirmTheFirstStart(
            pQuest.questId, customerQuestID.value);
        if (cusTask != null) {
          print('Ok');
          questItemCurrent =
              await PlayService.fetchQuestItem(cusTask.questItemId);
          if (questItemCurrent != null) {
            sugggestion.value =
                await PlayService().getSuggestion(questItemCurrent.id);
          }
        }
      }
    } else {}
  }

//[HandleButtonAnswer]
//When user click submit answer
//Check
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
      // cusTask = await PlayService().checkAnswerV2(
      //     customerQuestID.value.toString(),
      //     questItemCurrent.id.toString(),
      //     currentAns.value);
      correctAns.value = cusTask.isFinished;

      print('handleAuthStateChanged ' + customerQuestID.toString());
      // correctAns.value = qItem[index.value].ans == currentAns.value;
      Future.delayed(Duration(seconds: 2));
      print(correctAns.value);

      if (correctAns.value == true) {
        // if (cusTask.countWrongAnswer != 4) {
        Get.snackbar('Right Ans', 'Congratulations',
            duration: Duration(seconds: 2),
            backgroundColor: Colors.black,
            colorText: Colors.white,
            snackPosition: SnackPosition.TOP,
            icon: Icon(
              Icons.golf_course,
              color: Colors.greenAccent,
            ));
        //Prepare data for nextQu

        // }
        checkErr.value = await PlayService()
            .moveNextQuestItem(customerQuestID.value, pQuest.questId);
        int nextQuestItemId = int.parse(checkErr.value);
        print('CheckErr ' + checkErr.toString());

        if (nextQuestItemId != -1) {
          //gọi hàm getQuestItem
          isLoading(true);
          isDisableTextField(false);
          questItemCurrent = await PlayService.fetchQuestItem(nextQuestItemId);
          sugggestion.value =
              await PlayService().getSuggestion(questItemCurrent.id);
          isLoading(false);
          Get.to(DescriptionPage());
          update();
          //Check câu cuối
        } else {
          _stopWatchTimer.onExecute.add(StopWatchExecute.stop);

          _stopWatchTimer.rawTime.listen((value) => displayTime.value =
              StopWatchTimer.getDisplayTime(value, milliSecond: false)
                  .toString());
          endPoint = await PlayService.updateEndPoint(customerQuestID.value);
          Get.lazyPut(() => CommentController());
          Get.to(CompletedPageV2());
        }
        print(questItemCurrent.id);
        //refeshCurrentAns
        currentAns.value = "";
        update();
      } else {
        if (cusTask.countWrongAnswer == 4) {
          //show dap an
          isDisableTextField(true);
          currentAns.value = questItemCurrent.rightAnswer;
          update();
        } else if (cusTask.countWrongAnswer == 3) {
          Get.snackbar('Chi con 1 lan tra loi', 'Try Again',
              duration: Duration(seconds: 2),
              backgroundColor: Colors.black,
              colorText: Colors.white,
              snackPosition: SnackPosition.BOTTOM,
              icon: Icon(
                Icons.error,
                color: Colors.red,
              ));
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
      }
    } finally {
      isLoading(false);
    }
  }

  void showSuggestion() async {
    if (isShowSuggestion.value == false) {
      try {
        isLoading(true);
        cusTask =
            await PlayService().decreasePointSuggestion(customerQuestID.value);
        isShowSuggestion(true);
      } finally {
        isLoading(false);
      }
    }
  }

  // void checkImage(String customerQuestId, String questItemId) async {
  //   try {
  //     isLoading(true);
  //     // Xài tạm dữ liệu cứng để trả về true
  //     await PlayService().checkImage(customerQuestId, questItemId);
  //   } finally {
  //     isLoading(false);
  //   }
  // }

  Future<List?> buyQuest(var id, String customerId, String questID,
      int quantity, var totalAmout, var discountCode) async {
    try {
      isLoading(true);
      // Xài tạm dữ liệu cứng để trả về true
      // await PlayService()
      //     .buyQuest(customerId, questID, quantity, totalAmout, discountCode);
      return PlayService().buyQuest(
          id, customerId, questID, quantity, totalAmout, discountCode);
    } finally {
      isLoading(false);
    }
  }

  Future<bool> checkPaymentStatus(var paymentId) async {
    return await PlayService().checkPaymentStatus(paymentId);
  }
}
