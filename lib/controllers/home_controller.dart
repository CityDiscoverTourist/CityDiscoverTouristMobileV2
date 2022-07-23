import 'dart:io';

import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:http/http.dart';
import 'package:intl/intl.dart';
import 'package:travel_hour/controllers/login_controller_V2.dart';
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

class HomeController extends GetxController {
  var isLoading = true.obs;
  // var isStartTest = true.obs;
  var questList = List<Quest>.empty().obs;
  var puQuestList = List<Quest>.empty().obs;
  var hisQuestList = List<Quest>.empty().obs;
  var cityList = List<City>.empty().obs;
  var questTypeList = List<QuestType>.empty().obs;
  var areaIdChoice = 4.obs;
  var indexHomePage = 0.obs;
  var language = 1.obs;
  var jwtToken = "".obs;

  var dropdownValue;
  // late GoogleSignIn googleSign;
  // var isSignIn = false.obs;
  // FirebaseAuth firebaseAuth = FirebaseAuth.instance;
  String deviceId = ""; //*

  @override
  void onInit() async {
    super.onInit();
    await startData();
    dropdownValue = cityList[1];
    flutterLocalNotificationsPlugin
        .resolvePlatformSpecificImplementation<
            AndroidFlutterLocalNotificationsPlugin>()
        ?.createNotificationChannel(channel);
    FirebaseMessaging.instance.setForegroundNotificationPresentationOptions(
      alert: true,
      badge: true,
      sound: true,
    );
    final FirebaseMessaging _fcm = FirebaseMessaging.instance;
    _fcm.getToken().then((token) => {
          print('[HomeController]-L57-The token ID||' + token!),
          deviceId = token
        });

    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      // ignore: avoid_print
      RemoteNotification? notification = message.notification;
      AndroidNotification? android = message.notification?.android;
      if (notification != null && android != null) {
        flutterLocalNotificationsPlugin.show(
            notification.hashCode,
            notification.title,
            notification.body,
            NotificationDetails(
              android: AndroidNotificationDetails(
                channel.id,
                channel.name,
                channelDescription: channel.description,
                color: Colors.blue,
                playSound: true,
                icon: '@mipmap/ic_launcher',
              ),
            ));
      }
    });
    // isStartTest(true);
  }

  @override
  void onReady() async {
    super.onReady();
    print("[HomeController]-L88-ONREADY :" + jwtToken.value);
    // googleSign = GoogleSignIn();
    // await ever(isSignIn, handleAuthStateChanged);
    // isSignIn.value = await firebaseAuth.currentUser != null;
    // firebaseAuth.authStateChanges().listen((event) {
    //   isSignIn.value = event != null;
    // });
    //Reload list quest by city
    ever(
        areaIdChoice,
        (_) => {
              print("[HomeController]-L99" +
                  "Text Id City OnChange - " +
                  areaIdChoice.toString()),
                  print(Get.find<LoginControllerV2>().sp.id),
              updateData(),
              update(),
            });
    ever(
        jwtToken,
        (_) => {
              print(
                "JWT change" + jwtToken.value,
              ),
            });
  }

  @override
  void onClose() {}
  startData() async {
    try {
      isLoading(true);
      await fetchCityData();
      await fetchQuestFeatureData();
      await fetchQuestTypeData();
    } finally {
      isLoading(false);
    }
  }

  updateData() async {
    try {
      isLoading(true);
      await fetchQuestFeatureData();
    } finally {
      isLoading(false);
    }
  }

  fetchQuestFeatureData() async {
    // try {
    //   isLoading(true);
    var questListApi = await QuestService.fetchQuestFeatureData(
        areaIdChoice.value, language.value);
    if (questList != null) {
      print('Co Roi Ne');
      questList.assignAll(questListApi!);
    }
    // } finally {
    //   isLoading(false);
    // }
  }

  static const AndroidNotificationChannel channel = AndroidNotificationChannel(
      'high_importance_channel', // id
      'High Importance Notifications', // title
      description:
          'This channel is used for important notifications.', // description
      importance: Importance.high,
      playSound: true);

  final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();

  fetchCityData() async {
    // try {
    //   isLoading(true);
    var cityListApi = await CityService().fetchCityData();
    if (cityListApi != null) {
      print('Co Roi Ne');
      cityList.assignAll(cityListApi);
    }
    // } finally {
    //   isLoading(false);
    // }
  }

  fetchQuestTypeData() async {
    // try {
    //   isLoading(true);

    var quest_typeListApi = await QuestTypeService.fetchQuestTypeData(
        Get.find<LoginControllerV2>().jwtToken.value);
    if (quest_typeListApi != null) {
      print('Co Roi Ne');
      questTypeList.assignAll(quest_typeListApi);
    }
    // } finally {
    //   isLoading(false);
    // }
  }

  // void handleAuthStateChanged(isLoggedIn) async {
  //   print("[HomeController]-L162-DeviceID:" + deviceId);
  //   if (isLoggedIn) {
  //     print("[HomeController]-L164: ");
  //     sp = await LoginService().apiCheckLogin(
  //         await firebaseAuth.currentUser!.getIdToken(), deviceId);
  //     if (sp != null)
  //       Get.offAllNamed(KWelcomeScreen, arguments: firebaseAuth.currentUser);
  //     else {
  //       await googleSign.disconnect();
  //       await firebaseAuth.signOut();
  //     }
  //   } else {
  //     Get.offAllNamed(KLoginScreen);
  //   }
  // }

  void getPuQuestByCustomerID(String customerId) async {
    try {
      isLoading(true);
      changeLanguage();
      var questListApi =
          await QuestService.fetchPuQuestFeatureData(customerId, language);
      if (questListApi != null) {
        print('Co Roi Ne');
        puQuestList.assignAll(questListApi);
      }
    } finally {
      isLoading(false);
    }
  }

  void changeLanguage() async {
    try {
      isLoading(true);
      Locale? locale = Get.locale;
      print(locale);
      if (locale.toString() == "en") {
        language.value = 0;
        print(language);
        // update();
      } else {
        language.value = 1;
        print(language);
        // update();
      }
    } finally {
      isLoading(false);
    }
  }

  void getQuestDetailByID(String questId) async {
    try {
      isLoading(true);
      changeLanguage();
      print(language);
      await QuestService.fetchQuestDetail(questId, language.value);
    } finally {
      isLoading(false);
    }
  }
}
