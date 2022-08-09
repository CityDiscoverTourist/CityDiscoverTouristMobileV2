import 'package:get/get.dart';
import 'package:travel_hour/controllers/home_controller.dart';
import 'package:travel_hour/models/quest_detail.dart';
import 'package:travel_hour/services/quest_service.dart';

import '../models/quest.dart';

class LoadQuestController extends GetxController {
    var questList = List<Quest>.empty().obs;
    var areaIdChoice=0.obs;
    var questTypeId=0.obs;
  var isLoading = false.obs;
  // var quantity=1.obs;
  // var total;
  @override
  void onInit() async {
    isLoading(true);
    // print('InitController'+questDetail.id.toString());
    areaIdChoice.value=int.parse(Get.parameters['idArea'].toString());
   questTypeId.value=int.parse(Get.parameters['idQuestType'].toString());
  //  print('ON3090  ${areaIdChoice}');
    try {
        var questListApi = await QuestService.fetchQuestDataByType(
        areaIdChoice.value, questTypeId.value);
    if (questList != null) {
      print('Co Roi Ne');
      questList.assignAll(questListApi!);
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

 
}
