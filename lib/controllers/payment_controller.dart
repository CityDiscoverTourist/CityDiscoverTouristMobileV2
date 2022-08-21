import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:momo_vn/momo_vn.dart';
import 'package:travel_hour/controllers/play_controllerV2.dart';
import 'package:travel_hour/controllers/questdetail_controller.dart';
import 'package:travel_hour/models/quest_detail.dart';
import 'package:travel_hour/models/reward.dart';
import 'package:uuid/uuid.dart';

import '../common/customFullScreenDialog.dart';
import '../services/play_service.dart';

class PaymentController extends FullLifeCycleController
    with FullLifeCycleMixin {
  static const String? paymentStatus2 = "";

  late MomoVn _momoPay;
  late PaymentResponse _momoPaymentResult;
  var paymentStatus = "".obs;
  var quantity2 = 1.obs;
  var total = 2.5.obs;
  var finalTotal = 1.5.obs;
  var uuid = Uuid();
  static String payUrl = "";
  var playCode;
  var voucherCtl = "".obs;
  String partnerCode = 'MOMOXOUE20220626';
  String partnerName = 'City Discover Tourist';
  String accessKey = 'YQz23DOoGwYM0FC4';
  var isLoading = false.obs;

  var idRewardChoose = "".obs;
  var percentReward = 0.obs;
  var discountPrice = 1.5.obs;
  // var checkTotal=false.obs;
  @override
  void onInit() {
    // TODO: implement onInit
    isLoading(true);
    _momoPay = MomoVn();
    _momoPay.on(MomoVn.EVENT_PAYMENT_SUCCESS, _handlePaymentSuccess);
    _momoPay.on(MomoVn.EVENT_PAYMENT_ERROR, _handlePaymentError);
    paymentStatus.value = "";
    discountPrice.value = 0;
    // quantity2 = Get.find<QuestDetailController>().quantity;
    total.value = Get.find<QuestDetailController>().questDetail.price;
    finalTotal.value = total.value;
    playCode = uuid.v4();
    super.onInit();
  }

  @override
  void onReady() {
    isLoading(false);
   
  }

  @override
  void onClose() {
    _momoPay.clear();
    super.onClose();
  }

  @override
  void onDetached() {
    print('HomeController - onDetached called');
    paymentStatus.value = "";
  }

  // Mandatory
  @override
  void onInactive() {
    print('HomeController - onInative called');
  }

  // Mandatory
  @override
  void onPaused() {
    print('HomeController - onPaused called');
  }

  // Mandatory
  @override
  Future<void> onResumed() async {
    print('HomeController - onResumed called');
    await Future.delayed(Duration(seconds: 2));
    // var controller = Get.find<PlayController>();
    // PlayControllerV2 controller = new PlayControllerV2();
    // ignore: unrelated_type_equality_checks
    bool check = await checkPaymentStatus(playCode);
    if (check == true) {
      paymentStatus.value = "payment success".tr;
    } else {
      paymentStatus.value = "";
      playCode = uuid.v4();
    }
    CustomFullScreenDialog.cancelDialog();
  }

  // Optional
  @override
  Future<bool> didPushRoute(String route) {
    print('HomeController - the route $route will be open');
    return super.didPushRoute(route);
  }

  // Optional
  @override
  Future<bool> didPopRoute() {
    print('HomeController - the current route will be closed');
    return super.didPopRoute();
  }

  // Optional
  @override
  void didChangeMetrics() {
    print('HomeController - the window size did change');
    super.didChangeMetrics();
  }

  // Optional
  @override
  void didChangePlatformBrightness() {
    print('HomeController - platform change ThemeMode');
    super.didChangePlatformBrightness();
  }

  void decreaseQuantity() {
    if (quantity2.value != 1) {
      quantity2 = quantity2 - 1;
      // total.value = quantity2.toDouble() *
      //     Get.find<QuestDetailController>().questDetail.price;
      checkTotal();
    }
  }

  void increaseQuantity() {
    if (quantity2.value != 99) {
      quantity2 = quantity2 + 1;
      // total.value = quantity2.toDouble() *
      //     Get.find<QuestDetailController>().questDetail.price;
      checkTotal();
    }
  }

  void checkTotal() {
    total.value = quantity2.toDouble() *
        Get.find<QuestDetailController>().questDetail.price;
    if (percentReward.value != 0) {
      discountPrice.value = (total * percentReward.toDouble()) / 100;
      finalTotal.value = total.value - discountPrice.value;
    } else {
      finalTotal.value = total.value;
      discountPrice.value=0;
    }
  }

  void _handlePaymentSuccess(PaymentResponse response) {
    _momoPaymentResult = response;
    paymentStatus.value = 'Đã chuyển thanh toán';
    if (_momoPaymentResult.isSuccess == true) {
     
    } else {
     
    }
    Fluttertoast.showToast(
        msg: "THÀNH CÔNG: " + response.phoneNumber.toString(),
        toastLength: Toast.LENGTH_SHORT);
  }

  void _handlePaymentError(PaymentResponse response) {
    _momoPaymentResult = response;
    paymentStatus.value = 'Đã chuyển thanh toán';
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
    Fluttertoast.showToast(
        msg: "THẤT BẠI: " + response.message.toString(),
        toastLength: Toast.LENGTH_SHORT);
  }

  Future<List?> buyQuest(var id, String customerId, String questID,
      int quantity, var totalAmout, var discountCode) async {
    try {
      // isLoading(true);
      // Xài tạm dữ liệu cứng để trả về true
      // await PlayService()
      //     .buyQuest(customerId, questID, quantity, totalAmout, discountCode);
      return PlayService().buyQuest(
          id, customerId, questID, quantity, totalAmout, discountCode);
    } finally {
      // isLoading(false);
    }
  }

  Future<bool> checkPaymentStatus(var paymentId) async {
    return await PlayService().checkPaymentStatus(paymentId);
  }
}
