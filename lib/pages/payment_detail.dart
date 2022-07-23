import 'package:dotted_line/dotted_line.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_countdown_timer/current_remaining_time.dart';
import 'package:flutter_countdown_timer/flutter_countdown_timer.dart';
import 'package:travel_hour/models/payment.dart';
import 'package:travel_hour/models/quest.dart';
import 'package:travel_hour/widgets/big_text.dart';
import 'package:travel_hour/widgets/custom_cache_image.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:travel_hour/widgets/small_text.dart';

class PaymentDetail extends StatelessWidget {
  final Payment? payment;
  const PaymentDetail({Key? key, this.payment}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    int endTime = DateTime.now().millisecondsSinceEpoch + 1000 * 100000;
    return Scaffold(
        appBar: AppBar(
          title: BigText(
            text: 'Payment Detail',
            fontWeight: FontWeight.w700,
            color: Colors.white,
          ),
          centerTitle: true,
          backgroundColor: Colors.redAccent,
        ),
        body: Padding(
          padding: EdgeInsets.all(10),
          child: Column(
            children: [
              SingleChildScrollView(
                  child: Column(
                children: [
                  Container(
                    margin: EdgeInsets.all(10),
                    decoration: BoxDecoration(
                        color: Colors.deepOrange.shade100,
                        borderRadius: BorderRadius.all(Radius.circular(10.0))),
                    child: Column(
                      children: [
                        BigText(
                          text: "Thien Duong Dam Sen",
                          size: 28,
                          fontWeight: FontWeight.w500,
                        ),
                        Image.asset('assets/images/logo.png'),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                BigText(
                                  text: "Ma dat quest:",
                                  fontWeight: FontWeight.w600,
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                BigText(text: "ABCXYZ"),
                                SizedBox(
                                  height: 15,
                                ),
                                BigText(
                                  text: "Thoi gian: ",
                                  fontWeight: FontWeight.w600,
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                CountdownTimer(
                                  endTime: endTime,
                                  widgetBuilder:
                                      (_, CurrentRemainingTime? time) {
                                    if (time == null) {
                                      return Text('Availble');
                                    }
                                    return BigText(
                                      text:
                                          ' ${time.days}d:${time.hours}h:${time.min}m:${time.sec}s',
                                      color: Colors.green,
                                    );
                                  },
                                ),
                              ],
                            ),
                            Container(
                              child: QrImage(
                                data: "1234567890",
                                version: QrVersions.auto,
                                size: 200.0,
                              ),
                            ),
                          ],
                        ),
                        DottedLine(
                          dashGradient: [
                            Colors.red,
                            Colors.red.withAlpha(0),
                          ],
                          dashGapGradient: [
                            Colors.blue,
                            Colors.blue.withAlpha(0),
                          ],
                          dashLength: 10,
                          dashGapLength: 10,
                          lineThickness: 15,
                        ),
                      ],
                    ),
                  ),
                  Container(
                      width: double.infinity,
                      margin: EdgeInsets.only(left: 10, right: 10, top: 5),
                      decoration: BoxDecoration(
                        color: Colors.deepOrange.shade100,
                        // borderRadius: BorderRadius.all(Radius.circular(10.0))),
                      ),
                      child: Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              SmallText(
                                text: 'Amount:',
                                size: 20,
                              ),
                              BigText(
                                text: '160.000 VND',
                                size: 32,
                                fontWeight: FontWeight.w600,
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 15,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              SmallText(
                                text: 'Code transaction:',
                                size: 20,
                              ),
                              BigText(
                                text: 'GD187463973',
                                size: 22,
                                fontWeight: FontWeight.w600,
                                color: Colors.blue,
                              ),
                            ],
                          ),
                        ],
                      ))
                ],
              )),
              SizedBox(
                height: 15,
              ),
            ],
          ),
        ));
  }
}
