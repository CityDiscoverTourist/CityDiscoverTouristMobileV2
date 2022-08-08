import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';
import 'package:line_icons/line_icon.dart';
import 'package:line_icons/line_icons.dart';
import 'package:status_view/status_view.dart';
import 'package:travel_hour/controllers/play_controller.dart';
import 'package:travel_hour/controllers/play_controllerV2.dart';
import 'package:travel_hour/models/questItem.dart';
import 'package:travel_hour/pages/splashV2.dart';
import 'package:travel_hour/widgets/big_text.dart';

class AnswerPageV3 extends StatelessWidget {
  AnswerPageV3({Key? key}) : super(key: key);
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
  // var controller = Get.find<PlayControllerV2>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Column(
      children: [
        Stack(
          children: [
            Container(
              child: Column(
                children: [
                  Stack(
                    children: [
                      Container(
                        height: 250,
                        width: double.infinity,
                        color: Colors.redAccent,
                        child: Align(
                          alignment: Alignment.bottomRight,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Icon(Icons.close),
                                  BigText(text: 'So lan sai: '),BigText(text: '3'),
                                ],
                              ),  
                               Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Icon(LineIcons.pen),
                                  BigText(text: 'So lan tra loi: '),BigText(text: '3'),
                                ],
                              ),                            ],
                          ),
                        ),
                      ),
                      Positioned(
                          top: 50,
                          right: 0,
                          left: 0,
                          child: Center(
                            child: BigText(
                              text: '1800 diem',
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          )),
                      Positioned(
                          right: 10,
                          top: 40,
                          child: InkWell(
                              onTap: () {
                                // controller.showSuggestion();
                                showAlertDialog(context, 'Hen xui');
                              },
                              child: Icon(Icons.notifications))),
                      Positioned(
                        top: 20,
                        left: 0,
                        right: 0,
                        child: Padding(
                          padding: const EdgeInsets.only(top: 70.0),
                          child: Center(
                            child: StatusView(
                              radius: 60,
                              spacing: 15,
                              strokeWidth: 2,
                              // indexOfSeenStatus: controller.numQuest,
                              indexOfSeenStatus: 1,
                              numberOfStatus: 3,
                              padding: 4,
                              centerImageUrl: "https://picsum.photos/200/300",
                              seenColor: Colors.grey,
                              unSeenColor: Colors.greenAccent,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Center(
                    child: BigText(text: 'NUM OF QUESTION '.tr + '1'),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  Center(
                    child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          // controller.questItemCurrent.questItemTypeId == 2
                          //     ? SingleChildScrollView(
                          //         child: Column(children: [
                          //         Text(
                          //             "Bạn hãy tìm và chụp ảnh của giống với ảnh bên dưới nhé(Vui lòng cho app sử dụng camera của bạn)"),
                          //         Image.network(
                          //             controller.questItemCurrent.listImages[1],
                          //             width: 400,
                          //             height: 400,
                          //             fit: BoxFit.fill)
                          //       ]))
                          //     :
                          Text("Nha Vua Van Lang doi 99?"),
                          SizedBox(height: 30),
                          Column(
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(20.0),
                                child:
                                    // Obx(() =>
                                    TextField(
                                  controller: myController,
                                  decoration: InputDecoration(
                                    border: OutlineInputBorder(),
                                  ),
                                ),
                                // ),
                              ),
                            ],
                          )
                        ]),
                  )
                ],
              ),
            ),
          ],
          // );
          // }
        ),
        Align(
          alignment: Alignment.bottomCenter,
          child: SafeArea(
              child: ElevatedButton(
            onPressed: () {},
            child: Text('submit'.tr, style: TextStyle(fontSize: 16)),
            style: ElevatedButton.styleFrom(
              padding: const EdgeInsets.only(
                  left: 60.0, top: 20.0, bottom: 20.0, right: 60.0),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12), // <-- Radius
              ),
            ),
          )),
        )
      ],
    ));
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
}
