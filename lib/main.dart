import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:get/get_navigation/src/routes/transitions_type.dart';
import 'package:travel_hour/controllers/home_controller.dart';
import 'package:travel_hour/controllers/login_controller_V2.dart';
import 'package:travel_hour/routes/app_pages.dart';
import 'package:travel_hour/routes/app_routes.dart';
import 'package:travel_hour/utils/tranlations.dart';

import 'app.dart';
import 'bindings/home_binding.dart';
import 'bindings/login_binding.dart';
import 'controllers/login_controller.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  // Get.put(LoginController(), permanent: true);
// Get.lazyPut(() => HomeController(),fenix: true);
  Get.put(
    LoginControllerV2(),
    permanent: true,
  );

  runApp(GetMaterialApp(
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
