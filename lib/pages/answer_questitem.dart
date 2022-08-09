import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';
import 'package:line_icons/line_icons.dart';
import 'package:status_view/status_view.dart';
import 'package:travel_hour/controllers/play_controller.dart';
import 'package:travel_hour/controllers/play_controllerV2.dart';
import 'package:travel_hour/models/questItem.dart';
import 'package:travel_hour/pages/splashV2.dart';
import 'package:travel_hour/widgets/big_text.dart';
import 'package:travel_hour/widgets/small_text.dart';

import '../controllers/chat_controller.dart';
import 'chat.dart';

class AnswerPage extends StatelessWidget {
  AnswerPage({Key? key}) : super(key: key);
  //   @override
  // Widget build(BuildContext context) {
  //   final myController = TextEditingController();
  //   var controller=Get.find<PlayControllerV2>();
  //   return Scaffold(
  //       body: Obx((){
  //         if(controller.isLoading.value==true){
  //           return SplashStart();
  //         }else
  //         return
  //         Column(mainAxisAlignment: MainAxisAlignment.center,children: [Text(controller.questItemCurrent.description)]);
  //       }
  //       )
  //       );
  // }
  final myController = TextEditingController();
  var controller = Get.find<PlayControllerV2>();
  @override
  Widget build(BuildContext context) {
    return Obx(() => controller.isLoading.value == true
        ? SplashStart()
        : Scaffold(
            appBar: AppBar(
              backgroundColor: Colors.redAccent,
              centerTitle: true,
              automaticallyImplyLeading: false,
              title: Column(
                children: [
                  BigText(
                    text:
                        controller.cusTask.currentPoint.truncate().toString() +
                            "xp",
                    fontWeight: FontWeight.bold,
                  ),
                  SmallText(
                    text: 'question no'.tr + ' ${controller.numQuest}',
                    color: Colors.white,
                  )
                ],
              ),
              actions: [
                controller.isDisableTextField.isFalse
                    ? IconButton(
                        onPressed: () {
                          controller.showSuggestion();
                          showAlertDialogCofirmShowSuggestion(
                              context, controller.sugggestion.value);
                        },
                        icon: Icon(Icons.notifications))
                    : SizedBox.shrink(),
                SizedBox(
                  width: 10,
                ),
                IconButton(
                    onPressed: () {
                      Get.put(ChatController());
                      Get.to(ChatScreen());
                    },
                    icon: Icon(
                      Icons.support_agent,
                      color: Colors.white,
                    )),
                IconButton(
                    onPressed: () {
                      showAlertDialogCofirmSkip(context);
                    },
                    icon: Icon(
                      Icons.skip_next,
                      color: Colors.white,
                    )),
              ],
            ),
            bottomNavigationBar: BottomAppBar(
                child: SizedBox(
              height: 70,
              child: controller.isDisableTextField.isTrue
                  ? ElevatedButton(
                      onPressed: () {
                        // if (controller.isDisableTextField.isTrue)
                        myController.text = controller.currentAns.value;
                        // else {
                        //   controller.currentAns.value =
                        //           myController.text;
                        //   myController.text = "";
                        // }
                        controller.clickAnswer();
                      },
                      child: Text('submit'.tr, style: TextStyle(fontSize: 16)),
                      style: ElevatedButton.styleFrom(
                        primary: Colors.redAccent,
                        onPrimary: Colors.white,
                        padding: const EdgeInsets.only(
                            left: 40.0, top: 16.0, bottom: 16.0, right: 40.0),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12), // <-- Radius
                        ),
                      ),
                    )
                  : ElevatedButton(
                      onPressed: () {
                        // if (controller.isDisableTextField.isFalse)
                        // myController.text =
                        //     controller.currentAns.value;
                        // else {
                        controller.currentAns.value = myController.text;
                        if (controller.currentAns.isEmpty) {
                          controller.currentAns.value = "N/A";
                        }
                        myController.text = "";
                        // }
                        controller.clickAnswer();
                      },
                      child: Text('submit'.tr, style: TextStyle(fontSize: 16)),
                      style: ElevatedButton.styleFrom(
                        primary: Colors.redAccent,
                        onPrimary: Colors.white,
                        padding: const EdgeInsets.only(
                            left: 40.0, top: 16.0, bottom: 16.0, right: 40.0),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12), // <-- Radius
                        ),
                      ),
                    ),
            )),
            body: Stack(
              children: [
                SingleChildScrollView(
                  child: Column(
                    children: [
                      // controller.isDisableTextField.isFalse
                      //     ? Align(
                      //         alignment: Alignment.topRight,
                      //         child: InkWell(
                      //             onTap: () {
                      //               controller.showSuggestion();
                      //               showAlertDialog(
                      //                   context, controller.sugggestion.value);
                      //             },
                      //             child: Icon(Icons.notifications)),
                      //       )
                      //     : SizedBox.shrink(),
                      SizedBox(
                        height: 10,
                      ),
                      // Center(
                      //   child: BigText(
                      //       text: 'NUM OF QUESTION '.tr +
                      //           controller.questItemCurrent.id.toString()),
                      // ),
                      // SizedBox(
                      //   height: 10,
                      // ),
                      // BigText(
                      //   text: controller.cusTask.currentPoint.toString(),
                      //   fontWeight: FontWeight.w800,
                      // ),
                      // SizedBox(
                      //   height: 30,
                      // ),
                      Center(
                        child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              controller.questItemCurrent.questItemTypeId == 2
                                  ? SingleChildScrollView(
                                      child: Column(children: [
                                      BigText(
                                        text:
                                            "please find and take a photo of something similar to the one below (please let the app use your camera)"
                                                .tr,
                                        fontWeight: FontWeight.bold,
                                      ),
                                      Image.network(
                                          controller
                                              .questItemCurrent.listImages[1],
                                          width: 400,
                                          height: 400,
                                          fit: BoxFit.fill)
                                    ]))
                                  : Text(controller.questItemCurrent.content),
                              SizedBox(height: 30),
                              Column(
                                children: [
                                  controller.isDisableTextField.isTrue
                                      ? Padding(
                                          padding: const EdgeInsets.all(20.0),
                                          child: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                children: [
                                                  BigText(
                                                    text: "right answer".tr,
                                                    fontWeight: FontWeight.bold,
                                                  ),
                                                  Icon(
                                                    Icons.check,
                                                    size: 16,
                                                    color: Colors.green,
                                                  )
                                                ],
                                              ),
                                              SizedBox(
                                                height: 20,
                                              ),
                                              Container(
                                                margin: EdgeInsets.all(10),
                                                decoration: BoxDecoration(
                                                    color: Colors.grey[300],
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            15)),
                                                height: 50,
                                                width: double.infinity,
                                                child: Center(
                                                  child: Padding(
                                                    padding: EdgeInsets.all(20),
                                                    child: BigText(
                                                        text: controller
                                                            .currentAns.value),
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        )
                                      : SizedBox.shrink(),
                                  Padding(
                                    padding: const EdgeInsets.all(20.0),
                                    child:

                                        // Obx(() =>
                                        controller.questItemCurrent
                                                        .questItemTypeId ==
                                                    2 ||
                                                controller
                                                    .isDisableTextField.isTrue
                                            ? Container()
                                            : TextField(
                                                controller: myController,
                                                readOnly: controller
                                                    .isDisableTextField.value,
                                                decoration: InputDecoration(
                                                    border:
                                                        OutlineInputBorder(),
                                                    labelText: controller
                                                            .isDisableTextField
                                                            .isTrue
                                                        ? controller
                                                            .currentAns.value
                                                        : ''),
                                              ),
                                    // ),
                                  ),
                                  // controller.isDisableTextField.isTrue
                                  //     ? ElevatedButton(
                                  //         onPressed: () {
                                  //           // if (controller.isDisableTextField.isTrue)
                                  //           myController.text =
                                  //               controller.currentAns.value;
                                  //           // else {
                                  //           //   controller.currentAns.value =
                                  //           //       myController.text;
                                  //           //   myController.text = "";
                                  //           // }
                                  //           controller.clickAnswer();
                                  //         },
                                  //         child: Text('submit'.tr,
                                  //             style:
                                  //                 TextStyle(fontSize: 16)),
                                  //         style: ElevatedButton.styleFrom(
                                  //           padding: const EdgeInsets.only(
                                  //               left: 40.0,
                                  //               top: 16.0,
                                  //               bottom: 16.0,
                                  //               right: 40.0),
                                  //           shape: RoundedRectangleBorder(
                                  //             borderRadius:
                                  //                 BorderRadius.circular(
                                  //                     12), // <-- Radius
                                  //           ),
                                  //         ),
                                  //       )
                                  //     : ElevatedButton(
                                  //         onPressed: () {
                                  //           // if (controller.isDisableTextField.isFalse)
                                  //           // myController.text =
                                  //           //     controller.currentAns.value;
                                  //           // else {
                                  //           controller.currentAns.value =
                                  //               myController.text;
                                  //           myController.text = "";
                                  //           // }
                                  //           controller.clickAnswer();
                                  //         },
                                  //         child: Text('submit'.tr,
                                  //             style:
                                  //                 TextStyle(fontSize: 16)),
                                  //         style: ElevatedButton.styleFrom(
                                  //           padding: const EdgeInsets.only(
                                  //               left: 40.0,
                                  //               top: 16.0,
                                  //               bottom: 16.0,
                                  //               right: 40.0),
                                  //           shape: RoundedRectangleBorder(
                                  //             borderRadius:
                                  //                 BorderRadius.circular(
                                  //                     12), // <-- Radius
                                  //           ),
                                  //         ),
                                  //       )
                                  SizedBox(
                                    height: 30,
                                  )
                                ],
                              ),
                              SizedBox(
                                height: 30,
                              )
                            ]),
                      )
                    ],
                  ),
                ),
                // Positioned(
                //     bottom: 0,
                //     left: 0,
                //     right: 0,
                //     child: Obx(() =>
                //      controller.isDisableTextField.isTrue
                //         ? ElevatedButton(
                //             onPressed: () {
                //               // if (controller.isDisableTextField.isTrue)
                //               myController.text = controller.currentAns.value;
                //               // else {
                //               //   controller.currentAns.value =
                //               //           myController.text;
                //               //   myController.text = "";
                //               // }
                //               controller.clickAnswer();
                //             },
                //             child: Text('submit'.tr,
                //                 style: TextStyle(fontSize: 16)),
                //             style: ElevatedButton.styleFrom(
                //               primary: Colors.redAccent,
                //               onPrimary: Colors.white,
                //               padding: const EdgeInsets.only(
                //                   left: 40.0,
                //                   top: 16.0,
                //                   bottom: 16.0,
                //                   right: 40.0),
                //               shape: RoundedRectangleBorder(
                //                 borderRadius:
                //                     BorderRadius.circular(12), // <-- Radius
                //               ),
                //             ),
                //           )
                //         : ElevatedButton(
                //             onPressed: () {
                //               // if (controller.isDisableTextField.isFalse)
                //               // myController.text =
                //               //     controller.currentAns.value;
                //               // else {
                //               controller.currentAns.value = myController.text;
                //               if(controller.currentAns.isEmpty){
                //                 controller.currentAns.value="N/A";
                //               }
                //               myController.text = "";
                //               // }
                //               controller.clickAnswer();
                //             },
                //             child: Text('submit'.tr,
                //                 style: TextStyle(fontSize: 16)),
                //             style: ElevatedButton.styleFrom(
                //               primary: Colors.redAccent,
                //               onPrimary: Colors.white,
                //               padding: const EdgeInsets.only(
                //                   left: 40.0,
                //                   top: 16.0,
                //                   bottom: 16.0,
                //                   right: 40.0),
                //               shape: RoundedRectangleBorder(
                //                 borderRadius:
                //                     BorderRadius.circular(12), // <-- Radius
                //               ),
                //             ),
                //           )))
              ],
            )));
  }
}

