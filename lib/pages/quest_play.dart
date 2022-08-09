import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_countdown_timer/current_remaining_time.dart';
import 'package:flutter_countdown_timer/flutter_countdown_timer.dart';
import 'package:get/get.dart';
import 'package:travel_hour/controllers/questpurchased_controller.dart';
import 'package:travel_hour/controllers/home_controller.dart';
import 'package:travel_hour/controllers/login_controller_V2.dart';
import 'package:travel_hour/models/purchased_quest.dart';
import 'package:travel_hour/pages/chat.dart';
import 'package:travel_hour/pages/payment_detail.dart';
import 'package:travel_hour/pages/qr_scanner.dart';
import 'package:travel_hour/pages/splashV2.dart';
import 'package:travel_hour/pages/rulepage.dart';
import 'package:travel_hour/widgets/big_text.dart';
import 'package:travel_hour/widgets/custom_cache_image.dart';
import 'package:travel_hour/widgets/small_text.dart';
import 'package:flutter_countdown_timer/countdown_timer_controller.dart';
import 'package:url_launcher/url_launcher.dart';

import '../common/customFullScreenDialog.dart';
import '../controllers/chat_controller.dart';
import '../controllers/play_controllerV2.dart';
import '../models/quest.dart';
import '../routes/app_routes.dart';

