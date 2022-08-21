import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:get/get.dart';
import 'package:travel_hour/pages/story_description.dart';

import '../config/colors.dart';
import '../controllers/play_controllerV2.dart';

class DescriptionAns extends StatefulWidget {
  @override
  _DescriptionAnsState createState() {
    return _DescriptionAnsState();
  }
}

class _DescriptionAnsState extends State<DescriptionAns> {
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
          title: Text('description page'.tr),
          automaticallyImplyLeading: false),
      
      body: SingleChildScrollView(
        child: Column(
          children: [
            SingleChildScrollView(
              child: Html(
                data: controller.description,
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
              
              ),
            ),

         
          ],
        ),
      ),
  
      bottomNavigationBar: BottomAppBar(
          child: SizedBox(
              height: 70,
              child: ElevatedButton(
                onPressed: () {
                
                  controller.numQuest++;
                  Get.to(StoryDescription());
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
              )
              // SafeArea(

              //     child: TextButton(
              //   child: Text('next'.tr),
              //   onPressed: () {
              //     controller.numQuest++;
              //     Get.to(StoryDescription());
              //   },
              // )))
              )),
    );
  }
}
