// // import 'package:citydiscovertourist/models/customer.dart';
// // import 'package:citydiscovertourist/screen/welcome/welcome_Screen.dart';
// // import 'package:citydiscovertourist/screen/profile/profile.dart';
// // import 'package:dio/dio.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:firebase_core/firebase_core.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
// import 'package:get/get.dart';
// import 'package:google_sign_in/google_sign_in.dart';
// import 'package:http/http.dart' as http;
// import 'package:shared_preferences/shared_preferences.dart';
// import 'package:travel_hour/controllers/home_controller.dart';
// import 'package:travel_hour/pages/home.dart';
// import 'dart:convert';
// // import 'package:citydiscovertourist/api/api.dart';
// // import 'package:citydiscovertourist/api/api_end_points.dart';

// import '../api/api.dart';
// import '../api/api_end_points.dart';
// import '../models/customer.dart';
// import '../pages/profile.dart';
// import '../pages/sign_in.dart';
// // import '../screen/login/login_screen.dart';

// // import 'package:shared_preferences/shared_preferences.dart';

// class LoginController extends GetxController {
//   // Intilize the flutter app
//   SharedPreferences? sp;
//   late FirebaseApp firebaseApp;
//   late User firebaseUser;
//   late FirebaseAuth firebaseAuth;
//   bool? _isSignedIn = false;
//   bool? get isSignedIn => _isSignedIn;

//   //CUONGNHT EDIT CODE
//   //ADD VARIABLE Customer for change

//   String? _userName;
//   String? get userName => _userName;

//   String? _uid;
//   String? get uid => _uid;

//   String? _email;
//   String? get email => _email;

//   String? _imagePath;
//   String? get imagePath => _imagePath;

//   String? _phoneNumber;
//   String? get phoneNumber => _phoneNumber;

//   String? _jwtToken;
//   String? get jwtToken => _jwtToken;

//   Future<void> initlizeFirebaseApp() async {
//     firebaseApp = await Firebase.initializeApp();
//   }

//   Future<void> checkUserLoggedIn() async {
//     print("Ok");
//     if (firebaseApp == null) {
//       await initlizeFirebaseApp();
//     }
//     if (firebaseAuth == null) {
//       firebaseAuth = FirebaseAuth.instance;
//       update();
//     }
//     if (firebaseAuth.currentUser == null) {
//       Get.toNamed("/LOGIN_SCREEN");
//     } else {
//       firebaseUser = firebaseAuth.currentUser!;
//       update();
//       Get.toNamed("/WELCOME_SCREEN");
//     }
//   }

//   void onInit() async {
//     super.onInit();
//     // await checkUserLoggedIn();
//   }

//   Future<void> login() async {
//     try {
//       await initlizeFirebaseApp();

//       firebaseAuth = FirebaseAuth.instance;

//       final googleUser = await GoogleSignIn().signIn();

//       final googleAuth = await googleUser!.authentication;

//       final credential = GoogleAuthProvider.credential(
//         accessToken: googleAuth.accessToken,
//         idToken: googleAuth.idToken,
//       );

//       final userCredentialData =
//           await FirebaseAuth.instance.signInWithCredential(credential);
//       firebaseUser = userCredentialData.user!;
//       var idToken = await firebaseUser.getIdToken();
//       Map data2 = {'tokenId': idToken};
//       var body = json.encode(data2);
//       var response = await http.post(
//           Uri.parse(Api.baseUrl + ApiEndPoints.login),
//           headers: {"Content-Type": "application/json"},
//           body: body);
//       if (response.statusCode == 200) {
//         String email = firebaseUser.email!;
//         final responseData = json.decode(response.body);
//         var response2 = await http.get(
//             Uri.parse(Api.baseUrl +
//                 ApiEndPoints.customer +
//                 responseData['accountId']),
//             headers: {"Content-Type": "application/json"});
//         if (response2.statusCode == 200) {
//           final responseData2 = json.decode(response2.body);
//           Customer customer = Customer.fromJson(responseData2['data']);
//           var token = responseData['jwtToken'];
//           print(customer);
//           _isSignedIn = true;
//           update();
//           Get.back();
//           saveDataToSP(customer, token, _isSignedIn!);
//           Get.put(
//             LoginController(),
//             permanent: true,
//           );
//           Get.put(HomeController()).indexHomePage.value = 0;
//           Get.to(HomePage());
//         }
//       }
//     } catch (ex) {
//       Get.back();
//       Get.snackbar('Sign In Error', 'Error Signing in',
//           duration: Duration(seconds: 5),
//           backgroundColor: Colors.black,
//           colorText: Colors.white,
//           snackPosition: SnackPosition.BOTTOM,
//           icon: Icon(
//             Icons.error,
//             color: Colors.red,
//           ));
//     }
//   }

