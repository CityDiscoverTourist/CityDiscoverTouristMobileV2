import 'package:carousel_pro_nullsafety/carousel_pro_nullsafety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:get/get.dart';
import 'package:line_icons/line_icons.dart';
import 'package:travel_hour/controllers/payment_controller.dart';
import 'package:travel_hour/controllers/questdetail_controller.dart';
import 'package:travel_hour/pages/splashV2.dart';
import 'package:travel_hour/routes/app_routes.dart';
import 'package:travel_hour/widgets/big_text.dart';
import 'package:travel_hour/widgets/expanded.dart';
import 'package:travel_hour/widgets/small_text.dart';
import 'package:travel_hour/widgets/todov2.dart';

import '../widgets/custom_cache_image.dart';
import '../widgets/payment_widgetV2.dart';

class QuestDetailsPageV2 extends GetView<QuestDetailController> {
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        return false;
      },
      child: Scaffold(
        backgroundColor: Colors.white,
        body: Obx(
          () => controller.isLoading.isTrue
              ? SplashStart()
              : Stack(children: [
                  SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Stack(
                          children: <Widget>[
                            _slidableImages(),
                            //  Hero(
                            //     tag: widget.tag!,
                            //     child: _slidableImages(),
                            //   ),
                            Positioned(
                              top: 20,
                              left: 15,
                              child: SafeArea(
                                child: CircleAvatar(
                                  backgroundColor:
                                      Colors.redAccent.withOpacity(0.9),
                                  child: IconButton(
                                    icon: Icon(
                                      LineIcons.arrowLeft,
                                      color: Colors.white,
                                    ),
                                    onPressed: () {
                                      Navigator.pop(context);
                                    },
                                  ),
                                ),
                              ),
                            ),
                            // Positioned(
                            //   top: 50,
                            //   right: 0,
                            //   child: Row(
                            //     children: <Widget>[
                            //       // LoveCount(
                            //       //     collectionName: collectionName,
                            //       //     timestamp: widget.data!.timestamp),
                            //       Icon(
                            //         Feather.share_2,
                            //         color: Colors.white,
                            //         size: 25,
                            //       ),
                            //       SizedBox(
                            //         width: 30,
                            //       ),
                            //       Icon(
                            //         Feather.heart,
                            //         color: Colors.white,
                            //         size: 25,
                            //       ),
                            //       SizedBox(
                            //         width: 20,
                            //       ),
                            //       // CommentCount(
                            //       //     collectionName: collectionName,
                            //       //     timestamp: widget.data!.timestamp)
                            //     ],
                            //   ),
                            // )
                          ],
                        ),
                        Padding(
                          padding: const EdgeInsets.only(
                              top: 20, bottom: 8, left: 20, right: 20),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              BigText(
                                text: controller.questDetail.title,
                                fontWeight: FontWeight.w600,
                              ),
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  //Infomation : title, rating, comments,first location
                                  Container(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        SizedBox(
                                          height: 30,
                                        ),
                                        Row(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            controller.questDetail
                                                            .averageStar !=
                                                        null ||
                                                    controller.questDetail
                                                            .averageStar !=
                                                        0
                                                ? SmallText(
                                                    text: controller
                                                        .questDetail.averageStar
                                                        .toString())
                                                : SmallText(text: "5"),
                                            SizedBox(
                                              width: 10,
                                            ),
                                            RatingBarIndicator(
                                              rating: controller.questDetail
                                                              .averageStar !=
                                                          null ||
                                                      controller.questDetail
                                                              .averageStar !=
                                                          0
                                                  ? controller
                                                      .questDetail.averageStar
                                                      .toDouble()
                                                  : 5,
                                              itemBuilder: (context, index) =>
                                                  Icon(
                                                Icons.star,
                                                color: Colors.amber,
                                              ),
                                              itemCount: 5,
                                              itemSize: 10.0,
                                              direction: Axis.horizontal,
                                            ),
                                            SizedBox(
                                              width: 5,
                                            ),
                                            SmallText(
                                                text: controller.questDetail
                                                        .totalFeedback
                                                        .toString() +
                                                    ' ' +
                                                    'comments'.tr),
                                          ],
                                        ),
                                        Container(
                                          margin: EdgeInsets.only(
                                              top: 8, bottom: 8),
                                          height: 3,
                                          width: 150,
                                          decoration: BoxDecoration(
                                              color: Theme.of(context)
                                                  .primaryColor,
                                              borderRadius:
                                                  BorderRadius.circular(40)),
                                        ),
                                        Row(
                                          children: [
                                            Icon(
                                              Icons.location_on,
                                              size: 16,
                                              color: Colors.grey,
                                            ),
                                            SmallText(
                                              text: controller
                                                  .questDetail.address
                                                  .toString(),
                                            )
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                  // Devider(),
                                  Divider(),
                                ],
                              ),
                              //Information: Description
                              Padding(
                                  padding: EdgeInsets.all(30),
                                  child:
                                      // Text(
                                      //   widget.data!.description,
                                      //   textAlign: TextAlign.justify,
                                      //   style: TextStyle(
                                      //     fontFamily: 'RobotoMono',
                                      //     fontSize: 16,
                                      //   ),
                                      // ),

                                      ExpandedWidget(
                                          text: controller
                                              .questDetail.description)),
                              Padding(
                                padding: EdgeInsets.all(20),
                                child: TodoWidgetV2(
                                    questDetailModel: controller.questDetail),
                              ),
                              SizedBox(
                                  height:
                                      MediaQuery.of(context).size.height * 0.1)
                            ],
                          ),
                        ),
                        SizedBox(
                            height: MediaQuery.of(context).size.height * 0.1)
                      ],
                    ),
                  ),
                  Positioned(
                      bottom: 0,
                      child: Container(
                          color: Colors.white,
                          width: MediaQuery.of(context).size.width,
                          height: MediaQuery.of(context).size.height * 0.075,
                          child: Column(
                            children: [
                              Container(
                                decoration: BoxDecoration(
                                    color: Color(0xFFFF9C00),
                                    gradient: LinearGradient(
                                      begin: Alignment.topRight,
                                      end: Alignment.bottomLeft,
                                      colors: [
                                        Colors.white,
                                        Colors.white,
                                        Colors.grey
                                      ],
                                    ),
                                    borderRadius: BorderRadius.circular(10)),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Padding(
                                        padding:
                                            const EdgeInsets.only(left: 20),
                                        child: BigText(
                                          text: controller.questDetail.price
                                                  .truncate()
                                                  .toString() +
                                              " VNĐ",
                                          color: Colors.black,
                                          size: 32,
                                          fontWeight: FontWeight.w600,
                                        )),
                                    Padding(
                                      padding:
                                          const EdgeInsets.only(right: 20.0),
                                      child: ElevatedButton(
                                        onPressed: () {
                                          // Get.to(StartPage());
                                          // bottomSheet(context);
                                          print("ahaha");
                                          // Get.lazyPut(
                                          //   () => PaymentController(),
                                          // );
                                          // Get.to(PaymentWidgetV2());
                                          Get.toNamed(KPaymentMoMo);
                                        },
                                        child: BigText(
                                          text: 'buy'.tr,
                                          fontWeight: FontWeight.w600,
                                          color: Colors.white,
                                        ),
                                        style: ElevatedButton.styleFrom(
                                          primary: Colors.redAccent,
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
                                    )
                                  ],
                                ),
                              ),
                            ],
                          ))),
                ]),
        ),
      ),
    );
  }

  bottomSheet(BuildContext context) {
    // return showModalBottomSheet<void>(
    //   shape: RoundedRectangleBorder(
    //       borderRadius: BorderRadius.vertical(
    //     top: Radius.circular(20),
    //   )),
    //   isScrollControlled: true,
    //   context: context,
    //   builder: (BuildContext context) {
    //     return StatefulBuilder(
    //         builder: (BuildContext context, StateSetter mystate) {
    //       Get.put(PaymentController());
    //       return Container(
    //         height: 600,
    //         padding: const EdgeInsets.fromLTRB(10.0, 70.0, 20.0, 20.0),
    //         child: Column(
    //           children: <Widget>[
    //             PaymentWidgetV2(),
    //           ],_
    //         ),
    //       );
    //     });
    //   },
    // );
    Get.lazyPut(
      () => PaymentController(),
    );
    return showModalBottomSheet(
        context: context,
        backgroundColor: Colors.transparent,
        builder: (context) => GetBuilder<PaymentController>(
            // specify type as Controller
            init: PaymentController(),
            builder: (value) => WillPopScope(
                  onWillPop: () async {
                    Get.delete<PaymentController>();
                    return true;
                  },
                  child: Container(
                      decoration: BoxDecoration(
                          color: Colors.cyan[50],
                          borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(25.0),
                              topRight: Radius.circular(25.0))),
                      child:
                          //  Column(
                          // children: [
                          PaymentWidgetV2()
                      // ],
                      // ),
                      ),
                )));
  }

  Container _slidableImages() {
    return Container(
      color: Colors.white,
      child: Container(
        height: 320,
        width: double.infinity,
        decoration: BoxDecoration(
          color: Colors.white,
        ),
        child: Carousel(
            dotBgColor: Colors.transparent,
            showIndicator: true,
            dotSize: 5,
            dotSpacing: 15,
            boxFit: BoxFit.cover,
            images: [
              controller.questDetail.imagePath != null
                  ? CustomCacheImage(imageUrl: controller.questDetail.imagePath)
                  : Image.asset('assets/images/logo.png'),
              // controller.questDetail.imagePath != null
              //     ? CustomCacheImage(imageUrl: controller.questDetail.imagePath)
              //     : Image.asset('assets/images/logo.png'),
              // controller.questDetail.imagePath != null
              //     ? CustomCacheImage(imageUrl: controller.questDetail.imagePath)
              //     : Image.asset('assets/images/logo.png'),
            ]),
      ),
    );
  }
}
