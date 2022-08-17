import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';
import 'package:smooth_star_rating_null_safety/smooth_star_rating_null_safety.dart';
import 'package:travel_hour/controllers/comment_controller.dart';
import 'package:travel_hour/controllers/login_controller_V2.dart';
import 'package:travel_hour/controllers/play_controllerV2.dart';
import 'package:travel_hour/pages/splashV2.dart';
import 'package:travel_hour/utils/dialog.dart';
import 'package:travel_hour/widgets/big_text.dart';
import 'package:travel_hour/widgets/small_text.dart';

import '../config/colors.dart';
import '../controllers/questpurchased_controller.dart';
import '../routes/app_routes.dart';
import '../widgets/app_header_feedback.dart';
import '../widgets/custom_appbar.dart';

// class CompletedPageV2 extends GetView<PlayControllerV2> {
//   const CompletedPageV2({Key? key}) : super(key: key);
class CompletedPageV2 extends StatefulWidget {
  const CompletedPageV2({
    Key? key,
  }) : super(key: key);

  @override
  CompletedPageV2State createState() => CompletedPageV2State();
}

class CompletedPageV2State extends State<CompletedPageV2> {
  var controller = Get.find<PlayControllerV2>();
  var commentController = Get.find<CommentController>();
  var textCtrl = TextEditingController();
  double ratingStar = 4;
  bool firstTime = true;
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    print(controller.endPoint.percentDiscount);
    if (controller.endPoint.percentDiscount != 0 && firstTime) {
      Future.delayed(
          Duration.zero,
          () =>
              // showAlertVoucher(context,controller)
              showPromotionDialog(
                  context, controller.endPoint.percentDiscount));
      firstTime = false;
    }
    return Scaffold(
        body: SingleChildScrollView(
            child: Stack(
      children: [
        AppHeader(),
        Positioned(
            top: -380,
            left: -187,
            child: Icon(
              Icons.backspace,
            )),
        SafeArea(
            child: Padding(
          padding: EdgeInsets.all(36),
          child: Column(
            children: [
              SizedBox(
                height: 40,
              ),
              CustomAppBar(),
              SizedBox(
                height: 60,
              ),
              ClipOval(
                child: Get.find<LoginControllerV2>().sp.imagePath != null
                    ? Image.network(
                        Get.find<LoginControllerV2>().sp.imagePath.toString(),
                        width: 150,
                        height: 150,
                        fit: BoxFit.cover,
                      )
                    : Image.network(
                        "https://img.freepik.com/free-vector/businessman-character-avatar-isolated_24877-60111.jpg?w=2000",
                        width: 150,
                        height: 150,
                        fit: BoxFit.cover,
                      ),
              ),
              SizedBox(
                height: 20,
              ),
              // SmallText(text: "completed quest"),
              BigText(
                  text: "complete quest: ".tr + controller.pQuest.questName),
              Divider(
                color: Colors.black,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  PlayInfo(
                      title: "time".tr, value: controller.displayTime.value),
                  PlayInfo(
                      title: "point".tr,
                      value: controller.endPoint.endPoint.toString() +
                          "/" +
                          controller.endPoint.beginPoint.toString()),
                  // PlayInfo(title: "Tỷ lệ", value: "75%")
                ],
              ),
              Divider(
                color: Colors.black,
              ),
              SizedBox(
                height: 20,
              ),
              SmallText(text: Get.find<LoginControllerV2>().sp.userName),
              BigText(
                text: "how is your trip?".tr,
                fontWeight: FontWeight.bold,
                size: 24,
              ),
              SmoothStarRating(
                  allowHalfRating: false,
                  onRatingChanged: (v) async {
                    setState(() {
                      ratingStar = v;
                    });
                    commentController.rating.value = ratingStar.toInt();
                    print("Comments_V2:" +
                        commentController.rating.value.toString());
                  },
                  starCount: 5,
                  rating: ratingStar,
                  size: 40.0,
                  // filledIconData: Icons.blur_off,
                  // halfFilledIconData: Icons.blur_on,
                  color: Colors.green,
                  borderColor: Colors.green,
                  spacing: 20),
              Container(
                padding: EdgeInsets.all(18),
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(12.0),
                    boxShadow: [
                      BoxShadow(
                        blurRadius: 15,
                        offset: const Offset(0.0, 15.0),
                        color: Colors.black.withAlpha(20),
                      )
                    ]),
                child: Form(
                  child: TextFormField(
                    controller: textCtrl,
                    keyboardType: TextInputType.text,
                    autofocus: false,
                    onFieldSubmitted: (value) {
                      textCtrl.text = value;
                      commentController.comment.value = value;
                    },
                    decoration: InputDecoration(
                        border: InputBorder.none,
                        hintText: 'rating quest'.tr,
                        hintStyle: TextStyle(color: Colors.grey)),
                  ),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Row(mainAxisAlignment: MainAxisAlignment.end, children: [
                BigText(
                  text: 'submitComment'.tr,
                  fontWeight: FontWeight.bold,
                  color: AppColors.mainColor,
                ),
                SizedBox(
                  width: 20,
                ),
                Container(
                  width: 50.0,
                  height: 50.0,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(25.0)),
                      color: AppColors.mainColor),
                  child: IconButton(
                    icon: Icon(Icons.arrow_forward),
                    onPressed: () async {
                      await commentController.handleSubmit(
                          textCtrl.text,
                          context,
                          Get.find<PlayControllerV2>().customerQuestID.value);

                      Get.offAllNamed(KWelcomeScreen);
                    },
                    color: Colors.white,
                  ),
                )
              ])
            ],
          ),
        ))
      ],
    )));
  }
}