//   Future<void> loginFacebook() async {
//     try {
//       await initlizeFirebaseApp();

//       firebaseAuth = FirebaseAuth.instance;
//       final LoginResult facebookLoginResult = await FacebookAuth.instance
//           .login(permissions: ['email', 'public_profile']);
//       final accessToken = await FacebookAuth.instance.accessToken;

//       final AuthCredential credential =
//           FacebookAuthProvider.credential(accessToken!.token);
//       print(accessToken.token);
//       Map data2 = {'resource': accessToken.token};
//       var body = json.encode(data2);
//       var response = await http.post(
//           Uri.parse(Api.baseUrl +
//               ApiEndPoints.loginFacebook +
//               '?resource=' +
//               accessToken.token),
//           headers: {"Content-Type": "application/json"},
//           body: body);

//       print(response.body);
//       if (response.statusCode == 200) {
//         final responseData = json.decode(response.body);
//         var response2 = await http.get(
//             Uri.parse(Api.baseUrl +
//                 ApiEndPoints.customer +
//                 responseData['accountId']),
//             headers: {"Content-Type": "application/json"});
//         if (response2.statusCode == 200) {
//           final responseData2 = json.decode(response2.body);
//           Customer customer = Customer.fromJson(responseData2['data']);
//           var token = responseData['jwtToken'];
//           print(customer);
//           _isSignedIn = true;
//           update();
//           Get.back();
//           saveDataToSP(customer, token, _isSignedIn!);
//           // Get.put(
//           //   LoginController(),
//           //   permanent: true,
//           // );
//           Get.put(HomeController()).indexHomePage.value = 0;
//           Get.to(HomePage());
//         }
//       }
//     } catch (ex) {
//       Get.back();
//       print(ex.toString());
//       Get.snackbar(ex.toString(), 'Error Signing in',
//           duration: Duration(seconds: 5),
//           backgroundColor: Colors.black,
//           colorText: Colors.white,
//           snackPosition: SnackPosition.BOTTOM,
//           icon: Icon(
//             Icons.error,
//             color: Colors.red,
//           ));
//     }
//   }

//   Future saveDataToSP(
//       Customer customer, String jwtToken, bool isSignedIn) async {
//     sp = await SharedPreferences.getInstance();

//     await sp?.setString('uid', customer.id);
//     await sp?.setString('userName', customer.userName);
//     await sp?.setString('email', customer.email);
//     await sp?.setString('phoneNumber', customer.phoneNumber);
//     await sp?.setString('imagePath', customer.imagePath);
//     await sp?.setString('jwtToken', jwtToken);
//     await sp?.setBool('isSignedIn', isSignedIn);
//   }

//   Future getDataFromSp() async {
//     sp = await SharedPreferences.getInstance();
//     _userName = sp?.getString('userName');
//     _phoneNumber = sp?.getString('phoneNumber');
//     _email = sp?.getString('email');
//     _imagePath = sp?.getString('imagePath');
//     _uid = sp?.getString('uid');
//     _jwtToken = sp?.getString('jwtToken');
//     _isSignedIn = sp?.getBool('isSignedIn');
//   }

//   Future<void> logout() async {
//     final prefs = await SharedPreferences.getInstance();
//     prefs.clear();
//     await GoogleSignIn().signOut();
//     await FirebaseAuth.instance.signOut();
//     Get.offAll(SignInPage());
//   }
// }
