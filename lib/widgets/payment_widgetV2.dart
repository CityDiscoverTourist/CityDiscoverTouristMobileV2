import 'dart:convert';
import 'dart:ffi';
import 'package:dotted_line/dotted_line.dart';
import 'package:app_links/app_links.dart';
import 'package:crypto/crypto.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:momo_vn/momo_vn.dart';
import 'package:travel_hour/controllers/payment_controller.dart';
import 'package:travel_hour/controllers/play_controller.dart';
import 'package:travel_hour/controllers/play_controllerV2.dart';
import 'package:travel_hour/controllers/questdetail_controller.dart';
import 'package:travel_hour/controllers/voucher_controller.dart';
import 'package:travel_hour/models/quest.dart';
import 'package:http/http.dart' as http;
import 'package:travel_hour/models/quest_detail.dart';
import 'package:travel_hour/pages/momo_web_payment.dart';
import 'package:travel_hour/pages/splashV2.dart';
import 'package:travel_hour/widgets/big_text.dart';
import 'package:travel_hour/widgets/custom_cache_image.dart';
// import 'package:travel_hour/widgets/discount.dart';
import 'package:travel_hour/widgets/small_text.dart';
import 'package:uuid/uuid.dart';

import '../controllers/history_controller.dart';
import '../controllers/home_controller.dart';
import '../controllers/login_controller_V2.dart';
import '../models/payment.dart';
import '../models/reward.dart';
import '../pages/quest_play.dart';
import 'custom_text.dart';

class PaymentWidgetV2 extends GetView<PaymentController> {
  static const String? paymentStatus2 = "";

  var voucherCtl = TextEditingController();
  // GlobalKey<FormState> _key = new GlobalKey();

