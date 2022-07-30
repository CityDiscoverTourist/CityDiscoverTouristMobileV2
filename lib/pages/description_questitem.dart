import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';
import 'package:travel_hour/controllers/play_controller.dart';
import 'package:travel_hour/controllers/play_controllerV2.dart';
import 'package:travel_hour/pages/home.dart';
import 'package:travel_hour/pages/rating_quest.dart';

import 'answer_questitem.dart';

class DescriptionPage extends GetView<PlayControllerV2> {
  const DescriptionPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
          Text("progress page ".tr + controller.questItemCurrent.description),
          Center(
            child: TextButton(
              style: ButtonStyle(
                foregroundColor: MaterialStateProperty.all<Color>(Colors.blue),
              ),
              onPressed: () {
                // var controller = Get.find<PlayControllerV2>();
                // print('RULE PAGE' +
                //     controller.questItemCurrent.description.toString());
                // controller.changeIsLoading();
                // Get.to(DescriptionPage());
                Get.to(AnswerPage());
                print("HCM HCM HCM");
              },
              child: Text('get started'.tr),
            ),
          )
        ]),
      ),
    );
  }
}
