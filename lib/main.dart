import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'bindings/home_binding.dart';
import 'routes/app_pages.dart';
import 'routes/app_routes.dart';



void main() {
  runApp(
    GetMaterialApp(
    // It is not mandatory to use named routes, but dynamic urls are interesting.
    initialRoute:KWelcomeScreen,
    defaultTransition: Transition.native,
  //  translations: MyTranslations(),
    getPages: AppPages.getPages(),
    initialBinding: HomeBinding(),
  ));
}