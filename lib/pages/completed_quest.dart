import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';
import 'package:travel_hour/controllers/play_controller.dart';
import 'package:travel_hour/controllers/play_controllerV2.dart';
import 'package:travel_hour/pages/home.dart';
import 'package:travel_hour/pages/rating_quest.dart';

class CompletedPage extends GetView<PlayControllerV2> {
  const CompletedPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
          Text("Completed Page + "+controller.endPoint.toString()),
          ElevatedButton(
            onPressed: () {
              Get.close(0);
              Get.to(RatingQuest());
            },
            child: Text('Go Home', style: TextStyle(fontSize: 16)),
            style: ElevatedButton.styleFrom(
              padding: const EdgeInsets.only(
                  left: 40.0, top: 16.0, bottom: 16.0, right: 40.0),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12), // <-- Radius
              ),
            ),
          ),
        ]),
      ),
    );
  }
}