class PlayInfo extends StatelessWidget {
  const PlayInfo({
    required this.title,
    required this.value,
    Key? key,
  }) : super(key: key);
  final String title, value;

  @override
  Widget build(BuildContext context) {
    return RichText(
        text: TextSpan(children: [
      TextSpan(
          text: title + "\n",
          style: TextStyle(
            color: Colors.grey,
            fontSize: 14,
          )),
      TextSpan(
          text: value,
          style: TextStyle(color: AppColors.mainColor, fontSize: 18)),
    ]));
  }
}

showAlertVoucher(BuildContext context, PlayControllerV2 controller) {
  // Create button
  Widget okButton = FlatButton(
    child: Text("cofirm".tr),
    onPressed: () {
      // Get.to(RulePage(
      //   pQuest: pQuest,
      // ));
      //  vao trang huong dan
      Navigator.of(context).pop();
      // Get.find<PlayControllerV2>().isCancel.value=true;
      // Get.delete<PlayControllerV2>();
    },
  );
  Widget cancelButton = FlatButton(
    child: Text("cancel".tr),
    onPressed: () {
      Navigator.of(context).pop();
    },
  );

  // Create AlertDialog
  AlertDialog alert = AlertDialog(
    title: Text("congratulations".tr),
    content: Column(
      // mainAxisAlignment: MainAxisAlignment.center,
      children: [
        BigText(text: "You received a discount code".tr),
        BigText(text: controller.endPoint.percentDiscount.toString() + "%")
      ],
    ),
    actions: [okButton, cancelButton],
  );

  // show the dialog
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return alert;
    },
  );
}

void showPromotionDialog(context, percentDiscount) {
  showGeneralDialog(
      barrierLabel: 'label',
      barrierDismissible: true,
      barrierColor: Colors.black.withOpacity(0.5),
      transitionDuration: Duration(milliseconds: 300),
      context: context,
      transitionBuilder: (context, anim1, anim2, child) {
        return SlideTransition(
          position:
              Tween(begin: Offset(0, 1), end: Offset(0, 0)).animate(anim1),
          child: child,
        );
      },
      pageBuilder: (context, anim1, anim2) {
        return Align(
          alignment: Alignment.center,
          child: Container(
            height: 500,
            width: 350,
            padding: EdgeInsets.symmetric(vertical: 15, horizontal: 20),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(15),
            ),
            child: Material(
              child: Container(
                color: Colors.white,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    // Row(
                    //   mainAxisAlignment:
                    //       MainAxisAlignment.spaceBetween,
                    //   children: [
                    //     SizedBox.shrink(),
                    //     IconButton(
                    //         icon: Icon(Icons.cancel),
                    //         onPressed: () {
                    //           Navigator.pop(context);

                    //         })
                    //   ],
                    // ),
                    Image.asset(
                      'assets/images/giftbox.gif',
                      height: 200,
                    ),
                    Text(
                      "Discount " + percentDiscount.toString() + "%",
                      style: TextStyle(
                        color: Color(0xff81cffc),
                        fontWeight: FontWeight.bold,
                        fontSize: 25,
                      ),
                    ),
                    Text(
                      "You get a discount code for your next order".tr,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Colors.black54,
                        fontSize: 15,
                      ),
                    ),
                    Container(
                      height: 50,
                      width: 235,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(30),
                      ),
                      child: Material(
                        borderRadius: BorderRadius.circular(30),
                        color: Colors.red,
                        child: MaterialButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Expanded(
                                  child: Text(
                                "cofirm".tr,
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  fontSize: 20,
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                ),
                              ))
                            ],
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
        );
      });
}
