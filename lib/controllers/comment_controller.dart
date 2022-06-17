import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:travel_hour/models/comment.dart';
import 'package:travel_hour/services/comment_service.dart';

import '../services/app_service.dart';
import '../utils/toast.dart';

class Comment_Controller extends GetxController {
  var dataComment = List<Comment>.empty().obs;
  //Lưu vị trí của comment cuối của danh sách limit
  var lastVisible = 0.obs;
  //Màn hình loading
  var isLoading = false.obs;
  var isMoreLoading=false.obs;
  //Kiểm tra có data hay không
  var hasData = false.obs;
  //Biến Comment và rating
  var rating = 1.obs;
  var comment = "".obs;

  @override
  void onInit() async {
    super.onInit();
    getCommentData();
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
    getCommentData();
  }

  void getCommentData() async {
    try {
      // if(!isMoreLoading.value){
        // print("FALSE NÈ");
      isLoading(true);
      // }
      print("object HELLOOO");
      //Dòng này bỏ vô test hiệu ứng đợi vì dg dùng data fake nên ko test dc
   await   Future.delayed(Duration(seconds: 2));
      var commentApi = await CommentService.fetchCommentsData(1);
      if (commentApi != null) {
        print("COMMENT_CONTROLLER: Have data Comment");
        if (dataComment.isEmpty || lastVisible.value == 0) {
          dataComment.assignAll(commentApi);
        } //Nếu không thì nhét hết vô
        else {
          dataComment = RxList.from(dataComment)..addAll(commentApi);
        } //nếu dataComment đã có sẵn dữ liệu thì nối lại
        //Gán vị trí cuối cùng
        lastVisible.value = dataComment.length - 1;
      }
    } finally {
      isLoading(false);
      isMoreLoading(false);
    }
  }

  handleSubmit(String commentStr, BuildContext context) async {
    if (commentStr.isEmpty) {
      print('Comment is empty');
    } else {
      await AppService().checkInternet().then((hasInternet) {
        if (hasInternet == false) {
          openToast(context, 'no internet');
        } else {
          comment.value = commentStr;
          //PushComment
          CommentService.pushComment(comment.value);
          refeshData();
        }
      });
    }
  }
}