  // String partnerCode = 'MOMOXOUE20220626';
  // String partnerName = 'City Discover Tourist';
  // String accessKey = 'YQz23DOoGwYM0FC4';
  QuestDetail questDetail = Get.find<QuestDetailController>().questDetail;
  @override
  Widget build(BuildContext context) {
    return Obx(
      () => controller.isLoading.isTrue
          ? Center(
              child: CircularProgressIndicator(color: Colors.redAccent),
            )
          : WillPopScope(
              onWillPop: () async {
                controller.paymentStatus.value = "";
                Navigator.pop(context);
                return true;
              },
              child: Scaffold(
                appBar: AppBar(
                  title: Text('payment page'.tr),
                  backgroundColor: Colors.redAccent,
                  // actions: [
                  //   IconButton(
                  //       onPressed: () {
                  //         controller.paymentStatus.value = "";
                  //         Navigator.pop(context);
                  //       },
                  //       icon: Icon(Icons.arrow_back))
                  // ],
                ),
                body: Stack(
                  children: [
                    SingleChildScrollView(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Container(
                            width: double.infinity,
                            height: MediaQuery.of(context).size.height * 0.3,
                            margin:
                                EdgeInsets.only(top: 10, right: 10, left: 10),
                            decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(20),
                                boxShadow: [
                                  BoxShadow(
                                      color: Colors.grey.withOpacity(.5),
                                      blurRadius: 15)
                                ]),
                            child: ListTile(
                              title: BigText(
                                text: questDetail.title,
                                fontWeight: FontWeight.bold,
                              ),
                              subtitle: Column(
                                children: [
                                  SizedBox(
                                    height: 20,
                                  ),
                                  SizedBox(
                                    height: 200,
                                    width: double.infinity,
                                    child: questDetail.imagePath != null
                                        ? CustomCacheImage(
                                            imageUrl: questDetail.imagePath)
                                        : Image.asset('assets/images/logo.png'),
                                  )
                                ],
                              ),
                            ),
                          ),
                          // Row(children: [
                          //Container Giam gia
                          Get.find<RewardController>().rewardsList.length != 0
                              ? RewardWidget()
                              : SizedBox.shrink(),
                          //Container code san
                          Container(
                            // height: MediaQuery.of(context).size.height*0.4,
                            margin: EdgeInsets.only(left: 10, right: 10),
                            decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(10),
                                boxShadow: [
                                  BoxShadow(
                                      color: Colors.grey.withOpacity(.5),
                                      blurRadius: 15)
                                ]),
                            child: Wrap(
                              children: [
                                // Row(
                                //   children: [
                                //     SizedBox(
                                //       width: 10,
                                //     ),
                                //     Padding(
                                //       padding:
                                //           const EdgeInsets.symmetric(horizontal: 10),
                                //       child: CustomText(
                                //         text: "item".tr,
                                //         color: Colors.grey,
                                //       ),
                                //     ),
                                //     Flexible(
                                //         child: CustomText(
                                //       text: Get.find<QuestDetailController>()
                                //           .questDetail
                                //           .title,
                                //       color: Colors.black,
                                //       weight: FontWeight.bold,
                                //     )),
                                //     SizedBox(
                                //       width: 5,
                                //     )
                                //   ],
                                // ),
                                // controller.paymentStatus.isEmpty
                                //     ? Divider()
                                //     : Container(),
                                controller.paymentStatus.isEmpty
                                    ? ListTile(
                                        title: CustomText(
                                          text: "quantity".tr,
                                        ),
                                        trailing: Container(
                                          height: 200,
                                          width: 200,
                                          decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(5),
                                          ),
                                          child: Row(
                                            children: [
                                              Expanded(
                                                child: RaisedButton(
                                                  onPressed: () async {
                                                    controller
                                                        .decreaseQuantity();
                                                  },
                                                  child: Icon(
                                                    Icons.remove,
                                                    color: Colors.white,
                                                    size: 13,
                                                  ),
                                                ),
                                              ),
                                              Container(
                                                margin: EdgeInsets.symmetric(
                                                    horizontal: 3),
                                                padding: EdgeInsets.symmetric(
                                                    horizontal: 3, vertical: 2),
                                                decoration: BoxDecoration(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            3),
                                                    color: Colors.white),
                                                child: Text(
                                                  controller.quantity2
                                                      .toString(),
                                                  style: TextStyle(
                                                      color: Colors.black,
                                                      fontSize: 16),
                                                ),
                                              ),
                                              RaisedButton(
                                                  onPressed: () async {
                                                    controller
                                                        .increaseQuantity();
                                                  },
                                                  child: Icon(
                                                    Icons.add,
                                                    color: Colors.white,
                                                    size: 13,
                                                  )),
                                            ],
                                          ),
                                        ),
                                      )
                                    : Container(),

                                controller.paymentStatus.isEmpty &
                                        controller.idRewardChoose.isNotEmpty
                                    ? Divider()
                                    : Container(),
                                controller.paymentStatus.isEmpty &
                                        controller.idRewardChoose.isNotEmpty
                                    ?
                                    //  ListView.builder(
                                    //   scrollDirection: Axis.horizontal,
                                    //     itemCount:
                                    //         Get.find<HomeController>().rewardList.length -
                                    //             1,
                                    //     itemBuilder: (context, index) => PromotionItem(
                                    //         Get.find<HomeController>().rewardList[index]),
                                    //   )
                                    // Column(
                                    //     children: [
                                    //       BigText(
                                    //           text: controller.idRewardChoose
                                    //               .toString())
                                    //     ],
                                    //   )
                                    ListTile(
                                        title: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            BigText(
                                                text: 'enter voucher here'.tr),
                                            BigText(
                                                text: controller.percentReward
                                                            .value !=
                                                        0
                                                    ? controller
                                                            .percentReward.value
                                                            .toString() +
                                                        " %"
                                                    : "")
                                          ],
                                        ),
                                        subtitle: SmallText(
                                            text: controller.idRewardChoose
                                                .toString()),
                                      )

                                    // Form(
                                    //     key: _key,
                                    //     child: TextFormField(
                                    //       keyboardType: TextInputType.text,
                                    //       autofocus: false,
                                    //       decoration: InputDecoration(
                                    //         hintText: 'enter voucher here'.tr,
                                    //       ),
                                    //       controller: voucherCtl,
                                    //       onChanged: (value) =>
                                    //           controller.voucherCtl.value = value,
                                    //       validator: (value) {
                                    //         // String patttern =
                                    //         //     r'^[0-9a-f]{8}-[0-9a-f]{4}-[0-9a-f]{4}-[0-9a-f]{4}-[0-9a-f]{12}$';
                                    //         RegExp regExp = new RegExp(
                                    //             "[0-9a-f]{8}-[0-9a-f]{4}-[0-9a-f]{4}-[0-9a-f]{4}-[0-9a-f]{12}");
                                    //         if (value!.isEmpty) {
                                    //           return null;
                                    //         } else if (!regExp.hasMatch(value)) {
                                    //           return "voucher is wrong format".tr;
                                    //         }
                                    //         return null;
                                    //       },
                                    //     ),
                                    //   )
                                    : Container(),
                                Divider(),
                                ListTile(
                                  title: CustomText(
                                    text: "temporary amount".tr,
                                  ),
                                  trailing: CustomText(
                                    text:
                                        controller.total.truncate().toString() +
                                            " VND",
                                    color: Colors.green,
                                  ),
                                ),

                                Divider(),
                                ListTile(
                                  title: CustomText(
                                    text: "amount reduced".tr,
                                  ),
                                  trailing: CustomText(
                                    text: controller.discountPrice
                                            .truncate()
                                            .toString() +
                                        " VND",
                                    color: Colors.green,
                                  ),
                                ),

                                Divider(),

                                ListTile(
                                  title: CustomText(
                                    text: "total price".tr,
                                  ),
                                  trailing: CustomText(
                                    text: controller.finalTotal
                                            .truncate()
                                            .toString() +
                                        " VND",
                                    color: Colors.green,
                                  ),
                                ),

                                Divider(),
                                ListTile(
                                  title: CustomText(
                                    text: "payment status".tr,
                                    color: Colors.grey,
                                  ),
                                  trailing: CustomText(
                                    text: controller.paymentStatus.isEmpty
                                        ? "not yet paid".tr
                                        : controller.paymentStatus.value,
                                    color: Colors.green,
                                  ),
                                ),
                                // Divider(),
                                controller.paymentStatus.isEmpty
                                    ? Container()
                                    : Divider(),
                                controller.paymentStatus.isEmpty
                                    ? Container()
                                    : ListTile(
                                        title: CustomText(
                                          text: "play code".tr +
                                              controller.playCode,
                                          // color: Colors.grey,
                                        ),
                                        trailing: RaisedButton(
                                          child: Text('copy'.tr),
                                          onPressed: () {
                                            Clipboard.setData(new ClipboardData(
                                                    text: controller.playCode))
                                                .then((_) {
                                              ScaffoldMessenger.of(context)
                                                  .showSnackBar(SnackBar(
                                                      content:
                                                          Text('copy'.tr)));
                                            });
                                          },
                                        ),
                                      ),
                                Divider(),
                                ButtonTheme(
                                  child: new ButtonBar(
                                    alignment: MainAxisAlignment.center,
                                    children: <Widget>[
                                      // controller.paymentStatus.value!="Đã chuyển thanh toán"?
                                      // new RaisedButton(
                                      //   child: Text('cancel'.tr),
                                      //   onPressed: () {
                                      //     controller.paymentStatus.value = "";
                                      //     Navigator.pop(context);
                                      //   },
                                      // ):SizedBox.shrink(),

                                      // new RaisedButton(
                                      //   // child: const Text('Xác nhận thanh toán'),
                                      //   child: controller.paymentStatus.isEmpty
                                      //       ? Text('cofirm payment'.tr)
                                      //       : Text('cofirm'.tr),
                                      //   onPressed: controller.paymentStatus.value.isEmpty
                                      //       ? _sendToServer
                                      //       : () {
                                      //           Navigator.pop(context);
                                      //         },
                                      // ),
//Nút chơi ngay
                                      // controller.paymentStatus.isEmpty
                                      //     ? Container()
                                      //     : new RaisedButton(
                                      //         child: const Text('Chơi ngay'),
                                      //         onPressed: () => {
                                      //           Get.put(HistoryController()),
                                      //           Get.to(QuestsPlayPage())
                                      //         },
                                      //       ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(
                            height: 40,
                          )
                        ],
                      ),
                    ),
                    Positioned(
                      bottom: 0,
                      left: 0,
                      right: 0,
                      child: RaisedButton(
                        color: Colors.redAccent,
                        // child: const Text('Xác nhận thanh toán'),
                        child: controller.paymentStatus.isEmpty
                            ? BigText(text: 'cofirm payment'.tr)
                            : BigText(text: 'cofirm'.tr),
                        onPressed: controller.paymentStatus.value.isEmpty
                            ? _sendToServer
                            : () {
                                Navigator.pop(context);
                              },
                      ),
                    ),
                  ],
                ),
              ),
            ),
    );
  }

  _sendToServer() async {
    if (controller.paymentStatus.isEmpty) {
      List? map = await controller.buyQuest(
          controller.playCode,
          Get.find<LoginControllerV2>().sp.id,
          Get.find<QuestDetailController>().questDetail.id.toString(),
          controller.quantity2.value,
          controller.finalTotal.value,
          controller.idRewardChoose.value);
      if (map != null) {
        Get.to(() => MoMoWebView(
              url: map.first,
            ));
      } else {
        Get.snackbar("discount code is not valid".tr, 'try again'.tr,
            duration: Duration(seconds: 2),
            backgroundColor: Colors.black,
            colorText: Colors.white,
            snackPosition: SnackPosition.BOTTOM,
            icon: Icon(
              Icons.error,
              color: Colors.red,
            ));
      }
    }
    // } else {
    //   // setState(() {
    //   print(_key.currentState!.validate());
    //   // _validate = true;
    //   // });
    // }
  }
}

