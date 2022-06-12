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
  // WidgetsFlutterBinding.ensureInitialized();
  // await Firebase.initializeApp();
  // SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
  //     statusBarColor: Colors.transparent,
  //     statusBarIconBrightness: Brightness.dark));
  // WidgetsFlutterBinding.ensureInitialized();
  // await EasyLocalization.ensureInitialized();
  // runApp(EasyLocalization(
  //   supportedLocales: [Locale('en'), Locale('es'), Locale('ar')],
  //   path: 'assets/translations',
  //   fallbackLocale: Locale('en'),
  //   startLocale: Locale('en'),
  //   useOnlyLangCode: true,
  //   child: MyApp(),
  // ));
  // LoginBinding().dependencies();
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  Get.put(LoginController(), permanent: true);
  Get.put(LoginControllerV2(), permanent: true);
    Get.put(HomeController(), permanent: true);
  // LoginController controller = new LoginController();
  // controller.checkUserLoggedIn();

  runApp(GetMaterialApp(
    translations: Translation(),
    locale: Locale('en'),
    fallbackLocale: Locale('en'),
    // It is not mandatory to use named routes, but dynamic urls are interesting.
    initialRoute: KSplashScreen,
    defaultTransition: Transition.native,
    //  translations: MyTranslations(),
    getPages: AppPages.getPages(),
    initialBinding: LoginBinding(),
    //Hello fen
    //HOWAREU
  ));
  // var controller = Get.find<LoginController>();
  // controller.checkUserLoggedIn();
}
