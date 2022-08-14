import 'package:get/get.dart';
import 'package:travel_hour/controllers/home_controller.dart';
import 'package:travel_hour/controllers/login_controller_V2.dart';
import 'package:travel_hour/models/customer_quest.dart';
import 'package:travel_hour/models/quest_detail.dart';
import 'package:travel_hour/services/quest_service.dart';

import '../models/quest.dart';

class HistoryController extends GetxController {
  var isLoading = false.obs;
  // var quantity=1.obs;
  var historyQuestList = List<CustomerQuest>.empty().obs;

  // var total;
  @override
  void onInit() async {
    isLoading(true);
    // print('InitController'+questDetail.id.toString());
  //  print('ON3090  ${areaIdChoice}');
  await fetchPlayingHistory(Get.find<LoginControllerV2>().sp.id);
    super.onInit();

  }

  @override
  void onReady() async {
    //  print('OnreadyController'+questDetail!.id.toString());
    // fetchQuestDetailById();
// ever(qu)
    super.onReady();

  }

  @override
  void onClose() async {
    super.onClose();
  }
refeshData(){
  fetchPlayingHistory(Get.find<LoginControllerV2>().sp.id);
}
   fetchPlayingHistory(String customerId) async {
    try {
      isLoading(true);
  print("customerId "+customerId);
     var historyData= await QuestService.fetchPlayedQuestFeatureData(customerId);
     if(historyData!=null){
        historyQuestList.assignAll(historyData);
     }
    } finally {
      isLoading(false);
    }
  }
}