class RewardWidget extends StatelessWidget {
  const RewardWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: MediaQuery.of(context).size.height * 0.15,
      margin: EdgeInsets.only(left: 10, right: 10),
      decoration: BoxDecoration(
          color: Colors.blueGrey[50],
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(20),
            topRight: Radius.circular(20),
          ),
          boxShadow: [
            BoxShadow(color: Colors.grey.withOpacity(.5), blurRadius: 15)
          ]),
      child: Expanded(
          flex: 90,
          child: ListView.builder(
            padding: EdgeInsets.zero,
            shrinkWrap: true,
            scrollDirection: Axis.horizontal,
            itemCount: Get.find<HomeController>().rewardList.length - 1,
            itemBuilder: (context, index) => Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                DiscountWidget(
                    rewardModel:
                        Get.find<RewardController>().rewardsList[index]),
              ],
            ),
          )),
    );
  }
}

class DiscountWidget extends GetView<PaymentController> {
  final Reward rewardModel;
  DiscountWidget({Key? key, required this.rewardModel}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Row(
          // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          // mainAxisAlignment: MainAxisAlignment.start,
          // crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              margin: EdgeInsets.only(left: 10),
              width: 7,
              height: 90,
              decoration: const BoxDecoration(
                color: Colors.redAccent,
                borderRadius: BorderRadius.horizontal(
                  left: Radius.circular(5),
                ),
              ),
            ),
            InkWell(
              onTap: () {
                if (controller.idRewardChoose.value == rewardModel.code) {
                  controller.idRewardChoose.value = "";
                  controller.percentReward.value = 0;
                  controller.checkTotal();
                } else {
                  controller.idRewardChoose.value = rewardModel.code;
                  controller.percentReward.value = rewardModel.percentDiscount;
                  controller.checkTotal();
                }
                // Future.delayed(Duration(seconds: 2));
                print(rewardModel.code);
              },
              child: Container(
                width: 210,
                height: 90,
                padding: const EdgeInsets.only(left: 20),
                decoration: BoxDecoration(
                  color: controller.idRewardChoose.value == rewardModel.code
                      ? Colors.redAccent.withOpacity(0.1)
                      : Colors.white,
                  borderRadius: const BorderRadius.horizontal(
                    right: Radius.circular(20),
                  ),
                  border: Border.all(
                    color:
                        //  controller.selectedPromotionIndex.value ==
                        //         index
                        //     ? PRIMARY_COLOR
                        //     :
                        Colors.transparent,
                  ),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      rewardModel.name,
                      textAlign: TextAlign.center,
                      style: GoogleFonts.quicksand(
                        color: const Color.fromARGB(255, 77, 82, 105),
                        fontWeight: FontWeight.w600,
                        fontSize: 15,
                        height: 1,
                      ),
                    ),
                    const SizedBox(
                      height: 3,
                    ),
                    Text(
                      'discount'.tr + ' ${rewardModel.percentDiscount}%',
                      textAlign: TextAlign.start,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: GoogleFonts.quicksand(
                        color: const Color.fromARGB(255, 77, 82, 105),
                        fontWeight: FontWeight.w700,
                        fontSize: 17,
                        height: 1,
                        letterSpacing: 1,
                      ),
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    // Text(
                    //   'Apply money:',
                    //   // ${FORMAT_MONEY(price: promotionModel.applyMoney)}',
                    //   textAlign: TextAlign.center,
                    //   style: GoogleFonts.quicksand(
                    //     color: const Color.fromARGB(255, 127, 133, 161),
                    //     fontWeight: FontWeight.w500,
                    //     fontSize: 13,
                    //     height: 1,
                    //   ),
                    // ),
                    // const SizedBox(
                    //   height: 5,
                    // ),
                    // Text(
                    //   'Required point:',
                    //   //  ${FORMAT_MONEY_WITHOUT_SYMBOL(price: promotionModel.point)}',
                    //   textAlign: TextAlign.center,
                    //   style: GoogleFonts.quicksand(
                    //     color: const Color.fromARGB(255, 127, 133, 161),
                    //     fontWeight: FontWeight.w500,
                    //     fontSize: 13,
                    //     height: 1,
                    //   ),
                    // ),
                    // const SizedBox(
                    //   height: 5,
                    // ),
                    // Text(
                    //   'Exp.Date: ${FORMAT_DATE_TIME(dateTime: promotionModel.expireTime, pattern: DATE_PATTERN)}',
                    //   textAlign: TextAlign.center,
                    //   style: GoogleFonts.quicksand(
                    //     color:
                    //         const Color.fromARGB(255, 127, 133, 161),
                    //     fontWeight: FontWeight.w500,
                    //     fontSize: 13,
                    //     height: 1,
                    //   ),
                    // ),
                  ],
                ),
              ),
            ),
          ]),
    );
  }
}
