import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class LanguegeController extends GetxController {
  void changeLanguage(String language) {
    Get.updateLocale(Locale(language));
  }
}
