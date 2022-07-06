import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';
import 'package:travel_hour/controllers/play_controller.dart';

class AnswerPage extends GetView<PlayController> {
  const AnswerPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final myController = TextEditingController();
    return Scaffold(body: GetBuilder<PlayController>(
      builder: (controller) {
        return Center(
          child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
            Text(controller.questItemCurrent.name),
            TextField(
              controller: myController,
            ),
            ElevatedButton(
              onPressed: () {
                controller.currentAns.value = myController.text;
                myController.text = "";
                controller.clickAnswer();
              },
              child: Text('Submit', style: TextStyle(fontSize: 16)),
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.only(
                    left: 40.0, top: 16.0, bottom: 16.0, right: 40.0),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12), // <-- Radius
                ),
              ),
            ),
          ]),
        );
      },
    ));
  }
}
