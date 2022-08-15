// import 'package:flutter/cupertino.dart';
// import 'package:get/get.dart';
// import 'package:get/get_state_manager/src/simple/get_controllers.dart';
// import 'package:travel_hour/controllers/history_controller.dart';
// import 'package:travel_hour/controllers/play_controllerV2.dart';
// import 'package:travel_hour/models/comment.dart';
// import 'package:travel_hour/services/comment_service.dart';

// import '../services/app_service.dart';
// import '../utils/toast.dart';
// import 'login_controller_V2.dart';

// class CommentControllerV2 extends GetxController {
//   var dataComment = List<Comment>.empty().obs;

//   @override
//   void onInit() async {
//     super.onInit();
   
//   }

//   @override
//   void onReady() async {
//     super.onReady();
   
//   }

//   @override
//   void onClose() async {
//     super.onClose();
//   }

//   void refeshData() {

//   }

//   getCommentData() async {
//  try {
//       var commentApi = await CommentService.fetchCommentsData(
//           indexPage.value,
//           Get.find<LoginControllerV2>().jwtToken.value,
//           Get.find<LoginControllerV2>().sp.id,
//           idQuest.value);
//       if (commentApi != null) {
//         // hasData(true);
//         print("COMMENT_CONTROLLER: Have data Comment");
//          dataComment.assignAll(commentApi);
//       }
//     } finally {
//       update();
//     }
//   }


//   }

