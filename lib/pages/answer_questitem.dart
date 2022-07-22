import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';
import 'package:status_view/status_view.dart';
import 'package:travel_hour/controllers/play_controller.dart';
import 'package:travel_hour/controllers/play_controllerV2.dart';
import 'package:travel_hour/models/questItem.dart';
import 'package:travel_hour/pages/splashV2.dart';
import 'package:travel_hour/widgets/big_text.dart';

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
  @override
  Widget build(BuildContext context) {
    final myController = TextEditingController();
    var controller=Get.find<PlayControllerV2>();
    return Scaffold(
        body: Obx((){
        if(controller.isLoading.value==true){
          return SplashStart();
        }else return
           Stack(
              children: [
          Container(
            child:
            Column(
                children: [
                  Stack(
                    children: [
                      Container(
                        height: 200,
                        width: double.infinity,
                        color: Colors.amber,
                        child: Align(
                          alignment: Alignment.bottomRight,
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              Icon(Icons.score),
                              BigText(text: controller.cusTask.currentPoint.toString())
                            ],
                          ),
                        ),
                      ),
                      Positioned(
                        right: 10,
                        top: 40,
                        child: InkWell(
                          onTap: (){
                            controller.showSuggestion();
                            showCustomDialog(context,controller.sugggestion.value);},
                          child: Icon(Icons.notifications))),
                      Padding(
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
                    ],
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Center(
                    child: BigText(text: 'NUM OF QUESTION '+controller.questItemCurrent.id.toString()),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  BigText(
                    text: controller.cusTask.currentPoint.toString(),
                    fontWeight: FontWeight.w800,
                  ),
                  SizedBox(
                    height: 30,
                  ),
              
                      Center(
                        child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(controller.questItemCurrent.content),
                              SizedBox(height: 30),
                              Column(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.all(20.0),
                                    child: TextField(
                                      controller: myController,
                                      decoration: InputDecoration(
                                        border: OutlineInputBorder(),
                                      ),
                                    ),
                                  ),
                                  ElevatedButton(
                                    onPressed: () {
                                      controller.currentAns.value =
                                          myController.text;
                                      myController.text = "";
                                      controller.clickAnswer();
                                    },
                                    child: Text('Submit',
                                        style: TextStyle(fontSize: 16)),
                                    style: ElevatedButton.styleFrom(
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
                                  ),
                                ],
                              )
                            ]),
                      )
                     
                ],
              ),
          ),
              ],
            );}
        )
        );
  }
  void showCustomDialog(BuildContext context,String? sugg) {
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
          child: SizedBox.expand(child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
BigText(text: sugg!, size: 28,)
          ],)),
          margin: EdgeInsets.symmetric(horizontal: 20),
          decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(40)),
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
