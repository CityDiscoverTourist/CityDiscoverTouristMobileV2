import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:get/get.dart';
import 'package:travel_hour/controllers/comment_controller.dart';
import 'package:travel_hour/controllers/login_controller_V2.dart';
import 'package:travel_hour/routes/app_pages.dart';
import 'package:travel_hour/routes/app_routes.dart';
import 'package:travel_hour/utils/tranlations.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  
  final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();
     const AndroidNotificationChannel channel = AndroidNotificationChannel(
      'high_importance_channel', // id
      'High Importance Notifications', // title
      description:
          'This channel is used for important notifications.', // description
      importance: Importance.high,
      playSound: true);
  flutterLocalNotificationsPlugin
        .resolvePlatformSpecificImplementation<
            AndroidFlutterLocalNotificationsPlugin>()
        ?.createNotificationChannel(channel);
    FirebaseMessaging.instance.setForegroundNotificationPresentationOptions(
      alert: true,
      badge: true,
      sound: true,
    );
     FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      // ignore: avoid_print
      // Get.put(LoginControllerV2(),tag: "noty");
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
  // Get.put(LoginController(), permanent: true);
// Get.put( CommentController(),tag: "noty");
  Get.put(
    LoginControllerV2(),
    permanent: true,
  );

  runApp(GetMaterialApp(
    debugShowCheckedModeBanner: false,
    translations: Translation(),
    locale: Locale('vn'),
    fallbackLocale: Locale('vn'),
    // It is not mandatory to use named routes, but dynamic urls are interesting.
    initialRoute: KSplashScreen,
    defaultTransition: Transition.native,
    //  translations: MyTranslations(),
    getPages: AppPages.getPages(),
    // initialBinding: LoginBinding(),
  ));
}
