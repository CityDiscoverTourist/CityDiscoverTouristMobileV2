// import 'package:citydiscovertourist/models/customer.dart';
// import 'package:citydiscovertourist/screen/welcome/welcome_Screen.dart';
// import 'package:citydiscovertourist/screen/profile/profile.dart';
// import 'package:dio/dio.dart';
import 'package:get/get.dart';
import 'package:travel_hour/controllers/login_controller_V2.dart';
import 'package:travel_hour/models/purchased_quest.dart';
import 'package:travel_hour/services/purchased_service.dart';
// import '../screen/login/login_screen.dart';

// import 'package:shared_preferences/shared_preferences.dart';

class QuestPurchasedController extends GetxController {
  List purchsedQuestList = List<PurchasedQuest>.empty().obs;
  var isLoading = false.obs;
  var qrCode="".obs;
  void onInit() async {
    super.onInit();
    await getPuschedQuests();
    qrCode.value="";
  }

  void onReady() {
    update();
  }

  getPuschedQuests() async {
    try {
      isLoading(true);
      var quest_typeListApi = await PurchasedService.fetchPurchasedQuests(
          Get.find<LoginControllerV2>().sp.id.toString(),
          Get.find<LoginControllerV2>().language.value,
          Get.find<LoginControllerV2>().jwtToken.value);
      if (quest_typeListApi != null) {
        purchsedQuestList.assignAll(quest_typeListApi);
      }
      return purchsedQuestList;
    } finally {
      isLoading(false);
    }
  }
}
