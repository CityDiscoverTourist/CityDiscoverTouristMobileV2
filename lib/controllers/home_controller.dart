import 'package:get/get.dart';
import 'package:travel_hour/controllers/login_controller_V2.dart';
import 'package:travel_hour/models/reward.dart';
import 'package:travel_hour/services/reward_service.dart';

// import 'package:showcaseview/showcaseview.dart';
import '../models/city.dart';
import '../models/quest.dart';
import '../models/quest_type.dart';
import '../pages/splashV2.dart';
import '../services/city_service.dart';
import '../services/quest_service.dart';
import '../services/questtype_service.dart';

class HomeController extends GetxController {
  var isLoading = true.obs;
  // var isStartTest = true.obs;
  var questList = List<Quest>.empty().obs;
  // var puQuestList = List<Quest>.empty().obs;
  // var hisQuestList = List<Quest>.empty().obs;
  var cityList = List<City>.empty().obs;
  var rewardList = List<Reward>.empty().obs;
  var questTypeList = List<QuestType>.empty().obs;
  var areaIdChoice = 4.obs;
  var indexHomePage = 0.obs;
  var language = Get.find<LoginControllerV2>().language;
  var jwtToken = "".obs;

  var idQuestCurrent = 0.obs;
  var dropdownValue;
  // late GoogleSignIn googleSign;
  // var isSignIn = false.obs;
  // FirebaseAuth firebaseAuth = FirebaseAuth.instance;
  String deviceId = ""; //*
   

  @override
  void onInit() async {
    super.onInit();
    // changeLanguage();
    await startData();
    dropdownValue = cityList[1];
  }

  @override
  void onReady() async {
    super.onReady();
    // changeLanguage();
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

              updateData(),
              update(),
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
      // await fetchPlayingHistory(Get.find<LoginControllerV2>().sp.id);
      // await fetchRewardByCustomerId(Get.find<LoginControllerV2>().sp.id);
    } finally {
      isLoading(false);
    }
  }

  updateData() async {
    try {
      isLoading(true);
       await fetchCityData();
      await fetchQuestFeatureData();
      await fetchQuestTypeData();
       dropdownValue = cityList[1];
    } finally {
      isLoading(false);
    }
  }

  fetchQuestFeatureData() async {
    // try {
    //   isLoading(true);
    var questListApi = await QuestService.fetchQuestFeatureData(
        areaIdChoice.value, language.value);
    if (questListApi != null) {
      questList.assignAll(questListApi);
    }
    // } finally {
    //   isLoading(false);
    // }
  }

  // static const AndroidNotificationChannel channel = AndroidNotificationChannel(
  //     'high_importance_channel', // id
  //     'High Importance Notifications', // title
  //     description:
  //         'This channel is used for important notifications.', // description
  //     importance: Importance.high,
  //     playSound: true);

  // final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
  //     FlutterLocalNotificationsPlugin();

  fetchCityData() async {
    // try {
    //   isLoading(true);
    var cityListApi = await CityService().fetchCityData();
    if (cityListApi != null) {
      cityList.assignAll(cityListApi);
    }
    // } finally {
    //   isLoading(false);
    // }
  }

  fetchQuestTypeData() async {
    // try {
    //   isLoading(true);

    var questTypeListApi = await QuestTypeService.fetchQuestTypeData(
        Get.find<LoginControllerV2>().jwtToken.value);
    if (questTypeListApi != null) {
      questTypeList.assignAll(questTypeListApi);
    }
  
  }

  

  Future<Quest?> getQuestDetailByID(String questId) async {
    try {
      isLoading(true);
      return await QuestService.fetchQuestDetail(
          questId, Get.find<LoginControllerV2>().language.value);
    } finally {
      isLoading(false);
    }
  }

  // fetchPlayingHistory(String customerId) async {
  //   try {
  //     isLoading(true);

  //     await QuestService.fetchPlayedQuestFeatureData(customerId);
  //   } finally {
  //     isLoading(false);
  //   }
  // }

  fetchRewardByCustomerId(String customerId) async {
    try {
      // if (isLoading.value == false) {
      //   isLoading.value = true;
      // }
      SplashStart(
        content: 'waiting loading data...'.tr,
      );
      await RewardService.fetchRewardByCustomerId(customerId);
    } finally {
      isLoading(false);
    }
  }
}
