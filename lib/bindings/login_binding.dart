import 'package:get/get.dart';
import 'package:travel_hour/controllers/login_controller_V2.dart';
import 'package:travel_hour/controllers/login_controller.dart';


class LoginBinding implements Bindings {
  @override
  void dependencies() {
    Get.put(() => LoginController(), permanent: true);
    Get.put(() => LoginControllerV2(), permanent: true);
  }
}
