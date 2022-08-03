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
import 'package:travel_hour/widgets/big_text.dart';
import 'package:travel_hour/widgets/rounded_button.dart';
import 'package:travel_hour/widgets/small_text.dart';

import '../controllers/history_controller.dart';
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
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
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
                    : Image.asset(
                        'assets/images/logo.png',
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
                      value: controller.cusTask.currentPoint.toString()),
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
                    commentController.rating.value = v.toInt();
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
                  text: 'submit'.tr,
                  fontWeight: FontWeight.bold,
                  color: Colors.redAccent,
                ),
                SizedBox(
                  width: 20,
                ),
                Container(
                  width: 50.0,
                  height: 50.0,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(25.0)),
                      color: Colors.redAccent),
                  child: IconButton(
                    icon: Icon(Icons.arrow_forward),
                    onPressed: () async {
                      await commentController.handleSubmit(
                          textCtrl.text,
                          context,
                          Get.find<PlayControllerV2>().customerQuestID.value);

                      Get.toNamed(KWelcomeScreen);
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
          style: TextStyle(color: Colors.grey, fontSize: 14)),
      TextSpan(
          text: value, style: TextStyle(color: Colors.redAccent, fontSize: 18)),
    ]));
  }
}
