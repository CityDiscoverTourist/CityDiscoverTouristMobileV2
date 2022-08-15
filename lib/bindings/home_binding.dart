import 'package:get/get.dart';

import '../controllers/home_controller.dart';
import '../controllers/login_controller.dart';

class HomeBinding implements Bindings {
  @override
  void dependencies() {
    // Get.put(() => LoginController(), permanent: true);
    Get.lazyPut(()=>HomeController());
  }
}
