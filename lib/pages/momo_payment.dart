import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:momo_vn/momo_vn.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';

class MomoPaymentPage extends StatefulWidget {
  @override
  _MomoPaymentPageState createState() => _MomoPaymentPageState();
}

class _MomoPaymentPageState extends State<MomoPaymentPage> {
  late MomoVn _momoPay;
  late PaymentResponse _momoPaymentResult;
  final TextEditingController partnerCodeController = TextEditingController();
  final TextEditingController partnerNameController = TextEditingController();
  final TextEditingController orderInfoController = TextEditingController();
  final TextEditingController orderIdController = TextEditingController();
  // ignore: non_constant_identifier_names
  late String _paymentStatus;
  static String payUrl = "";

  @override
  void initState() {
    super.initState();
    _momoPay = MomoVn();
    _momoPay.on(MomoVn.EVENT_PAYMENT_SUCCESS, _handlePaymentSuccess);
    _momoPay.on(MomoVn.EVENT_PAYMENT_ERROR, _handlePaymentError);
    _paymentStatus = "";
    initPlatformState();
  }

  Future<void> initPlatformState() async {
    if (!mounted) return;
    setState(() {});
  }

  // Future<dynamic> postCreate(String partnerCode, String partnerName,
  //     String orderId, String orderInfo, String signature) async {
  //   const url = 'https://test-payment.momo.vn/v2/gateway/api/create';

  //   final msg = jsonEncode({
  //     "partnerCode": partnerCode,
  //     "partnerName": partnerName,
  //     "storeId": partnerCode,
  //     "requestType": "captureWallet",
  //     "ipnUrl": "https://momo.vn",
  //     "redirectUrl": "https://momo.vn",
  //     "orderId": orderId,
  //     "amount": 150000,
  //     "lang": "vi",
  //     "orderInfo": orderInfo,
  //     "requestId": orderId,
  //     "extraData": "",
  //     "signature": signature
  //   });
  //   final response = await http.post(Uri.parse(url),
  //       headers: {
  //         'Content-Type': 'application/json; charset=UTF-8',
  //       },
  //       body: msg);
  //   print(response.body);
  //   if (response.statusCode == 200) {
  //     var json = jsonDecode(response.body);
  //     payUrl = json['payUrl'];
  //     print(json['payUrl']);
  //     return json;
  //   } else {
  //     //throw HttpRequestException();
  //     throw 'loi';
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    partnerCodeController.text = 'MOMOIR9N20211104';
    partnerNameController.text = 'C??ng ty c??? ph???n Hosco Vi???t Nam';
    orderInfoController.text = '1-DHB.CNT.170225';
    orderIdController.text = '1-DHB.CNT.170225';
    String accessKey = 'EX38Eckrco16SEnE';
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('THANH TO??N QUA ???NG D???NG MOMO'),
        ),
        body: Center(
          child: Column(
            children: <Widget>[
              Column(
                children: [
                  FlatButton(
                    color: Colors.blue,
                    textColor: Colors.white,
                    disabledColor: Colors.grey,
                    disabledTextColor: Colors.black,
                    padding: EdgeInsets.all(8.0),
                    splashColor: Colors.blueAccent,
                    child: Text('DEMO PAYMENT WITH MOMO.VN'),
                    onPressed: () async {
                      MomoPaymentInfo options = MomoPaymentInfo(
                          merchantName: "TTNC&TVKT",
                          appScheme: "MOMOUMGQ111111",
                          merchantCode: 'MOMOUMGQ111111',
                          partnerCode: 'MOMOUMGQ111111',
                          amount: 60000,
                          orderId: '12321312',
                          orderLabel: 'G??i kh??m s???c kho???',
                          merchantNameLabel: "H???N KH??M B???NH",
                          fee: 10,
                          description: 'Thanh to??n h???n kh??m ch???a b???nh',
                          username: '01234567890',
                          partner: 'merchant',
                          extra: "{\"key1\":\"value1\",\"key2\":\"value2\"}",
                          isTestMode: true);
                      try {
                        _momoPay.open(options);
                      } catch (e) {
                        debugPrint(e.toString());
                      }
                    },
                  ),
                ],
              ),
              Text(_paymentStatus.isEmpty ? "CH??A THANH TO??N" : _paymentStatus)
            ],
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
    _momoPay.clear();
  }

  void _setState() {
    _paymentStatus = '???? chuy???n thanh to??n';
    if (_momoPaymentResult.isSuccess == true) {
      _paymentStatus += "\nT??nh tr???ng: Th??nh c??ng.";
      _paymentStatus +=
          "\nS??? ??i???n tho???i: " + _momoPaymentResult.phoneNumber.toString();
      _paymentStatus += "\nExtra: " + _momoPaymentResult.extra!;
      _paymentStatus += "\nToken: " + _momoPaymentResult.token.toString();
    } else {
      _paymentStatus += "\nT??nh tr???ng: Th???t b???i.";
      _paymentStatus += "\nExtra: " + _momoPaymentResult.extra.toString();
      _paymentStatus += "\nM?? l???i: " + _momoPaymentResult.status.toString();
    }
  }

  void _handlePaymentSuccess(PaymentResponse response) {
    setState(() {
      _momoPaymentResult = response;
      _setState();
    });
    Fluttertoast.showToast(
        msg: "TH??NH C??NG: " + response.phoneNumber.toString(),
        toastLength: Toast.LENGTH_SHORT);
  }

  void _handlePaymentError(PaymentResponse response) {
    setState(() {
      _momoPaymentResult = response;
      _setState();
    });
    Fluttertoast.showToast(
        msg: "TH???T B???I: " + response.message.toString(),
        toastLength: Toast.LENGTH_SHORT);
  }
}
