import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:travel_hour/controllers/history_controller.dart';
import 'package:travel_hour/controllers/play_controllerV2.dart';
import 'package:travel_hour/models/comment.dart';
import 'package:travel_hour/services/comment_service.dart';

import '../services/app_service.dart';
import '../utils/toast.dart';
import 'login_controller_V2.dart';

class CommentController extends GetxController {
  var dataComment = List<Comment>.empty().obs;
  //Lưu vị trí của comment cuối của danh sách limit
  var lastVisible = 0.obs;
  //Màn hình loading
  var isLoading = false.obs;
  //
  var indexPage = 0.obs;
  //
  var idQuest = 0.obs;
  var isMoreLoading = false.obs;
  //Kiểm tra có data hay không
  var hasData = false.obs;
  //Biến Comment và rating
  var rating = 1.obs;
  var comment = "".obs;
 var isCommented=0.obs;
 late Comment myComment;
  @override
  void onInit() async {
    super.onInit();
    await getCommentData();
  var check=Get.isRegistered<CommentController>(tag: "noty");
    if(check==true) print("Hoan HÔ");
  }

  @override
  void onReady() async {
    super.onReady();
      
  }

  @override
  void onClose() async {
    super.onClose();
  }

  void refeshData() {
    lastVisible.value = 0;
    isMoreLoading.value = false;
    getCommentData();
  }

  getCommentData() async {
    try {
      // if(!isMoreLoading.value){
      // print("FALSE NÈ");
      isLoading(true);
      indexPage++;
      print(indexPage.value);
      // }
      print("object HELLOOO");
      await Future.delayed(Duration(seconds: 1));
      var commentApi = await CommentService.fetchCommentsData(
          indexPage.value,
          Get.find<LoginControllerV2>().jwtToken.value,
          Get.find<LoginControllerV2>().sp.id,
          idQuest.value);
      if (commentApi != null) {
        // hasData(true);
        print("COMMENT_CONTROLLER: Have data Comment");
           var commentCus= await CommentService.fetchCommentByCustomerId(Get.find<LoginControllerV2>().jwtToken.value,  Get.find<LoginControllerV2>().sp.id, idQuest.value);
      if(commentCus!=null){
        myComment=commentCus;
        isCommented.value=1;
        print("hihi");
      }
       await Future.delayed(Duration(seconds: 1));
        if (dataComment.isEmpty || lastVisible.value == 0) {
          dataComment.assignAll(commentApi);
          print("If 1 nè");
        } //Nếu không thì nhét hết vô
        else {
          dataComment = RxList.from(dataComment)..addAll(commentApi);
        } //nếu dataComment đã có sẵn dữ liệu thì nối lại
        //Gán vị trí cuối cùng
        lastVisible.value = dataComment.length - 1;
        update();
      } else {}
    } finally {
      isLoading(false);
      isMoreLoading(false);
    }
  }

  handleSubmit(
      String commentStr, BuildContext context, int customerQuestID) async {
    try {
      isLoading(true);
      if (commentStr.isEmpty) {
        print('Comment is empty');
      } else {
        await AppService().checkInternet().then((hasInternet) async {
          if (hasInternet == false) {
            openToast(context, 'no internet');
          } else {
            print("Handld Sm");
            comment.value = commentStr;

            //PushComment
            // await CommentService.pushComment(
            //     comment.value, customerQuestID, rating.value);
            // refeshData();
          }
        });
      }
    } finally {
      Get.delete<PlayControllerV2>();
      Get.delete<HistoryController>();
      isLoading(false);
    }
  }
}
