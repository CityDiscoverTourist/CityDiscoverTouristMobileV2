import 'package:get/get.dart';
import 'package:travel_hour/controllers/home_controller.dart';
import 'package:travel_hour/models/quest_detail.dart';
import 'package:travel_hour/services/quest_service.dart';

class QuestDetailController extends GetxController {
   late QuestDetail questDetail;
  var isLoading = false.obs;
  // var quantity=1.obs;
  var idQuestCurrent=0.obs;
  var total;
  @override
  void onInit() async {
    // isLoading(true);
    // print('InitController'+questDetail.id.toString());
     isLoading(true);
idQuestCurrent.value=int.parse(Get.parameters['idQuest'].toString());
    try {
     
      var questDetailData =
          await QuestService.fetchQuestDetailById(idQuestCurrent.value);
      if (questDetailData != null) {
        questDetail = questDetailData;
      }
    } finally {
      isLoading(false);
    }
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

  fetchQuestDetailById() async {
    try {
      isLoading(true);
      var questDetailData =
          await QuestService.fetchQuestDetailById(questDetail.id);
      if (questDetailData != null) {
        questDetail = questDetailData;
      }
    } finally {
      isLoading(false);
    }
  }
}
