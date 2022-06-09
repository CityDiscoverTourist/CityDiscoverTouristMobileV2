import 'package:get/get.dart';

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
  @override
  void onInit() async {
    super.onInit();
    fetchQuestFeatureData();
    fetchCityData();
    fetchQuestTypeData();
  }

  @override
  void onReady() {
    super.onReady();
    //Reload list quest by city
    ever(cityChoice,(_)=>{print("HOME CONTROLLER: "+"Text Id City OnChange - "+cityChoice.toString())});

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
}
