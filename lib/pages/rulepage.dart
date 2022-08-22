import 'package:animations/animations.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:travel_hour/pages/answer_questitem.dart';
import 'package:travel_hour/widgets/big_text.dart';
import 'package:travel_hour/widgets/schedule_container.dart';

import '../config/colors.dart';

class RulePage extends StatefulWidget {
  const RulePage({Key? key}) : super(key: key);
  @override
  State<RulePage> createState() => _RulePageState();
}

class _RulePageState extends State<RulePage> {
  late ValueNotifier<int> strikeNotifier;
  late CarouselController buttonCarouselController;
  late FixedExtentScrollController controller;
// late ListWheelScrollView
  // PurchasedQuest pQuest;
  GlobalKey _one = GlobalKey();
  GlobalKey _two = GlobalKey();
  GlobalKey _three = GlobalKey();
  GlobalKey _four = GlobalKey();
  GlobalKey _five = GlobalKey();
  List<Widget> listItem = [
    ScheduleContainer("each question you will get 300 points".tr, 1),
    ScheduleContainer(
        "you will be answered up to 5 times for a question".tr +
            "/" +
            "the 5th time you will be shown the answer".tr,
        2),
    ScheduleContainer(
        "for each wrong answer, 50 points will be deducted".tr +
            "/" +
            "using seggestion will be deducted 75 points (1 time)".tr,
        3)
  ];

  @override
  void initState() {
    super.initState();
    strikeNotifier = ValueNotifier(0);
    controller = FixedExtentScrollController();
    buttonCarouselController = CarouselController();

    //Start showcase view after current widget frames are drawn.
    //NOTE: remove ambiguate function if you are using
    //flutter version greater than 3.x and direct use WidgetsBinding.instance
    // WidgetsBinding.instance.addPostFrameCallback(
    //   (_) => ShowCaseWidget.of(context)
    //       .startShowCase([_one, _two, _three, _four, _five]),
    // );
  }

  @override
  Widget build(BuildContext context) {
    // var controller=Get.find<PlayControllerV2>();
    // WidgetsBinding.instance.addPostFrameCallback((_) =>ShowCaseWidget.of(context).startShowCase([_one, _two, _three, _four, _five]));
    final List _items = [
      "cacula point".tr,
      "each question you will get 300 points".tr,
      "you will be answered up to 5 times for a question".tr,
      "the 5th time you will be shown the answer".tr,
      "with image scan quest if you answer 5th time wrong you will be move to next task"
          .tr,
      "for each wrong answer, 50 points will be deducted".tr,
      "using seggestion will be deducted 75 points (1 time)".tr,
      // 'Monkey',
      // 'Chicken',
      // 'Flamingo'
    ];
    int _selectedItemIndex = 0;
    const transitionType = ContainerTransitionType.fade;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.mainColor,
        title: BigText(
          text: "rulepage".tr,
          fontWeight: FontWeight.w700,
          color: Colors.white,
        ),
        centerTitle: true,
        automaticallyImplyLeading: false,
        // actions: [
        //   Showcase(
        //     key: _one,
        //     description: 'Lướt sang phải để xem thêm bạn nhé!',
        //     child: Icon(Icons.info),
        //   )
        // ],
      ),
      floatingActionButton: ValueListenableBuilder(
          valueListenable: strikeNotifier,
          builder: (_, check, widget) {
            if (check == 0) {
              return FloatingActionButton(
                backgroundColor: AppColors.mainColor,
                child: Icon(Icons.arrow_forward),
                onPressed: () {
                  if (_selectedItemIndex != _items.length - 1) {
                    final nextIndex = controller.selectedItem + 1;
                    controller.animateToItem(nextIndex,
                        duration: Duration(milliseconds: 200),
                        curve: Curves.easeInOut);
                  }
                },
              );
            }
            if (check == 1) {
              return Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Padding(
                        padding: const EdgeInsets.only(left: 30.0),
                        child: FloatingActionButton(
                          backgroundColor: AppColors.mainColor,
                          child: Icon(Icons.arrow_back),
                          onPressed: () {
                            // if(_selectedItemIndex!=_items.length-1){
                            final nextIndex = controller.selectedItem - 1;
                            controller.animateToItem(nextIndex,
                                duration: Duration(milliseconds: 200),
                                curve: Curves.easeInOut);
                            // }
                          },
                        )),
                    FloatingActionButton(
                      backgroundColor: AppColors.mainColor,
                      child: Icon(Icons.arrow_forward),
                      onPressed: () {
                        if (_selectedItemIndex != _items.length - 1) {
                          final nextIndex = controller.selectedItem + 1;
                          controller.animateToItem(nextIndex,
                              duration: Duration(milliseconds: 200),
                              curve: Curves.easeInOut);
                        }
                      },
                    )
                  ]);
            } else {
              return FloatingActionButton(
                backgroundColor: AppColors.mainColor,
                child: Text(
                  'get started'.tr,
                  textAlign: TextAlign.center,
                ),
                onPressed: () {
                  // Get.to(StoryDescription());
                  Get.to(AnswerPage());
                },
              );
            }
          }),
      // _check!=true?FloatingActionButton(
      //   child: Icon(Icons.arrow_forward),
      //   onPressed: () {
      //     if(_selectedItemIndex!=_items.length-1){
      //     final nextIndex=controller.selectedItem+1;
      //     controller.animateToItem(nextIndex,duration: Duration(seconds: 1),curve: Curves.easeInOut);
      //     }
      //   },
      // )

      body: Column(children: [
        // display selected item
        // Container(
        //     width: double.infinity,
        //     padding: const EdgeInsets.symmetric(vertical: 50),
        //     color: Colors.grey.shade800,
        //     alignment: Alignment.center,
        //     child: Text(
        //       _items[_selectedItemIndex],
        //       style: const TextStyle(fontSize: 32, color: Colors.white),
        //     )),
        // implement the List Wheel Scroll View
        Expanded(
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
            width: double.infinity,
            color: Colors.white,
            child: ListWheelScrollView(
              controller: controller,
              offAxisFraction: 1.5,
              itemExtent: 100,
              diameterRatio: 1.8,
              onSelectedItemChanged: (int index) {
                // update the UI on selected item changes
                setState(() {
                  _selectedItemIndex = index;
                  if (_selectedItemIndex > 0) {
                    strikeNotifier.value = 1;
                  }
                  if (_selectedItemIndex == _items.length - 1) {
                    strikeNotifier.value = -1;
                  }
                  if (_selectedItemIndex == 0) {
                    strikeNotifier.value = 0;
                  }
                });
              },
              // children of the list
              children: _items
                  .map((e) => SizedBox(
                        width: double.infinity,
                        height: 400.0,
                        child: Card(
                          // make selected item background color is differ from the rest
                          color: e == "cacula point".tr
                              ? AppColors.mainColor
                              : Colors.indigo,
                          child: Center(
                            child: BigText(
                              text: e,
                              size: 20,
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ))
                  .toList(),
            ),
          ),
        ),
      ]),
    );
  }
}