showAlertDialog(BuildContext context, String sugg) {
  // Create button
  Widget okButton = FlatButton(
    child: Text("ok".tr),
    onPressed: () {
      // Get.to(RulePage(
      //   pQuest: pQuest,
      // ));
      //  vao trang huong dan
      Navigator.of(context).pop();
    },
  );
  // Widget cancelButton = FlatButton(
  //   child: Text("Hủy"),
  //   onPressed: () {
  //     Navigator.of(context).pop();
  //   },
  // );

  // Create AlertDialog
  AlertDialog alert = AlertDialog(
    title: Text("suggestion".tr),
    content: BigText(
      text: sugg,
    ),
    actions: [okButton],
  );

  // show the dialog
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return alert;
    },
  );
}

showAlertDialogCofirmShowSuggestion(BuildContext context, String sugg) {
  // Create button
  Widget okButton = FlatButton(
    child: Text("ok".tr),
    onPressed: () {
      // Get.to(RulePage(
      //   pQuest: pQuest,
      // ));
      //  vao trang huong dan
      Navigator.of(context).pop();
      showAlertDialog(context, sugg);
    },
  );
  Widget cancelButton = FlatButton(
    child: Text("Hủy"),
    onPressed: () {
      Navigator.of(context).pop();
    },
  );

  // Create AlertDialog
  AlertDialog alert = AlertDialog(
    title:
        Text("do you want to show suggestion(you will be minus 75 point)".tr),
    content: BigText(
      text: sugg,
    ),
    actions: [okButton],
  );

  // show the dialog
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return alert;
    },
  );
}

