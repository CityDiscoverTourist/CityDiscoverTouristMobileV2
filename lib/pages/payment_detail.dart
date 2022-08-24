import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_countdown_timer/current_remaining_time.dart';
import 'package:flutter_countdown_timer/flutter_countdown_timer.dart';
import 'package:get/get.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:travel_hour/models/purchased_quest.dart';
import 'package:travel_hour/widgets/big_text.dart';
import 'package:travel_hour/widgets/dash.dart';
import 'package:travel_hour/widgets/small_text.dart';

import '../config/colors.dart';

class PaymentDetail extends StatelessWidget {
  final PurchasedQuest? purchasedQuest;
  const PaymentDetail({Key? key, this.purchasedQuest}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    int endTime =
        purchasedQuest!.createdDate.millisecondsSinceEpoch + 172800000;
    return WillPopScope(
      onWillPop: () async {
        return true;
      },
      child: Scaffold(
          backgroundColor: Colors.grey.shade200,
          appBar: AppBar(
            title: BigText(
              text: 'payment detail'.tr,
              fontWeight: FontWeight.w700,
              color: Colors.white,
            ),
            centerTitle: true,
            backgroundColor: AppColors.mainColor,
          ),
          body: Padding(
            padding: EdgeInsets.all(10),
            child: SingleChildScrollView(
                child: Column(
              children: [
                Container(
                  margin: EdgeInsets.only(top: 10, left: 10, right: 10),
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.all(Radius.circular(40.0))),
                  child: Column(
                    children: [
                      BigText(
                        text: purchasedQuest!.questName,
                        size: 28,
                        fontWeight: FontWeight.w500,
                      ),
                      purchasedQuest?.imagePath != null
                          ? Image.network(purchasedQuest!.imagePath,
                              width: 300, height: 150, fit: BoxFit.fill)
                          : Container(),
                      // Image.asset('assets/images/logo.png'),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          // BigText(
                          //   text: "play code".tr,
                          //   fontWeight: FontWeight.w600,
                          // ),
                          SizedBox(
                            height: 10,
                          ),
                          // BigText(text: purchasedQuest!.id.toString()),
                          // SizedBox(
                          //   height: 15,
                          // ),
                          // BigText(
                          //   text: "time remaining".tr,
                          //   fontWeight: FontWeight.w600,
                          // ),
                          // SizedBox(
                          //   height: 10,
                          // ),
                          // CountdownTimer(
                          //   endTime: endTime,
                          //   widgetBuilder: (_, CurrentRemainingTime? time) {
                          //     if (time == null) {
                          //       return Text('time up'.tr);
                          //     }
                          //     // return BigText(
                          //     //   text:
                          //     //       '${time.days}d:${time.hours}h:${time.min}m:${time.sec}s',
                          //     //   color: Colors.green,
                          //     // );
                          //     else {
                          //       return BigText(
                          //         text: (() {
                          //           if (time.days != null) {
                          //             return "${time.days}d:${time.hours}h:${time.min}m:${time.sec}s";
                          //           } else if (time.min == null) {
                          //             return "${time.sec}s";
                          //           } else if (time.hours == null) {
                          //             return "${time.min}m:${time.sec}s";
                          //           } else if (time.days == null) {
                          //             return "${time.hours}h:${time.min}m:${time.sec}s";
                          //           } else {
                          //             return "Time up";
                          //           }
                          //         })(),
                          //         color: Colors.green,
                          //       );
                          //     }
                          //   },
                          // ),
                        ],
                      ),
                      Container(
                        child: QrImage(
                          data: purchasedQuest!.id.toString(),
                          version: QrVersions.auto,
                          size: 200.0,
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                    width: double.infinity,
                    margin: EdgeInsets.only(
                      left: 10,
                      right: 10,
                    ),
                    decoration: BoxDecoration(
                        color: Colors.red.shade100,
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(40),
                          topRight: Radius.circular(40),
                        )),
                    child: Column(
                      children: [
                        Container(
                            margin: EdgeInsets.only(left: 25, right: 25),
                            width: double.infinity,
                            height: 5,
                            // color: Colors.red,
                            child: Dash(
                              length: 300,
                              dashThickness: 2,
                            )),
                        Padding(
                          padding: const EdgeInsets.all(15.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              SmallText(
                                text: 'total price'.tr,
                                size: 20,
                              ),
                              BigText(
                                text: purchasedQuest!.totalAmount
                                        .truncate()
                                        .toString() +
                                    " VNĐ",
                                size: 32,
                                fontWeight: FontWeight.w600,
                              ),
                            ],
                          ),
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        Padding(
                          padding: const EdgeInsets.all(15.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              SmallText(
                                text: 'quantity'.tr,
                                size: 20,
                              ),
                              BigText(
                                text: purchasedQuest!.quantity.toString(),
                                size: 22,
                                fontWeight: FontWeight.w600,
                                color: Colors.blue,
                              ),
                            ],
                          ),
                        )
                      ],
                    ))
              ],
            )),
          )),
    );
  }
}
