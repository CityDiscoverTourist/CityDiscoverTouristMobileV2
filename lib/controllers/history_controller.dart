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
import 'package:travel_hour/models/quest.dart';
import 'package:travel_hour/pages/home.dart';
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
  var purchsedQuestList = List<Quest>.empty().obs;
  var historyQuestList = List<Quest>.empty().obs;
  Future<List> getPuschedQuests() async {
    String collectionName = 'puschedquests';
    String type = 'pusched quests';

    SharedPreferences sp = await SharedPreferences.getInstance();
    String? _uid = sp.getString('uid');
    Map data2 = {'tokenId': _uid};
    var body = json.encode(data2);
    return purchsedQuestList;
  }
}
