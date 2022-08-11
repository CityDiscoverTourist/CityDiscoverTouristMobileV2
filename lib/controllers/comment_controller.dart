import 'package:flutter/cupertino.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:travel_hour/controllers/questpurchased_controller.dart';
import 'package:travel_hour/controllers/play_controllerV2.dart';
import 'package:travel_hour/models/comment.dart';
import 'package:travel_hour/services/comment_service.dart';

import '../services/app_service.dart';
import '../utils/toast.dart';
import 'login_controller_V2.dart';

class CommentController extends GetxController {
  var dataComment = List<Comment>.empty().obs;
  //Lưu vị trí của comment cuối của danh sách limit
  var lastVisible = false.obs;
  //Màn hình loading
  var isLoading = false.obs;
  var isMoreLoading = true.obs;
  //
  var indexPage = 1.obs;
  //
  var idQuest = 0.obs;

  //Kiểm tra có data hay không
  var hasData = false.obs;
  //Biến Comment và rating
  var indexCount = 1.obs;

  var rating = 1.obs;
  var comment = "".obs;
  var isCommented = 0.obs;
  late Comment myComment;
  @override
  void onInit() async {
    super.onInit();
    await getCommentData();
    // var check = Get.isRegistered<CommentController>(tag: "noty");
    // if (check == true) print("Hoan HÔ");
  }

  @override
  void onReady() async {
    super.onReady();
    ever(indexCount,
        (_) async => {print("change"),isMoreLoading(true), await getCommentData(), update()});
  }

  @override
  void onClose() async {
    super.onClose();
  }

  void increaseIndex() {
 if(lastVisible.isFalse){
    indexCount++;
 }
    else{ Fluttertoast.showToast(
        msg: "Hết dữ liệu",  // message
        toastLength: Toast.LENGTH_SHORT, // length
        gravity: ToastGravity.CENTER,    // location
        timeInSecForIosWeb: 1              // duration
    );}
    print('increaseIndex'+indexCount.toString());

  }

  void refeshData() {
    lastVisible(false);
    isMoreLoading.value = true;
    indexPage.value=1;
    dataComment.clear();
    getCommentData();
  }

  getCommentData() async {
    try {
      // if(!isMoreLoading.value){
      isLoading(true);
      
      print("FALSE NÈ" + lastVisible.value.toString());
      indexPage++;
      print(indexPage.value);
      // }
      print("object HELLOOO");
      await Future.delayed(Duration(seconds: 1));
      var commentApi = await CommentService.fetchCommentsData(indexCount.value,
          Get.find<LoginControllerV2>().jwtToken.value, idQuest.value);
      if (commentApi!.length!=0) {
        if (dataComment.length==0) {
          dataComment.assignAll(commentApi);
          print("If 1 nè");
        } //Nếu không thì nhét hết vô
        else {
          print("ELSSU");
          dataComment = RxList.from(dataComment)..addAll(commentApi);
        } //nếu dataComment đã có sẵn dữ liệu thì nối lại
        //Gán vị trí cuối cùng

        // lastVisible.value = dataComment.length - 1;
        //  update();
      } else {
        lastVisible(true);
      }
    } finally {
      isLoading(false);
      // isMoreLoading(false);
      update();
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
            if(commentStr.isEmpty){
              print("N/A");
              // comment.value='N/A';
            }else{
            comment.value = commentStr;
            }

            // PushComment
            await CommentService.pushComment(
                comment.value, rating.value,customerQuestID.toString());
            // refeshData();
          }
        });
      }
    } finally {
      Get.delete<PlayControllerV2>();
      Get.delete<QuestPurchasedController>();
      isLoading(false);
    }
  }
}
