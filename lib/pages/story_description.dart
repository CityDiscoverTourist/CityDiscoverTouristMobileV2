import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:get/get.dart';
import 'package:line_icons/line_icons.dart';
import 'package:travel_hour/controllers/play_controller.dart';
import 'package:travel_hour/models/purchased_quest.dart';
import 'package:travel_hour/pages/answer_questitem.dart';
import 'package:travel_hour/pages/description_questitem.dart';
import 'package:travel_hour/pages/home.dart';
import 'package:travel_hour/pages/splashV2.dart';
import 'package:travel_hour/widgets/big_text.dart';
import 'package:travel_hour/widgets/schedule_container.dart';

import '../config/colors.dart';
import '../controllers/play_controllerV2.dart';
import '../widgets/custom_cache_image.dart';
import 'package:animations/animations.dart';
import 'package:carousel_slider/carousel_slider.dart';

class StoryDescription extends StatefulWidget {
  @override
  _StoryDescriptionState createState() {
    return _StoryDescriptionState();
  }
}

class _StoryDescriptionState extends State<StoryDescription> {
  late PlayControllerV2 controller;
  @override
  void initState() {
    super.initState();
    controller = Get.find<PlayControllerV2>();
  }

  @override
  Widget build(BuildContext context) {
    // var controller=Get.find<PlayControllerV2>();
    // WidgetsBinding.instance.addPostFrameCallback((_) =>ShowCaseWidget.of(context).startShowCase([_one, _two, _three, _four, _five]));

    return Scaffold(
      appBar: AppBar(
          backgroundColor: AppColors.mainColor,
          title: Text('story page'.tr),
          automaticallyImplyLeading: false),
      body: SingleChildScrollView(
        child: Column(
          children: [
            SingleChildScrollView(
              child: Html(
                data: controller.questItemCurrent.story,
                // customRender: {
                //     'flutter' : (RenderContext context, Widget child, attributes, _){
                //       return FlutterLogo(
                //         style: FlutterLogoStyle.horizontal,
                //         textColor: Colors.blue,
                //         size: 100.0,
                //       );
                //     }
                // },
                style: {
                  'html': Style(backgroundColor: Colors.white12),
                  'table': Style(backgroundColor: Colors.grey.shade200),
                  'td': Style(
                    backgroundColor: Colors.grey.shade400,
                    padding: EdgeInsets.all(10),
                  ),
                  'th': Style(padding: EdgeInsets.all(10), color: Colors.black),
                  'tr': Style(
                      backgroundColor: Colors.grey.shade300,
                      border: Border(
                          bottom: BorderSide(color: Colors.greenAccent))),
                },
                // onLinkTap: (url){
                //     print('Open the url $url......');
                // },
                // onImageTap: (img){
                //     print('Image $img');
                // },
                // onImageError: (exception, stacktrace){
                //     print(exception);
                // },
              ),
            ),
            // SafeArea(
            //     child: TextButton(
            //   child: Text('next'.tr),
            //   onPressed: () {
            //     Get.to(AnswerPage());
            //   },
            // ))
          ],
        ),
      ),
      // Column(
      //   children: [
      //     SingleChildScrollView(
      //       child: Html(
      //         data: controller.questItemCurrent.story,
      //         // customRender: {
      //         //     'flutter' : (RenderContext context, Widget child, attributes, _){
      //         //       return FlutterLogo(
      //         //         style: FlutterLogoStyle.horizontal,
      //         //         textColor: Colors.blue,
      //         //         size: 100.0,
      //         //       );
      //         //     }
      //         // },
      //         style: {
      //           'html': Style(backgroundColor: Colors.white12),
      //           'table': Style(backgroundColor: Colors.grey.shade200),
      //           'td': Style(
      //             backgroundColor: Colors.grey.shade400,
      //             padding: EdgeInsets.all(10),
      //           ),
      //           'th': Style(padding: EdgeInsets.all(10), color: Colors.black),
      //           'tr': Style(
      //               backgroundColor: Colors.grey.shade300,
      //               border:
      //                   Border(bottom: BorderSide(color: Colors.greenAccent))),
      //         },
      //         // onLinkTap: (url){
      //         //     print('Open the url $url......');
      //         // },
      //         // onImageTap: (img){
      //         //     print('Image $img');
      //         // },
      //         // onImageError: (exception, stacktrace){
      //         //     print(exception);
      //         // },
      //       ),
      //     ),
      //     // SafeArea(
      //     //     child: TextButton(
      //     //   child: Text('next'.tr),
      //     //   onPressed: () {
      //     //     Get.to(AnswerPage());
      //     //   },
      //     // ))
      //   ],
      // ),
      bottomNavigationBar: BottomAppBar(
          child: SizedBox(
              height: 70,
              child: ElevatedButton(
                onPressed: () {
                  Get.to(AnswerPage());
                },
                child: Text('next'.tr, style: TextStyle(fontSize: 16)),
                style: ElevatedButton.styleFrom(
                  primary: AppColors.mainColor,
                  onPrimary: Colors.white,
                  padding: const EdgeInsets.only(
                      left: 40.0, top: 16.0, bottom: 16.0, right: 40.0),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12), // <-- Radius
                  ),
                ),
              ))),
    );
  }
}
