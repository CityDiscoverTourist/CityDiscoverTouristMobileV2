import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:travel_hour/controllers/play_controllerV2.dart';
import 'package:travel_hour/pages/splashV2.dart';
import 'package:travel_hour/widgets/big_text.dart';
import 'package:travel_hour/widgets/small_text.dart';

import '../config/colors.dart';
import '../controllers/chat_controller.dart';
import '../controllers/comment_controller.dart';
import 'chat.dart';
import 'completed_questV2.dart';

class AnswerPage extends StatelessWidget {
  AnswerPage({Key? key}) : super(key: key);
  final myController = TextEditingController();
  var controller = Get.find<PlayControllerV2>();
  @override
  Widget build(BuildContext context) {
    return Obx(() => controller.isLoading.value == true
        ? SplashStart()
        : WillPopScope(
            onWillPop: () async {
              showAlertDialogCofirmOut(context);
              return false;
            },
            child: Scaffold(
                backgroundColor: Colors.white,
                appBar:
                    //Man ans
                    controller.indexTypePage.value == 1
                        ? AppBar(
                            backgroundColor: AppColors.mainColor,
                            centerTitle: true,
                            automaticallyImplyLeading: false,
                            title: Column(
                              children: [
                                BigText(
                                  text: controller.cusTask.currentPoint
                                          .truncate()
                                          .toString() +
                                      "xp",
                                  fontWeight: FontWeight.bold,
                                ),
                                SmallText(
                                  text: 'question no'.tr +
                                      ' ${controller.numQuest}' +
                                      "/${controller.totalQuestItem}",
                                  color: Colors.white,
                                )
                              ],
                            ),
                            // actions: [
                            //   controller.isDisableTextField.isFalse
                            //       ? IconButton(
                            //           onPressed: () {
                            //             if (controller.haveSuggestion.isTrue) {
                            //               if (controller
                            //                   .isShowSuggestion.isTrue) {
                            //                 showAlertDialog(context,
                            //                     controller.sugggestion.value);
                            //               } else {
                            //                 showAlertDialogCofirmShowSuggestion(
                            //                     context, controller);
                            //               }
                            //             } else {
                            //               Fluttertoast.showToast(
                            //                   msg: "Cau hoi chua co goi y"
                            //                       .tr, // message
                            //                   toastLength:
                            //                       Toast.LENGTH_SHORT, // length
                            //                   gravity: ToastGravity
                            //                       .CENTER, // location
                            //                   timeInSecForIosWeb: 1 // duration
                            //                   );
                            //             }
                            //           },
                            //           icon: Icon(Icons.notifications))
                            //       : SizedBox.shrink(),
                            //   SizedBox(
                            //     width: 10,
                            //   ),
                            //   Stack(
                            //     children: [
                            //       IconButton(
                            //           onPressed: () {
                            //             Get.put(ChatController());
                            //             Get.to(ChatScreen());
                            //           },
                            //           icon: Icon(
                            //             Icons.support_agent,
                            //             color: Colors.white,
                            //           )),
                            //       // Positioned(
                            //       //   top: 0,
                            //       //   right: 14,

                            //       //   child: SizedBox(
                            //       //     height: 15,
                            //       //     width: 15,
                            //       //     child: CircleAvatar(radius: 80,backgroundColor: Colors.yellow,)))
                            //     ],
                            //   ),
                            //   controller.isDisableTextField.isFalse
                            //       ? IconButton(
                            //           onPressed: () {
                            //             showAlertDialogCofirmSkip(context);
                            //           },
                            //           icon: Icon(
                            //             Icons.skip_next,
                            //             color: Colors.white,
                            //           ))
                            //       : SizedBox.shrink()
                            // ],
                          )
                        : AppBar(
                            backgroundColor: AppColors.mainColor,
                            title: Text(controller.indexTypePage.value == 2
                                ? 'description page'.tr
                                : 'story page'.tr),
                            automaticallyImplyLeading: false),
                bottomNavigationBar: Container(
                  padding: EdgeInsets.only(
                    bottom: MediaQuery.of(context).viewInsets.bottom,
                  ),
                  child: BottomAppBar(
                    child: Row(
                      mainAxisAlignment: controller.indexTypePage.value == 1
                          ? MainAxisAlignment.spaceAround
                          : MainAxisAlignment.center,
                      children: [
                        controller.indexTypePage.value == 1
                            ? Row(
                                children: [
                                  controller.isDisableTextField.isFalse
                                      ? IconButton(
                                          onPressed: () {
                                            if (controller
                                                .haveSuggestion.isTrue) {
                                              if (controller
                                                  .isShowSuggestion.isTrue) {
                                                showAlertDialog(
                                                    context,
                                                    controller
                                                        .sugggestion.value);
                                              } else {
                                                showAlertDialogCofirmShowSuggestion(
                                                    context, controller);
                                              }
                                            } else {
                                              Fluttertoast.showToast(
                                                  msg: "Cau hoi chua co goi y"
                                                      .tr, // message
                                                  toastLength: Toast
                                                      .LENGTH_SHORT, // length
                                                  gravity: ToastGravity
                                                      .CENTER, // location
                                                  timeInSecForIosWeb:
                                                      1 // duration
                                                  );
                                            }
                                          },
                                          icon: Icon(Icons.notifications))
                                      : SizedBox.shrink(),
                                  SizedBox(
                                    width: 10,
                                  ),
                                  Stack(
                                    children: [
                                      IconButton(
                                          onPressed: () {
                                            Get.put(ChatController());
                                            Get.to(ChatScreen());
                                          },
                                          icon: Icon(
                                            Icons.support_agent,
                                            color: Colors.black,
                                          )),
                                      // Positioned(
                                      //   top: 0,
                                      //   right: 14,

                                      //   child: SizedBox(
                                      //     height: 15,
                                      //     width: 15,
                                      //     child: CircleAvatar(radius: 80,backgroundColor: Colors.yellow,)))
                                    ],
                                  ),
                                  controller.isDisableTextField.isFalse
                                      ? IconButton(
                                          onPressed: () {
                                            showAlertDialogCofirmSkip(context);
                                          },
                                          icon: Icon(
                                            Icons.skip_next,
                                            color: Colors.black,
                                          ))
                                      : SizedBox.shrink(),
                                ],
                              )
                            : SizedBox.shrink(),
                        SizedBox(
                          width: MediaQuery.of(context).size.width * 0.6,
                          height: 70,
                          child: controller.indexTypePage.value == 0 ||
                                  controller.indexTypePage.value == 2
                              ? ElevatedButton(
                                  onPressed: () {
                                    if (controller.indexTypePage.value == 0) {
                                      // Get.to(AnswerPage());
                                      controller.indexTypePage.value = 1;
                                    } else {
                                      if (controller.isFinished.isTrue) {
                                        Get.lazyPut(() => CommentController());
                                        Get.to(CompletedPageV2());
                                      } else {
                                        controller.numQuest++;
                                        // Get.to(StoryDescription());
                                        controller.indexTypePage.value = 0;
                                      }
                                    }
                                  },
                                  child: Text(
                                      controller.isFinished.isTrue
                                          ? 'finish'.tr
                                          : 'next'.tr,
                                      style: TextStyle(fontSize: 16)),
                                  style: ElevatedButton.styleFrom(
                                    primary: AppColors.mainColor,
                                    onPrimary: Colors.white,
                                    padding: const EdgeInsets.only(
                                        left: 40.0,
                                        top: 16.0,
                                        bottom: 16.0,
                                        right: 40.0),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(
                                          12), // <-- Radius
                                    ),
                                  ),
                                )
                              : controller.isDisableTextField.isTrue &&
                                      controller.indexTypePage.value == 1
                                  ? ElevatedButton(
                                      onPressed: () {
                                        // if (controller.isDisableTextField.isTrue)
                                        myController.text =
                                            controller.currentAns.value;
                                        // else {
                                        //   controller.currentAns.value =
                                        //           myController.text;
                                        //   myController.text = "";
                                        // }
                                        // controller.currentAns.value="";
                                        controller.clickAnswer();
                                        myController.text = "";
                                      },
                                      child: Text('submit'.tr,
                                          style: TextStyle(fontSize: 16)),
                                      style: ElevatedButton.styleFrom(
                                        primary: AppColors.mainColor,
                                        onPrimary: Colors.white,
                                        padding: const EdgeInsets.only(
                                            left: 40.0,
                                            top: 16.0,
                                            bottom: 16.0,
                                            right: 40.0),
                                        shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(
                                              12), // <-- Radius
                                        ),
                                      ),
                                    )
                                  : ElevatedButton(
                                      onPressed: () {
                                        controller.currentAns.value =
                                            myController.text;
                                        if (controller.currentAns.isEmpty) {
                                          controller.currentAns.value = "N/A";
                                        }
                                        myController.text = "";
                                        // }
                                        controller.clickAnswer();
                                      },
                                      child: Text('submit'.tr,
                                          style: TextStyle(fontSize: 16)),
                                      style: ElevatedButton.styleFrom(
                                        primary: AppColors.mainColor,
                                        onPrimary: Colors.white,
                                        padding: const EdgeInsets.only(
                                            left: 40.0,
                                            top: 16.0,
                                            bottom: 16.0,
                                            right: 40.0),
                                        shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(
                                              12), // <-- Radius
                                        ),
                                      ),
                                    ),
                        ),
                      ],
                    ),
                  ),
                ),
                body: GestureDetector(
                  onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
                  child: Stack(
                    children: [
                      SingleChildScrollView(
                        child: controller.indexTypePage.value == 0 ||
                                controller.indexTypePage.value == 2
                            ? Column(
                                children: [
                                  SingleChildScrollView(
                                    child: Html(
                                      data: controller.indexTypePage.value == 2
                                          ? controller.description
                                          : controller.questItemCurrent.story,
                                      style: {
                                        'html': Style(
                                            // backgroundColor: Colors.white12
                                            ),
                                        'table': Style(
                                            backgroundColor:
                                                Colors.grey.shade200),
                                        'td': Style(
                                          padding: EdgeInsets.all(10),
                                        ),
                                        'th': Style(
                                            padding: EdgeInsets.all(10),
                                            color: Colors.black),
                                        'tr': Style(
                                            border: Border(
                                                bottom: BorderSide(
                                                    color:
                                                        Colors.greenAccent))),
                                        // 'p class=\"ql-align-center\"': Style(
                                        //     alignment: Alignment.center,
                                        //     textAlign: TextAlign.center,
                                        //     margin: EdgeInsets.only(left: 30),
                                        //     backgroundColor: Colors.grey.shade300,
                                        //     border: Border(
                                        //         bottom: BorderSide(
                                        //             color: Colors.greenAccent))),
                                        'img': Style(
                                            // after: 'p',
                                            alignment: Alignment.center,
                                            textAlign: TextAlign.center,
                                            fontSize: FontSize.xxLarge,
                                            backgroundColor:
                                                Colors.grey.shade300,
                                            border: Border(
                                                bottom: BorderSide(
                                                    color:
                                                        Colors.greenAccent))),

                                        'p': Style(
                                          // before: '          ',
                                          // alignment: Alignment.center,
                                          textAlign: TextAlign.justify,
                                          fontSize: FontSize.xxLarge,

                                          // border: Border(
                                          //     bottom: BorderSide(
                                          //         color: Colors.greenAccent)
                                          // )
                                        ),
                                      },
                                    ),
                                  ),
                                ],
                              )
                            : Column(
                                children: [
                                  SizedBox(
                                    height: 10,
                                  ),
                                  Center(
                                    child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          controller.questItemCurrent
                                                      .questItemTypeId ==
                                                  2
                                              ? SingleChildScrollView(
                                                  child: Column(children: [
                                                  Padding(
                                                    padding:
                                                        const EdgeInsets.all(
                                                            10.0),
                                                    child: Text(
                                                      controller
                                                          .questItemCurrent
                                                          .content,
                                                      textAlign:
                                                          TextAlign.justify,
                                                      style: TextStyle(
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        fontSize: 20,
                                                      ),
                                                    ),
                                                  ),
                                                  // BigText(
                                                  //   text:
                                                  //       "please find and take a photo of something similar to the one below (please let the app use your camera)"
                                                  //           .tr,
                                                  //   fontWeight: FontWeight.bold,
                                                  // ),
                                                  Image.network(
                                                      controller
                                                          .questItemCurrent
                                                          .listImages
                                                          .first,
                                                      width: 400,
                                                      height: 620,
                                                      fit: BoxFit.fill)
                                                ]))
                                              : SingleChildScrollView(
                                                  child: Column(children: [
                                                  Padding(
                                                    padding:
                                                        const EdgeInsets.all(
                                                            10.0),
                                                    child: Text(
                                                      controller
                                                          .questItemCurrent
                                                          .content,
                                                      textAlign:
                                                          TextAlign.justify,
                                                      style: TextStyle(
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        fontSize: 20,
                                                      ),
                                                    ),
                                                  ),
                                                  controller.questItemCurrent
                                                                  .imageDescription !=
                                                              "null" &&
                                                          controller
                                                                  .questItemCurrent
                                                                  .imageDescription !=
                                                              null
                                                      ? Image.network(
                                                          controller
                                                              .questItemCurrent
                                                              .imageDescription,
                                                          width: 400,
                                                          height: 620,
                                                          fit: BoxFit.fill)
                                                      : SizedBox.shrink()
                                                ])),
                                          //  Text(controller
                                          //     .questItemCurrent.content),
                                          SizedBox(height: 30),
                                          Column(
                                            children: [
                                              controller
                                                      .isDisableTextField.isTrue
                                                  ? Padding(
                                                      padding:
                                                          const EdgeInsets.all(
                                                              20.0),
                                                      child: Column(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .center,
                                                        children: [
                                                          Row(
                                                            mainAxisAlignment:
                                                                MainAxisAlignment
                                                                    .center,
                                                            children: [
                                                              BigText(
                                                                text:
                                                                    "right answer"
                                                                        .tr,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold,
                                                              ),
                                                              Icon(
                                                                Icons.check,
                                                                size: 16,
                                                                color: Colors
                                                                    .green,
                                                              )
                                                            ],
                                                          ),
                                                          SizedBox(
                                                            height: 20,
                                                          ),
                                                          Container(
                                                            margin:
                                                                EdgeInsets.all(
                                                                    10),
                                                            decoration: BoxDecoration(
                                                                color: Colors
                                                                    .grey[300],
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .circular(
                                                                            15)),
                                                            height: 50,
                                                            width:
                                                                double.infinity,
                                                            child: Center(
                                                              child: Padding(
                                                                padding:
                                                                    EdgeInsets
                                                                        .all(
                                                                            20),
                                                                child: BigText(
                                                                    text: controller
                                                                        .currentAns
                                                                        .value),
                                                              ),
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                    )
                                                  : SizedBox.shrink(),
                                              Padding(
                                                padding:
                                                    const EdgeInsets.all(20.0),
                                                child: controller
                                                                .questItemCurrent
                                                                .questItemTypeId ==
                                                            2 ||
                                                        controller
                                                            .isDisableTextField
                                                            .isTrue
                                                    ? Container()
                                                    : TextField(
                                                        controller:
                                                            myController,
                                                        readOnly: controller
                                                            .isDisableTextField
                                                            .value,
                                                        decoration: InputDecoration(
                                                            border:
                                                                OutlineInputBorder(),
                                                            labelText: controller
                                                                    .isDisableTextField
                                                                    .isTrue
                                                                ? controller
                                                                    .currentAns
                                                                    .value
                                                                : ''),
                                                      ),
                                              ),
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
                    ],
                  ),
                )),
          ));
  }
}

showAlertDialog(BuildContext context, String sugg) {
  // Create button
  Widget okButton = FlatButton(
    child: Text("cofirm".tr),
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

showAlertDialogCofirmShowSuggestion(
    BuildContext context, PlayControllerV2 playControllerV2) {
  // Create button
  Widget okButton = FlatButton(
    child: Text("cofirm".tr),
    onPressed: () {
      playControllerV2.showSuggestion();
      Navigator.of(context).pop();
      showAlertDialog(context, playControllerV2.sugggestion.value);
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
    content: BigText(
      text: "do you want to show suggestion(you will be minus 75 point)".tr,
    ),
    // actions: [okButton, cancelButton],
    actions: [cancelButton, okButton],
  );

  // show the dialog
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return alert;
    },
  );
}

showAlertDialogCofirmOut(BuildContext context) {
  // Create button
  Widget okButton = FlatButton(
    child: Text("cofirm".tr),
    onPressed: () {
      // Get.to(RulePage(
      //   pQuest: pQuest,
      // ));
      //  vao trang huong dan
      Navigator.of(context).pop();
      Get.find<PlayControllerV2>().isCancel.value = true;
      Get.delete<PlayControllerV2>();
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
    content: BigText(
      text: "You will lose this turn and cannot play again".tr,
    ),
    // actions: [okButton, cancelButton],
    actions: [cancelButton, okButton],
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
    child: Text("cofirm".tr),
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
    // actions: [okButton, cancelButton],
    actions: [cancelButton, okButton],
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
