import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:intl/intl.dart';
import 'package:travel_hour/models/customer.dart';
import 'package:travel_hour/routes/app_routes.dart';
import 'package:travel_hour/services/login_service.dart';
import 'package:device_info_plus/device_info_plus.dart';

import '../models/city.dart';
import '../models/quest.dart';
import '../models/quest_type.dart';
import '../services/city_service.dart';
import '../services/quest_service.dart';
import '../services/questtype_service.dart';

class SearchController extends GetxController {
  var isLoading = true.obs;
  var questList = List<Quest>.empty().obs;
  var textSearch="".obs;
  TextEditingController textFieldCtrl = TextEditingController();

  @override
  void onInit() async {
    super.onInit();
  }

  @override
  Future<void> onReady() async {
    super.onReady();
    ever(textSearch, (_){
      fetchQuestFeatureData();
    });
  }

  @override
  void onClose() {}
   void fetchQuestFeatureData() async {
    try {
      isLoading(true);
      var questListApi = await QuestService.fetchQuestFeatureDataV2(textSearch.value);
      if (questListApi?.length!=0) {
        questList.assignAll(questListApi!);
      }else{
        questList.clear();
      }
    } finally {
      isLoading(false);
    }
  }
}
