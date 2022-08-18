import 'package:get/get.dart';
import 'package:travel_hour/controllers/login_controller_V2.dart';
import 'package:travel_hour/models/customer_quest.dart';
import 'package:travel_hour/services/quest_service.dart';

class HistoryController extends GetxController {
  var isLoading = false.obs;
  // var quantity=1.obs;
  var historyQuestList = List<CustomerQuest>.empty().obs;

  // var total;
  @override
  void onInit() async {
    isLoading(true);
  await fetchPlayingHistory(Get.find<LoginControllerV2>().sp.id);
    super.onInit();

  }

  @override
  void onReady() async {
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
     var historyData= await QuestService.fetchPlayedQuestFeatureData(customerId);
     if(historyData!=null){
        historyQuestList.assignAll(historyData);
     }
    } finally {
      isLoading(false);
    }
  }
}
