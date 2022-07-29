import 'dart:convert';
import 'dart:ffi';

import 'package:app_links/app_links.dart';
import 'package:crypto/crypto.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:momo_vn/momo_vn.dart';
import 'package:travel_hour/controllers/play_controller.dart';
import 'package:travel_hour/controllers/play_controllerV2.dart';
import 'package:travel_hour/models/quest.dart';
import 'package:http/http.dart' as http;
import 'package:travel_hour/pages/momo_web_payment.dart';
import 'package:uuid/uuid.dart';

import '../controllers/history_controller.dart';
import '../controllers/home_controller.dart';
import '../controllers/login_controller_V2.dart';
import '../models/payment.dart';
import '../pages/quest_play.dart';
import 'custom_text.dart';

class PaymentWidget extends StatefulWidget {
  final Quest quest;
  final int quantity;
  final totalAmout;
  static const String? paymentStatus2 = "";

  const PaymentWidget(
      {Key? key,
      required this.quest,
      required this.quantity,
      required this.totalAmout})
      : super(key: key);

  @override
  State<PaymentWidget> createState() => PaymentWidgetState();
}

class PaymentWidgetState extends State<PaymentWidget>
    with WidgetsBindingObserver {
  late MomoVn _momoPay;
  late PaymentResponse _momoPaymentResult;
  late String _paymentStatus;
  int quantity2 = 0;
  var total;
  var uuid = Uuid();
  static String payUrl = "";
  var playCode;
  var voucherCtl = TextEditingController();

  String partnerCode = 'MOMOXOUE20220626';
  String partnerName = 'City Discover Tourist';
  String accessKey = 'YQz23DOoGwYM0FC4';
  // StreamSubscription<Uri>? _linkSubscription;

  @override
  Future<void> didChangeAppLifecycleState(AppLifecycleState state) async {
    switch (state) {
      case AppLifecycleState.resumed:
        // --
        print('App in Resumed');
        // var controller = Get.find<PlayController>();
        PlayControllerV2 controller = new PlayControllerV2();
        // ignore: unrelated_type_equality_checks
        bool check = await controller.checkPaymentStatus(playCode);
        print(check);
        if (check == true) {
          print(_paymentStatus);
          setState(() {
            _paymentStatus = "Thanh toan thanh cong";
          });
        } else {
          setState(() {
            _paymentStatus = "";
          });
        }
        break;
      case AppLifecycleState.inactive:
        // --
        print('App in Inactive');
        break;
      case AppLifecycleState.paused:
        // --
        print('App in Paused');
        break;
      case AppLifecycleState.detached:
        // --
        print('App in Detached');
        setState(() {
          _paymentStatus = "";
        });
        break;
    }
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    _momoPay = MomoVn();
    _momoPay.on(MomoVn.EVENT_PAYMENT_SUCCESS, _handlePaymentSuccess);
    _momoPay.on(MomoVn.EVENT_PAYMENT_ERROR, _handlePaymentError);
    _paymentStatus = "";
    initPlatformState();
    quantity2 = widget.quantity;
    total = widget.totalAmout;
    playCode = uuid.v4();
  }

  Future<void> initPlatformState() async {
    if (!mounted) return;
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    var quest;
    final key = new GlobalKey<ScaffoldState>();
    // print("CustomerId:" + Get.find<HomeController>().sp.id);
    // print("QuestID:" + widget.quest.id.toString());
    // print("Quantoty:" + quantity2.toString());
    // print("Total:" + total.toString());
    return Container(
      margin: EdgeInsets.all(10),
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
          boxShadow: [
            BoxShadow(color: Colors.grey.withOpacity(.5), blurRadius: 15)
          ]),
      child: Wrap(
        children: [
          Row(
            children: [
              SizedBox(
                width: 10,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: CustomText(
                  text: "item".tr,
                  color: Colors.grey,
                ),
              ),
              Flexible(
                  child: CustomText(
                text: widget.quest.title,
                color: Colors.black,
                weight: FontWeight.bold,
              )),
              // Expanded(child: Container()),
              SizedBox(
                width: 5,
              )
            ],
          ),
          _paymentStatus.isEmpty ? Divider() : Container(),
          _paymentStatus.isEmpty
              ? ListTile(
                  title: CustomText(
                    // text: widget.quest.title.toString(),
                    text: "quantity".tr,
                  ),
                  // subtitle: CustomText(
                  //   text: quantity.toString(),
                  // ),
                  trailing: Container(
                    // padding: EdgeInsets.all(3),
                    height: 200,
                    width: 200,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5),
                      // color: Theme.of(context).accentColor
                    ),
                    child: Row(
                      children: [
                        RaisedButton(
                            onPressed: () async {
                              setState(() {
                                quantity2 = quantity2 - 1;
                                total = quantity2 * widget.quest.price;
                              });
                            },
                            child: Icon(
                              Icons.remove,
                              color: Colors.white,
                              size: 13,
                            )),
                        Container(
                          margin: EdgeInsets.symmetric(horizontal: 3),
                          padding:
                              EdgeInsets.symmetric(horizontal: 3, vertical: 2),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(3),
                              color: Colors.white),
                          child: Text(
                            quantity2.toString(),
                            style: TextStyle(color: Colors.black, fontSize: 16),
                          ),
                        ),
                        RaisedButton(
                            onPressed: () async {
                              setState(() {
                                quantity2 = quantity2 + 1;
                                total = quantity2 * widget.quest.price;
                              });
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
          // Column(
          //     children: widget.listPayment
          //         .map((item) =>
          //         ListTile(
          //               title: CustomText(
          //                 text: item.title.toString(),
          //               ),
          //               subtitle: CustomText(
          //                 text: widget.quantity.toString(),
          //               ),
          //               trailing: CustomText(
          //                 text: widget.totalAmout.toString(),
          //               ),
          //             ))
          //         .toList()),
          Divider(),
          TextFormField(
            keyboardType: TextInputType.emailAddress,
            autofocus: false,
            decoration: InputDecoration(
              hintText: 'enter voucher here'.tr,
            ),
            controller: voucherCtl,
            // validator: (value) {
            //   if (value!.length == 0) return "Address can't be empty";
            //   return null;
            // },
            // onSaved: (String? value) {
            //   userName = value!;
            // },
            onEditingComplete: () {
              print(voucherCtl.text);
            },
          ),
          Divider(),
          ListTile(
            title: CustomText(
              text: "total price".tr,
            ),
            trailing: CustomText(
              text: total.toString() + " VND",
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
              text: _paymentStatus.isEmpty ? "not yet paid".tr : _paymentStatus,
              color: Colors.green,
            ),
          ),
          // Divider(),
          _paymentStatus.isEmpty ? Container() : Divider(),
          _paymentStatus.isEmpty
              ? Container()
              : ListTile(
                  title: CustomText(
                    text: "play code".tr + playCode,
                    // color: Colors.grey,
                  ),
                  trailing: RaisedButton(
                    child: Text('copy'.tr),
                    onPressed: () {
                      Clipboard.setData(new ClipboardData(text: playCode))
                          .then((_) {
                        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                            content: Text('Copied to your clipboard !')));
                      });
                    },
                  ),
                ),
          // ListTile(
          //   title: CustomText(
          //     text: "Mã chơi : 032138921389",
          //     // color: Colors.grey,
          //   ),
          //   trailing: RaisedButton(
          //     child: const Text('Copy'),
          //     onPressed: () {
          //       Clipboard.setData(new ClipboardData(text: "ádasdassdasdasdas"))
          //           .then((_) {
          //         ScaffoldMessenger.of(context).showSnackBar(
          //             SnackBar(content: Text('Copied to your clipboard !')));
          //       });
          //     },
          //   ),
          // ),

          Divider(),
          // RaisedButton(
          //   child: const Text('Hủy'),
          //   onPressed: () => Navigator.pop(context),
          // ),
          ButtonTheme(
            child: new ButtonBar(
              alignment: MainAxisAlignment.center,
              children: <Widget>[
                new RaisedButton(
                  child: Text('cancel'.tr),
                  onPressed: () {
                    _paymentStatus = "";
                    Navigator.pop(context);
                  },
                ),
                new RaisedButton(
                  // child: const Text('Xác nhận thanh toán'),
                  child: _paymentStatus.isEmpty
                      ? Text('cofirm payment'.tr)
                      : Text('cofirm'.tr),
                  onPressed: () async {
                    // MomoPaymentInfo options = MomoPaymentInfo(
                    //     merchantName: "TTNC&TVKT",
                    //     appScheme: "MOMOXOUE20220626",
                    //     merchantCode: 'MOMOXOUE20220626',
                    //     partnerCode: 'MOMOXOUE20220626',
                    //     amount: total.round(),
                    //     orderId: '41e879aa-859c-4bda-b77b-37b7e07c6674',
                    //     orderLabel: 'Mua Quest' + widget.quest.title,
                    //     merchantNameLabel: "Mua Quest",
                    //     fee: 0,
                    //     description: 'Thanh toán mua Quest',
                    //     username: 'Ciity Discover Tourist',
                    //     partner: 'merchant',
                    //     // extra: "{\"key1\":\"value1\",\"key2\":\"value2\"}",
                    //     isTestMode: true);
                    if (_paymentStatus.isEmpty) {
                      PlayControllerV2 controller = new PlayControllerV2();

                      List? map = await controller.buyQuest(
                          playCode,
                          Get.find<LoginControllerV2>().sp.id,
                          widget.quest.id.toString(),
                          quantity2,
                          total,
                          null);
                      // Get.to(QuestsPlayPage());
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => MoMoWebView(
                                    url: map!.first,
                                  )));
                    } else {
                      Navigator.pop(context);
                    }
                    // try {
                    //   _momoPay.open(options);
                    // } catch (e) {
                    //   debugPrint(e.toString());
                    // }
                  },
                ),
                _paymentStatus.isEmpty
                    ? Container()
                    : new RaisedButton(
                        child: const Text('Chơi ngay'),
                        onPressed: () => {
                          Get.put(HistoryController()),
                          Get.to(QuestsPlayPage())
                        },
                      ),
              ],
            ),
          ),
          // RaisedButton(
          //   child: const Text('Xác nhận thanh toán'),
          //   onPressed: () async {
          //     MomoPaymentInfo options = MomoPaymentInfo(
          //         merchantName: "TTNC&TVKT",
          //         appScheme: "MOMOXOUE20220626",
          //         merchantCode: 'MOMOXOUE20220626',
          //         partnerCode: 'MOMOXOUE20220626',
          //         amount: widget.totalAmout,
          //         orderId: '12321312',
          //         orderLabel: 'Mua Quest' + widget.quest.title,
          //         merchantNameLabel: "Mua Quest",
          //         fee: 10,
          //         description: 'Thanh toán mua Quest',
          //         username: 'Ciity Discover Tourist',
          //         partner: 'merchant',
          //         extra: "{\"key1\":\"value1\",\"key2\":\"value2\"}",
          //         isTestMode: true);
          //     try {
          //       _momoPay.open(options);
          //     } catch (e) {
          //       debugPrint(e.toString());
          //     }
          //   },
          // )
        ],
      ),
    );
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();

    _momoPay.clear();
  }

  void _setState() {
    _paymentStatus = 'Đã chuyển thanh toán';
    if (_momoPaymentResult.isSuccess == true) {
      // _paymentStatus += "\nTình trạng: Thành công.";
      // _paymentStatus +=
      //     "\nSố điện thoại: " + _momoPaymentResult.phoneNumber.toString();
      // _paymentStatus += "\nExtra: " + _momoPaymentResult.extra!;
      // _paymentStatus += "\nToken: " + _momoPaymentResult.token.toString();
    } else {
      // _paymentStatus += "\nTình trạng: Thất bại.";
      // _paymentStatus += "\nExtra: " + _momoPaymentResult.extra.toString();
      // _paymentStatus += "\nMã lỗi: " + _momoPaymentResult.status.toString();
    }
  }

  void _handlePaymentSuccess(PaymentResponse response) {
    setState(() {
      _momoPaymentResult = response;
      _setState();
    });
    Fluttertoast.showToast(
        msg: "THÀNH CÔNG: " + response.phoneNumber.toString(),
        toastLength: Toast.LENGTH_SHORT);
  }

  void _handlePaymentError(PaymentResponse response) {
    setState(() {
      _momoPaymentResult = response;
      _setState();
    });
    Fluttertoast.showToast(
        msg: "THẤT BẠI: " + response.message.toString(),
        toastLength: Toast.LENGTH_SHORT);
  }
}