showAlertDialogCofirmSkip(BuildContext context) async {
  // Create button
  Widget okButton = FlatButton(
    child: Text("ok".tr),
    onPressed: () async {
      Get.find<PlayControllerV2>().isSkip.value = true;
      Get.find<PlayControllerV2>().clickAnswer();
      Navigator.of(context).pop();
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
    title: Text("cofirm".tr),
    content: Text("do you want to skip this question?".tr),
    actions: [okButton, cancelButton],
  );
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return alert;
    },
  );
}

void showCustomDialog(BuildContext context, String? sugg) {
  showGeneralDialog(
    context: context,
    barrierLabel: "Barrier",
    barrierDismissible: true,
    barrierColor: Colors.black.withOpacity(0.5),
    transitionDuration: Duration(milliseconds: 700),
    pageBuilder: (_, __, ___) {
      return Center(
        child: Container(
          height: 240,
          child: SizedBox.expand(
              child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              BigText(
                text: sugg!,
                size: 28,
              )
            ],
          )),
          margin: EdgeInsets.symmetric(horizontal: 20),
          decoration: BoxDecoration(
              color: Colors.white, borderRadius: BorderRadius.circular(40)),
        ),
      );
    },
    transitionBuilder: (_, anim, __, child) {
      Tween<Offset> tween;
      if (anim.status == AnimationStatus.reverse) {
        tween = Tween(begin: Offset(-1, 0), end: Offset.zero);
      } else {
        tween = Tween(begin: Offset(1, 0), end: Offset.zero);
      }

      return SlideTransition(
        position: tween.animate(anim),
        child: FadeTransition(
          opacity: anim,
          child: child,
        ),
      );
    },
  );
}

//  body: GetBuilder<PlayController>(
//       builder: (controller) {
//         return Center(
//           child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
//             Text(controller.questItemCurrent.name),
//             TextField(
//               controller: myController,
//             ),
//             ElevatedButton(
//               onPressed: () {
//                 controller.currentAns.value = myController.text;
//                 myController.text = "";
//                 controller.clickAnswer();
//               },
//               child: Text('Submit', style: TextStyle(fontSize: 16)),
//               style: ElevatedButton.styleFrom(
//                 padding: const EdgeInsets.only(
//                     left: 40.0, top: 16.0, bottom: 16.0, right: 40.0),
//                 shape: RoundedRectangleBorder(
//                   borderRadius: BorderRadius.circular(12), // <-- Radius
//                 ),
//               ),
//             ),
//           ]),
//         );
//       },
//     )