class QuestsPlayPage extends GetView<QuestPurchasedController> {
  const QuestsPlayPage({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    // var controller = Get.find<HistoryController>();
    return WillPopScope(
      onWillPop: () async {
        Get.back();
        return true;
      },
      child: Scaffold(
        appBar: AppBar(
          leading: IconButton(
            icon: Icon(Icons.arrow_back, color: Colors.black),
            onPressed: () {
              Get.back();
            },
          ),
          automaticallyImplyLeading: false,
          backgroundColor: Colors.redAccent,
          title: BigText(
            text: 'my quest'.tr,
            color: Colors.white,
            fontWeight: FontWeight.w700,
          ),
          actions: [
            Padding(
                padding: EdgeInsets.only(right: 10),
                child: InkWell(
                  onTap: () {
                    showAlertDialogAddCode(context);
                    // Get.to(QRViewExample());
                  },
                  child: Icon(
                    Icons.add,
                    size: 30,
                  ),
                )),
            Padding(
                padding: EdgeInsets.only(right: 10),
                child: InkWell(
                  onTap: () {
                    Get.put(ChatController());
                    Get.to(ChatScreen());
                  },
                  child: Icon(
                    Icons.support_agent,
                    size: 30,
                  ),
                ))
          ],
        ),
        body: Obx((() {
          if (controller.isLoading.value == false) {
            print(controller.purchsedQuestList.length);
            return ListView.builder(
              itemCount: controller.purchsedQuestList.length,
              itemBuilder: (_, _currentIndex) {
                return cardPurchagedQuest(
                    controller.purchsedQuestList[_currentIndex], context);
              },
            );
          } else {
            return SplashStart(
              content: "waiting.....".tr,
            );
          }
        })),
        // floatingActionButton: FloatingActionButton(
        //   backgroundColor: Colors.redAccent,
        //   child: Icon(
        //     Icons.add,
        //   ),
        //   onPressed: () {
        // showModalBottomSheet<void>(
        //   context: context,
        //   builder: (BuildContext context) {
        //     return Container(
        //       height: 200,
        //       color: Colors.blueGrey.shade50,
        //       child: Center(
        //         child: Column(
        //           mainAxisAlignment: MainAxisAlignment.center,
        //           mainAxisSize: MainAxisSize.min,
        //           children: <Widget>[
        //             BigText(text: 'EnterCode'),
        //             TextField(),
        //             Row(
        //               mainAxisAlignment: MainAxisAlignment.center,
        //               children: [
        //                 ElevatedButton(
        //                   child: const Text('Close '),
        //                   onPressed: () => Navigator.pop(context),
        //                 ),
        //                 SizedBox(
        //                   width: 15,
        //                 ),
        //                 ElevatedButton(
        //                   child: const Text('Submit'),
        //                   onPressed: () => {},
        //                 )
        //               ],
        //             )
        //           ],
        //         ),
        //       ),
        //     );
        //   },
        // );
        //   },
        // ),
      ),
    );
  }

  Widget cardPurchagedQuest(PurchasedQuest pQuest, BuildContext context) {
    int endTime = pQuest.createdDate.millisecondsSinceEpoch + 172800000;
    return Container(
      margin: EdgeInsets.all(8.0),
      child: Stack(children: [
        Card(
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(8.0))),
          child: Column(
            children: <Widget>[
              ClipRRect(
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(8.0),
                  topRight: Radius.circular(8.0),
                ),
                child: pQuest.imagePath != null
                    ? Image.network(pQuest.imagePath,
                        width: 300, height: 150, fit: BoxFit.fill)
                    : Icon(
                        Icons.payment,
                        size: 50,
                      ),
              ),
              ListTile(
                title: BigText(
                  text: pQuest.questName,
                  fontWeight: FontWeight.w600,
                ),
                subtitle: Column(
                  children: [
                    Align(
                      alignment: Alignment.topLeft,
                      child: CountdownTimer(
                        endTime: endTime,
                        widgetBuilder: (_, CurrentRemainingTime? time) {
                          if (time == null) {
                            return Text('time up'.tr);
                          }
                          // return BigText(
                          //   text:
                          //       '${time.days}d:${time.hours}h:${time.min}m:${time.sec}s',
                          //   color: Colors.green,
                          // );
                          else {
                            return BigText(
                              text: (() {
                                if (time.days != null) {
                                  return "time remaining".tr +
                                      " ${time.days}d:${time.hours}h:${time.min}m:${time.sec}s";
                                } else if (time.min == null) {
                                  return "time remaining".tr + " ${time.sec}s";
                                } else if (time.hours == null) {
                                  return "time remaining".tr +
                                      "${time.min}m:${time.sec}s";
                                } else if (time.days == null) {
                                  return "time remaining".tr +
                                      " ${time.hours}h:${time.min}m:${time.sec}s";
                                } else {
                                  return "time up".tr;
                                }
                              })(),
                              color: Colors.green,
                            );
                          }
                        },
                      ),
                    ),
                  ],
                ),
                trailing: PopUpMen(
                  menuList: [
                    PopupMenuItem(
                      child: InkWell(
                        onTap: () async {
                          PlayControllerV2 playController =
                              new PlayControllerV2();
                          CustomFullScreenDialog.showDialog();
                          bool check = await playController
                              .checkUserLocation(pQuest.questId.toString());
                          CustomFullScreenDialog.cancelDialog();
                          if (true) {
                            showAlertDialog(context, pQuest);
                          } else {
                            showAlertDialogCheckLocation(context, pQuest);
                          }
                        },
                        child: ListTile(
                          leading: Icon(
                            CupertinoIcons.play_arrow_solid,
                          ),
                          title: Text("play now".tr),
                        ),
                      ),
                    ),
                    PopupMenuItem(
                      child: InkWell(
                        onTap: () {
                          Get.to(PaymentDetail(
                            purchasedQuest: pQuest,
                          ));
                        },
                        child: ListTile(
                          leading: Icon(
                            CupertinoIcons.info_circle_fill,
                          ),
                          title: Text("info purchase".tr),
                        ),
                      ),
                    ),
                  ],
                  icon: CircleAvatar(
                    backgroundColor: Colors.redAccent,
                    // backgroundImage: const NetworkImage(
                    //   'https://images.unsplash.com/photo-1644982647869-e1337f992828?ixlib=rb-1.2.1&ixid=MnwxMjA3fDF8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=435&q=80',
                    // ),
                    child: Icon(
                      Icons.menu,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
        //   Positioned(
        //       right: 0,
        //       top: 0,
        //       child: InkWell(
        //         onTap: () async {
        // //  return Menu
        //           // if(Get.find<PlayControllerV2>().checkLocation() == false){

        //           // }
        //           PlayControllerV2 playController = new PlayControllerV2();

        //           bool check = await playController
        //               .checkUserLocation(pQuest.questId.toString());
        //           if (true) {
        //             showAlertDialog(context, pQuest);
        //           } else {
        //             showAlertDialogCheckLocation(context, pQuest);
        //           }
        //         },
        //         child: CircleAvatar(
        //           backgroundColor: Colors.redAccent,
        //           radius: 30,
        //           child: Icon(
        //             Icons.play_arrow,
        //             color: Colors.white,
        //           ),
        //         ),
        //       ))
      ]),
    );
  }

  showAlertDialog(BuildContext context, PurchasedQuest pQuest) {
    // Create button
    Widget okButton = FlatButton(
      child: Text("ok".tr),
      onPressed: () {
        Get.put(PlayControllerV2()).pQuest = pQuest;
        Navigator.of(context).pop();
        // Get.to(RulePage(
        //   pQuest: pQuest,
        // ));
        //  vao trang huong dan
        // Navigator.of(context).pop();
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
      content: Text(
          "quests that have entered the game cannot be reused. do you want to confirm?"
              .tr),
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

  showAlertDialogCheckLocation(
      BuildContext context, PurchasedQuest pQuest) async {
    // Create button
    CustomFullScreenDialog.showDialog();
    Quest? quest;
    String address = "";
    var controller = Get.find<HomeController>();
    quest = await controller.getQuestDetailByID(pQuest.questId.toString());
    address = quest!.address.toString();
    String googleMapslocationUrl =
        "https://www.google.com/maps/search/?api=1&query=" +
            quest.latLong.toString();
    String encodedURl = Uri.encodeFull(googleMapslocationUrl);
    print(googleMapslocationUrl);
    CustomFullScreenDialog.cancelDialog();
    Widget okButton = FlatButton(
      child: Text("open map".tr),
      onPressed: () async {
        Navigator.of(context).pop();
        if (await canLaunch(encodedURl)) {
          await launch(encodedURl);
        } else {
          print('Could not launch $encodedURl');
          throw 'Could not launch $encodedURl';
        }
        // Get.to(RulePage(
        //   pQuest: pQuest,
        // ));
        //  vao trang huong dan
        // Navigator.of(context).pop();
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
      content: Text("please go to this address to start the quest:".tr +
          "\n" +
          "\n" +
          address),
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

  showAlertDialogAddCode(BuildContext context) async {
    TextEditingController textCtrl = TextEditingController();
    String code = "";
    // Create button
    Widget okButton = FlatButton(
      child: Text("ok".tr),
      onPressed: () async {
        // print(textCtrl.text);
        PlayControllerV2 controller = new PlayControllerV2();
        PurchasedQuest? purchasedQuest =
            await controller.getPuQuestById(textCtrl.text);
        if (purchasedQuest != null) {
          showAlertDialog(context, purchasedQuest);
        } else {
          Get.snackbar(
              'play code not exist or expired'.tr, 'please try again'.tr,
              duration: Duration(seconds: 2),
              backgroundColor: Colors.black,
              colorText: Colors.white,
              snackPosition: SnackPosition.BOTTOM,
              icon: Icon(
                Icons.error,
                color: Colors.red,
              ));
          // Navigator.of(context).pop();
        }

        // Get.to(RulePage(
        //   pQuest: pQuest,
        // ));
        //  vao trang huong dan
        // Navigator.of(context).pop();
      },
    );
    Widget scanButton = FlatButton(
      child: Text("scan qr code".tr),
      onPressed: () async {
        Navigator.of(context).pop();
        Get.to(QRViewExample());
        // Get.to(RulePage(
        //   pQuest: pQuest,
        // ));
        //  vao trang huong dan
        // Navigator.of(context).pop();
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
      title: Text("in put play code".tr),
      content: TextFormField(
        controller: textCtrl,
        decoration: InputDecoration(
          labelText: "play code".tr,
          border: OutlineInputBorder(),
        ),
        // onFieldSubmitted: (value) {
        //   print(value);
        // },
        // onEditingComplete: () {
        //   code = textCtrl.text;
        //   print(code);
        // },
        // onChanged: (value) {
        //   code = textCtrl.text;
        //   // print(code);
        // },
      ),
      actions: [okButton, scanButton, cancelButton],
    );

    // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }

  void showCustomDialog(BuildContext context) {
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
                  text: "sugg",
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
}

class PopUpMen extends StatelessWidget {
  final List<PopupMenuEntry> menuList;
  final Widget? icon;
  const PopUpMen({Key? key, required this.menuList, this.icon})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16.0),
      ),
      itemBuilder: ((context) => menuList),
      icon: icon,
    );
  }
}
