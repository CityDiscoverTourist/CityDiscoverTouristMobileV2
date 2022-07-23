// import 'package:citydiscovertourist/models/customer.dart';
// import 'package:citydiscovertourist/screen/welcome/welcome_Screen.dart';
// import 'package:citydiscovertourist/screen/profile/profile.dart';
// import 'package:dio/dio.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:travel_hour/controllers/home_controller.dart';
import 'package:travel_hour/controllers/login_controller_V2.dart';
import 'package:travel_hour/models/purchased_quest.dart';
import 'package:travel_hour/models/quest.dart';
import 'package:travel_hour/pages/home.dart';
import 'package:travel_hour/services/purchased_service.dart';
import 'dart:convert';
// import 'package:citydiscovertourist/api/api.dart';
// import 'package:citydiscovertourist/api/api_end_points.dart';

import '../api/api.dart';
import '../api/api_end_points.dart';
import '../models/customer.dart';
import '../pages/profile.dart';
import '../pages/sign_in.dart';
// import '../screen/login/login_screen.dart';

// import 'package:shared_preferences/shared_preferences.dart';

class HistoryController extends GetxController {
  var purchsedQuestList = List<PurchasedQuest>.empty().obs;
  var historyQuestList = List<Quest>.empty().obs;
var isLoading=false.obs;
 void onInit() async {
    super.onInit();
     await getPuschedQuests();
 }
 void onReady(){
  update();
 }



 getPuschedQuests() async {
  try{
    isLoading(true);
 var quest_typeListApi = await PurchasedService.fetchPurchasedQuests(Get.find<LoginControllerV2>().sp.id.toString(),0,
        Get.find<LoginControllerV2>().jwtToken.value);
    if (quest_typeListApi != null) {
      print('Co Roi Ne');
      purchsedQuestList.assignAll(quest_typeListApi);
    }
    return purchsedQuestList;
  }finally{
    isLoading(false);
  }
    
  }
}
