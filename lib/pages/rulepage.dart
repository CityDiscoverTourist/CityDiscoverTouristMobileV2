import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:get/get.dart';
import 'package:line_icons/line_icons.dart';
import 'package:travel_hour/controllers/play_controller.dart';
import 'package:travel_hour/models/purchased_quest.dart';
import 'package:travel_hour/pages/answer_questitem.dart';
import 'package:travel_hour/pages/home.dart';
import 'package:travel_hour/widgets/big_text.dart';

import '../controllers/play_controllerV2.dart';
import '../widgets/custom_cache_image.dart';

class RulePage extends GetView<PlayControllerV2> {
  PurchasedQuest pQuest;
  RulePage({required this.pQuest, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Get.put(PlayControllerV2()).pQuest = pQuest;
    return Scaffold(
        backgroundColor: Colors.blueGrey.shade50,
        appBar: AppBar(
          backgroundColor: Colors.amberAccent,
          title: BigText(
            text: "RulePage",
            fontWeight: FontWeight.w700,
          ),
          centerTitle: true,
          automaticallyImplyLeading: false,
        ),
        body: Stack(children: [
          Column(
            children: [
              SingleChildScrollView(
                child: Container(
                    child: Column(
                  children: [
                    Container(
                      height: 200,
                      width: double.infinity,
                      child: CustomCacheImage(
                          imageUrl:
                              "https://statics.vntrip.vn/data-v2/data-guide/img_content/1470302452_anh-5.jpg"),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Container(
                            width: 190,
                            height: 200,
                            child: Column(
                              children: [
                                Container(
                                  width: 190,
                                  height: 95,
                                  decoration: BoxDecoration(
                                    color: Colors.blue,
                                    gradient: LinearGradient(
                                      begin: Alignment.topRight,
                                      end: Alignment.bottomLeft,
                                      colors: [
                                        Colors.white,
                                        Colors.purpleAccent,
                                      ],
                                    ),
                                    borderRadius: BorderRadius.circular(10.0),
                                  ),
                                  child: Center(
                                      child: BigText(
                                    text: "1200 điểm",
                                    fontWeight: FontWeight.w900,
                                  )),
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                Container(
                                    width: 190,
                                    height: 95,
                                    decoration: BoxDecoration(
                                      color: Colors.blue,
                                      gradient: LinearGradient(
                                        begin: Alignment.topRight,
                                        end: Alignment.bottomLeft,
                                        colors: [
                                          Colors.amberAccent,
                                          Colors.white
                                        ],
                                      ),
                                      borderRadius: BorderRadius.circular(10.0),
                                    ),
                                    child: Column(
                                      children: [
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceAround,
                                          children: [
                                            Icon(
                                              Feather.clock,
                                              color: Colors.black,
                                              size: 25,
                                            ),
                                            BigText(text: "20 min")
                                          ],
                                        ),
                                        SizedBox(
                                          height: 10,
                                        ),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceAround,
                                          children: [
                                            Icon(
                                              LineIcons.walking,
                                              color: Colors.black,
                                              size: 25,
                                            ),
                                            BigText(text: "20 kilomiters")
                                          ],
                                        ),
                                      ],
                                    )),
                              ],
                            ),
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          Container(
                            width: 190,
                            height: 200,
                            decoration: BoxDecoration(
                              gradient: LinearGradient(
                                begin: Alignment.topRight,
                                end: Alignment.bottomLeft,
                                colors: [Colors.white, Colors.blue],
                              ),
                              borderRadius: BorderRadius.circular(10.0),
                            ),
                            child: Align(
                                alignment: Alignment.topCenter,
                                child: BigText(
                                  text: 'Luật chơi',
                                  fontWeight: FontWeight.w800,
                                )),
                          ),
                        ]),
                  ],
                )),
              ),
            ],
          ),
          Positioned(
            bottom: 0,
            child: InkWell(
              onTap: () {
                var controller = Get.find<PlayControllerV2>();
                print('RULE PAGE' +
                    controller.questItemCurrent.description.toString());
                    controller.changeIsLoading();
                Get.to(AnswerPage());
                print("HCM HCM HCM");
                // Get.to(AnswerPage());
              },
              child: Container(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height * 0.075,
                child: Center(
                    child: BigText(
                  text: "Start",
                  fontWeight: FontWeight.w900,
                )),
                decoration: BoxDecoration(
                    color: Color(0xFFFF9C00),
                    gradient: LinearGradient(
                      begin: Alignment.topRight,
                      end: Alignment.bottomLeft,
                      colors: [Colors.orange, Colors.white, Colors.blue],
                    ),
                    borderRadius: BorderRadius.circular(10)),
              ),
            ),
          ),
        ]));
  }
}
//  Center(
//         child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
//         ElevatedButton(
//           onPressed: () {
//             Get.put(PlayController());
//             Get.to(AnswerPage());
//           },
//           child: Text('Start', style: TextStyle(fontSize: 16)),
//           style: ElevatedButton.styleFrom(
//             padding: const EdgeInsets.only(
//                 left: 40.0, top: 16.0, bottom: 16.0, right: 40.0),
//             shape: RoundedRectangleBorder(
//               borderRadius: BorderRadius.circular(12), // <-- Radius
//             ),
//           ),
//         ),
//     ]),
//       ),