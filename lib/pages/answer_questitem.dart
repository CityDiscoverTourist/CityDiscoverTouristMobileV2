import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';
import 'package:travel_hour/controllers/play_controller.dart';
import 'package:travel_hour/widgets/big_text.dart';

class AnswerPage extends GetView<PlayController> {
  const AnswerPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final myController = TextEditingController();
    return Scaffold(
        body: Stack(
      children: [
        Container(
          child: Column(
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
                          BigText(text: '1200 điểm')
                        ],
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 120.0),
                    child: Center(
                      child: Container(
                        height: 130,
                        width: 130,
                        decoration: BoxDecoration(
                          color: Colors.grey[300],
                          shape: BoxShape.circle,
                        ),
                        child: Icon(Icons.person, size: 28),
                      ),
                    ),
                  )
                ],
              ),
              SizedBox(
                height: 10,
              ),
              Center(
                child: BigText(text: 'NUM OF QUESTION'),
              ),
              SizedBox(
                height: 10,
              ),
              BigText(
                text: "+300 ĐIỂM",
                fontWeight: FontWeight.w800,
              ),
              SizedBox(
                height: 30,
              ),
              GetBuilder<PlayController>(
                builder: (controller) {
                  return Center(
                    child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(controller.questItemCurrent.name),
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
                                    borderRadius: BorderRadius.circular(
                                        12), // <-- Radius
                                  ),
                                ),
                              ),
                            ],
                          )
                        ]),
                  );
                },
              )
            ],
          ),
        ),
        // Positioned(
        //     bottom: 0,
        //     child:
        //     Row(
        //       mainAxisAlignment: MainAxisAlignment.spaceAround,
        //       children: [
        //         Padding(
        //           padding: const EdgeInsets.all(8.0),
        //           child: Container(
        //             width: 50,
        //             height: 50,
        //             decoration: BoxDecoration(
        //               gradient: LinearGradient(
        //                 begin: Alignment.topRight,
        //                 end: Alignment.bottomLeft,
        //                 colors: [Colors.white, Colors.blue],
        //               ),
        //               borderRadius: BorderRadius.circular(10.0),
        //             ),
        //           ),
        //         ),
        //         Padding(
        //           padding: const EdgeInsets.all(8.0),
        //           child: Container(
        //             width: 50,
        //             height: 50,
        //             decoration: BoxDecoration(
        //               gradient: LinearGradient(
        //                 begin: Alignment.topRight,
        //                 end: Alignment.bottomLeft,
        //                 colors: [Colors.white, Colors.blue],
        //               ),
        //               borderRadius: BorderRadius.circular(10.0),
        //             ),
        //           ),
        //         ),
        //         Padding(
        //           padding: const EdgeInsets.all(8.0),
        //           child: Container(
        //             width: 50,
        //             height: 50,
        //             decoration: BoxDecoration(
        //               gradient: LinearGradient(
        //                 begin: Alignment.topRight,
        //                 end: Alignment.bottomLeft,
        //                 colors: [Colors.white, Colors.blue],
        //               ),
        //               borderRadius: BorderRadius.circular(10.0),
        //             ),
        //           ),
        //         ),
        //       ],
        //     ))
      ],
    ));
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
