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
              title: Column(
                children: [
                  BigText(
                    text:
                        controller.cusTask.currentPoint.truncate().toString() +
                            "xp",
                    fontWeight: FontWeight.bold,
                  ),
                  SmallText(
                    text: 'Câu hỏi số '+'${controller.numQuest}',
                    color: Colors.white,
                  )
                ],
              ),
              actions: [IconButton(onPressed: () {}, icon: Icon(Icons.menu))],
            ),
            body: Stack(
              children: [
                SingleChildScrollView(
                  child: Column(
                    children: [
                      Align(
                        alignment: Alignment.topRight,
                        child: InkWell(
                            onTap: () {
                              controller.showSuggestion();
                              showAlertDialog(
                                  context, controller.sugggestion.value);
                            },
                            child: Icon(Icons.notifications)),
                      ),
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
                                            "Bạn hãy tìm và chụp ảnh của giống với ảnh bên dưới nhé(Vui lòng cho app sử dụng camera của bạn)",
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
                                  controller.isDisableTextField.isTrue?
                                  Padding(padding: const EdgeInsets.all(20.0),child: BigText(text: controller
                                                            .currentAns.value),):SizedBox.shrink(),
                                  Padding(
                                    padding: const EdgeInsets.all(20.0),
                                    child:
                                        // Obx(() =>
                                        controller.questItemCurrent
                                                    .questItemTypeId ==
                                                2||controller.isDisableTextField.isTrue
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
                               SizedBox(height: 30,)
                                ],

                                
                              ),
                              SizedBox(height: 30,)
                            ]),
                      )
                    ],
                  ),
                ),
                Positioned(
                    bottom: 0,
                    left: 0,
                    right: 0,
                    child: Obx(() => controller.isDisableTextField.isTrue
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
                            child: Text('submit'.tr,
                                style: TextStyle(fontSize: 16)),
                            style: ElevatedButton.styleFrom(
                              primary: Colors.redAccent,
                              onPrimary: Colors.white,
                              padding: const EdgeInsets.only(
                                  left: 40.0,
                                  top: 16.0,
                                  bottom: 16.0,
                                  right: 40.0),
                              shape: RoundedRectangleBorder(
                                borderRadius:
                                    BorderRadius.circular(12), // <-- Radius
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
                              if(controller.currentAns.isEmpty){
                                controller.currentAns.value="N/A";
                              }
                              myController.text = "";
                              // }
                              controller.clickAnswer();
                            },
                            child: Text('submit'.tr,
                                style: TextStyle(fontSize: 16)),
                            style: ElevatedButton.styleFrom(
                              primary: Colors.redAccent,
                              onPrimary: Colors.white,
                              padding: const EdgeInsets.only(
                                  left: 40.0,
                                  top: 16.0,
                                  bottom: 16.0,
                                  right: 40.0),
                              shape: RoundedRectangleBorder(
                                borderRadius:
                                    BorderRadius.circular(12), // <-- Radius
                              ),
                            ),
                          )))
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