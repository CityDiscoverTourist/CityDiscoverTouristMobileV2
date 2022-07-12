import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:get/get_navigation/src/routes/transitions_type.dart';
import 'package:travel_hour/controllers/home_controller.dart';
import 'package:travel_hour/controllers/login_controller_V2.dart';
import 'package:travel_hour/routes/app_pages.dart';
import 'package:travel_hour/routes/app_routes.dart';
import 'package:travel_hour/utils/tranlations.dart';

import 'app.dart';
import 'bindings/home_binding.dart';
import 'bindings/login_binding.dart';
import 'controllers/login_controller.dart';

Future<void> main() async {
  // WidgetsFlutterBinding.ensureInitialized();
  // await Firebase.initializeApp();
  // SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
  //     statusBarColor: Colors.transparent,
  //     statusBarIconBrightness: Brightness.dark));
  // WidgetsFlutterBinding.ensureInitialized();
  // await EasyLocalization.ensureInitialized();
  // runApp(EasyLocalization(
  //   supportedLocales: [Locale('en'), Locale('es'), Locale('ar')],
  //   path: 'assets/translations',
  //   fallbackLocale: Locale('en'),
  //   startLocale: Locale('en'),
  //   useOnlyLangCode: true,
  //   child: MyApp(),
  // ));
  // LoginBinding().dependencies();
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  Get.put(LoginController(), permanent: true);
  Get.put(LoginControllerV2(), permanent: true);
  Get.put(HomeController(), permanent: true);
  // LoginController controller = new LoginController();
  // controller.checkUserLoggedIn();

  runApp(GetMaterialApp(
    translations: Translation(),
    locale: Locale('vn'),
    fallbackLocale: Locale('vn'),
    // It is not mandatory to use named routes, but dynamic urls are interesting.
    initialRoute: KSplashScreen,
    defaultTransition: Transition.native,
    //  translations: MyTranslations(),
    getPages: AppPages.getPages(),
    initialBinding: LoginBinding(),
    //Hello fen
    //HOWAREU
  ));
  // var controller = Get.find<LoginController>();
  // controller.checkUserLoggedIn();
}


// import 'dart:ffi';

// import 'package:flutter/material.dart';
// import 'package:travel_hour/models/payment.dart';
// import 'package:travel_hour/models/quest.dart';
// import 'package:travel_hour/pages/home.dart';
// import 'package:travel_hour/pages/sign_inV2.dart';
// import 'package:travel_hour/widgets/payment_widget.dart';
// // import 'package:travel_hour/widgets/test.dart';

// void main() => runApp(const MyApp());

// class MyApp extends StatelessWidget {
//   const MyApp({Key? key}) : super(key: key);

//   static const String _title = 'Flutter Code Sample';

//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       title: _title,
//       home: Scaffold(
//         appBar: AppBar(title: const Text(_title)),
//         body: MyStatelessWidget(),
//       ),
//     );
//   }
// }

// class MyStatelessWidget extends StatefulWidget {
//   const MyStatelessWidget({Key? key}) : super(key: key);

//   @override
//   State<MyStatelessWidget> createState() => _MyStatelessWidgetState();
// }

// class _MyStatelessWidgetState extends State<MyStatelessWidget> {
//   @override
//   Widget build(BuildContext context) {
//     int quantity = 2;
//     Quest quest = new Quest(
//         id: 9,
//         title: "Điệp vụ Opium",
//         description: "mo ta quest tieng viet",
//         price: 120000,
//         estimatedTime: "150",
//         estimatedDistance: "1.0",
//         createdDate: DateTime.parse("2022-05-03T14:26:57.88"),
//         status: "Inactive",
//         questTypeId: 1,
//         areaId: 3);
//     var totalAmout = (quantity * quest.price);
//     return Center(
//       child: ElevatedButton(
//         child: const Text('showModalBottomSheet'),
//         onPressed: () {
//           showModalBottomSheet<void>(
//             shape: RoundedRectangleBorder(
//                 borderRadius: BorderRadius.vertical(
//               top: Radius.circular(20),
//             )),
//             isScrollControlled: true,
//             context: context,
//             builder: (BuildContext context) {
//               return StatefulBuilder(
//                   builder: (BuildContext context, StateSetter mystate) {
//                 return Container(
//                   height: 500,
//                   padding: const EdgeInsets.fromLTRB(10.0, 70.0, 20.0, 20.0),
//                   child: Column(
//                     children: <Widget>[
//                       PaymentWidget(
//                         quest: quest,
//                         quantity: quantity,
//                         totalAmout: totalAmout,
//                       ),
//                       // Container(
//                       //   padding: EdgeInsets.all(3),
//                       //   decoration: BoxDecoration(
//                       //       borderRadius: BorderRadius.circular(5),
//                       //       color: Theme.of(context).accentColor),
//                       //   child: Row(
//                       //     children: [
//                       //       RaisedButton(
//                       //           onPressed: () async {
//                       //             mystate(() {
//                       //               quantity = quantity - 1;
//                       //             });
//                       //           },
//                       //           child: Icon(
//                       //             Icons.remove,
//                       //             color: Colors.white,
//                       //             size: 16,
//                       //           )),
//                       //       Container(
//                       //         margin: EdgeInsets.symmetric(horizontal: 3),
//                       //         padding: EdgeInsets.symmetric(
//                       //             horizontal: 3, vertical: 2),
//                       //         decoration: BoxDecoration(
//                       //             borderRadius: BorderRadius.circular(3),
//                       //             color: Colors.white),
//                       //         child: Text(
//                       //           quantity.toString(),
//                       //           style: TextStyle(
//                       //               color: Colors.black, fontSize: 16),
//                       //         ),
//                       //       ),
//                       //       RaisedButton(
//                       //           onPressed: () async {
//                       //             mystate(() {
//                       //               quantity = quantity + 1;
//                       //             });
//                       //           },
//                       //           child: Icon(
//                       //             Icons.add,
//                       //             color: Colors.white,
//                       //             size: 16,
//                       //           )),
//                       //     ],
//                       //   ),
//                       // ),
//                       // RaisedButton(
//                       //   child: const Text('Hủy'),
//                       //   onPressed: () => Navigator.pop(context),
//                       // ),
//                       // RaisedButton(
//                       //   child: const Text('Xác nhận thanh toán'),
//                       //   onPressed: () => Navigator.pop(context),
//                       // )
//                     ],
//                   ),
//                 );
//               });
//             },
//           );
//         },
//       ),
//     );
//   }
// }
