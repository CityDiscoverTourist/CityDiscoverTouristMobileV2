import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:travel_hour/models/customer.dart';
import 'package:travel_hour/routes/app_routes.dart';
import 'package:travel_hour/services/login_service.dart';

import '../models/city.dart';
import '../models/quest.dart';
import '../models/quest_type.dart';
import '../services/city_service.dart';
import '../services/quest_service.dart';
import '../services/questtype_service.dart';

class HomeController extends GetxController {
  var isLoading = true.obs;
  var questList = List<Quest>.empty().obs;
  var cityList = List<City>.empty().obs;
  var questTypeList = List<QuestType>.empty().obs;
  var cityChoice=1.obs;
  var indexHomePage=0.obs;

  late GoogleSignIn googleSign;
  var isSignIn = false.obs;
  FirebaseAuth firebaseAuth = FirebaseAuth.instance;
  String deviceId = "";//*
  late Customer sp;

  @override
  void onInit() async {
    super.onInit();
    fetchQuestFeatureData();
    fetchCityData();
    fetchQuestTypeData();
  }

  @override
  Future<void> onReady() async {
    super.onReady();
    //Reload list quest by city
    ever(cityChoice,(_)=>{print("HOME CONTROLLER: "+"Text Id City OnChange - "+cityChoice.toString())});



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
}


