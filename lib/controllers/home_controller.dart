import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';
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
  var questList = List<Quest>.empty().obs;
  var puQuestList = List<Quest>.empty().obs;
  var cityList = List<City>.empty().obs;
  var questTypeList = List<QuestType>.empty().obs;
  var cityChoice = 1.obs;
  var indexHomePage = 0.obs;

  late GoogleSignIn googleSign;
  var isSignIn = false.obs;
  FirebaseAuth firebaseAuth = FirebaseAuth.instance;
  String deviceId = ""; //*
  late Customer sp;

  @override
  void onInit() async {
    super.onInit();
    fetchQuestFeatureData();
    fetchCityData();
    fetchQuestTypeData();
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
    _fcm
        .getToken()
        .then((token) => {print('The token||' + token!), deviceId = token});

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
  }

  @override
  Future<void> onReady() async {
    super.onReady();
    //Reload list quest by city
    ever(
        cityChoice,
        (_) => {
              print("HOME CONTROLLER: " +
                  "Text Id City OnChange - " +
                  cityChoice.toString())
            });

    googleSign = GoogleSignIn();
    ever(isSignIn, handleAuthStateChanged);
    isSignIn.value = await firebaseAuth.currentUser != null;
    firebaseAuth.authStateChanges().listen((event) {
      isSignIn.value = event != null;
    });
  }

  @override
  void onClose() {}
  void fetchQuestFeatureData() async {
    try {
      isLoading(true);
      var questListApi = await QuestService.fetchQuestFeatureData();
      if (questList != null) {
        print('Co Roi Ne');
        questList.assignAll(questListApi!);
      }
    } finally {
      isLoading(false);
    }
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

  void fetchCityData() async {
    try {
      isLoading(true);
      var cityListApi = await CityService.fetchCityData();
      if (cityListApi != null) {
        print('Co Roi Ne');
        cityList.assignAll(cityListApi);
      }
    } finally {
      isLoading(false);
    }
  }

  void fetchQuestTypeData() async {
    try {
      isLoading(true);
      var quest_typeListApi = await QuestTypeService.fetchQuestTypeData();
      if (quest_typeListApi != null) {
        print('Co Roi Ne');
        questTypeList.assignAll(quest_typeListApi);
      }
    } finally {
      isLoading(false);
    }
  }

  void handleAuthStateChanged(isLoggedIn) async {
    print("Token trong HAM: " + deviceId);
    if (isLoggedIn) {
      sp = await LoginService().apiCheckLogin(
          await firebaseAuth.currentUser!.getIdToken(), deviceId);
      if (sp != null)
        Get.offAllNamed(KWelcomeScreen, arguments: firebaseAuth.currentUser);
      else {
        await googleSign.disconnect();
        await firebaseAuth.signOut();
      }
    } else {
      Get.offAllNamed(KLoginScreen);
    }
  }

  void _getQuestByCustomerID(String id) async {
    try {
      isLoading(true);
      var questListApi = await QuestService.fetchQuestFeatureData();
      if (questListApi != null) {
        print('Co Roi Ne');
        questList.assignAll(questListApi);
      }
    } finally {
      isLoading(false);
    }
  }
}