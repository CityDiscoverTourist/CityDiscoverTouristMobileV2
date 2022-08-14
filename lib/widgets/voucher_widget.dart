import 'dart:math';

import 'package:coupon_uikit/coupon_uikit.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_countdown_timer/current_remaining_time.dart';
import 'package:flutter_countdown_timer/flutter_countdown_timer.dart';
import 'package:get/get.dart';
import 'package:travel_hour/models/reward.dart';

import 'big_text.dart';

class VoucherWidget extends StatefulWidget {
  final Reward reward;
  const VoucherWidget({Key? key, required this.reward}) : super(key: key);

  @override
  State<VoucherWidget> createState() => _VoucherWidgetState();
}

class _VoucherWidgetState extends State<VoucherWidget> {
  @override
  void initState() {
    super.initState();
    //YOUR CHANGE PAGE METHOD HERE
  }
  @override
  Widget build(BuildContext context) {
 int endTime = widget.reward.expiredDate.millisecondsSinceEpoch + 172800000;

    return CouponCard(
      height: 300,
      curvePosition: 180,
      curveRadius: 30,
      borderRadius: 10,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            Colors.primaries[Random().nextInt(Colors.primaries.length)],
            Colors.primaries[Random().nextInt(Colors.primaries.length)],
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
      ),
      firstChild: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            widget.reward.name,
            style: TextStyle(
              color: Colors.white54,
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 10),
          Text(
            widget.reward.percentDiscount.toString() + '%',
            style: TextStyle(
              color: Colors.white,
              fontSize: 56,
              fontWeight: FontWeight.bold,
            ),
          ),
          // Text(
          //   widget.reward.expiredDate.toString(),
          //   style: TextStyle(
          //     color: Colors.white,
          //     fontSize: 26,
          //     fontWeight: FontWeight.bold,
          //   ),
          // ),
          SizedBox(height: 15,),
          CountdownTimer(
                        endTime: endTime,
                        widgetBuilder: (_, CurrentRemainingTime? time) {
                          if (time == null) {
                            return Text('time up'.tr);
                          }
                          // return BigText(
                          //   text:
                          //       '${time.days}d:${time.hours}h:${time.min}m:${time.sec}s',
                          //   color: Colors.green,
                          // );
                          else {
                            return BigText(
                              text: (() {
                                if (time.days != null) {
                                  return "time remaining".tr +
                                      " ${time.days}d:${time.hours}h:${time.min}m:${time.sec}s";
                                } else if (time.min == null) {
                                  return "time remaining".tr + " ${time.sec}s";
                                } else if (time.hours == null) {
                                  return "time remaining".tr +
                                      "${time.min}m:${time.sec}s";
                                } else if (time.days == null) {
                                  return "time remaining".tr +
                                      " ${time.hours}h:${time.min}m:${time.sec}s";
                                } else {
                                  return "time up".tr;
                                }
                              })(),
                              color: Colors.white,fontWeight: FontWeight.bold,
                            );
                          }
                        },
                      ),
        ],
      ),
      secondChild: Container(
        width: double.maxFinite,
        decoration: const BoxDecoration(
          border: Border(
            top: BorderSide(color: Colors.white),
          ),
        ),
        padding: const EdgeInsets.symmetric(vertical: 24, horizontal: 42),
        child: ElevatedButton(
          style: ButtonStyle(
            shape: MaterialStateProperty.all<RoundedRectangleBorder>(
              RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(60),
              ),
            ),
            padding: MaterialStateProperty.all<EdgeInsetsGeometry>(
              const EdgeInsets.symmetric(horizontal: 80),
            ),
            backgroundColor: MaterialStateProperty.all<Color>(
              Colors.white,
            ),
          ),
          onPressed: () {
            Clipboard.setData(new ClipboardData(text: widget.reward.code))
                .then((_) {
              ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text('Copied to your clipboard !')));
            });
          },
          child: Text(
            'copy code'.tr,
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: Colors.purple,
            ),
          ),
        ),
      ),
    );
  }
}
