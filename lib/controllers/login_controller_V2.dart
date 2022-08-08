import 'dart:convert';
import 'dart:io';
import 'dart:ui';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:travel_hour/common/customFullScreenDialog.dart';
import 'package:travel_hour/controllers/home_controller.dart';
import 'package:travel_hour/models/customer.dart';
import 'package:travel_hour/pages/register.dart';
import 'package:travel_hour/pages/sign_inV2.dart';
import 'package:travel_hour/pages/splashV2.dart';

import '../api/api.dart';
import '../api/api_end_points.dart';
import '../pages/login_username_password.dart';
import '../routes/app_routes.dart';
import '../services/login_service.dart';

import 'package:http/http.dart' as http;

class LoginControllerV2 extends GetxController {
  var jwtToken = "".obs;
  late GoogleSignIn googleSign;
  var isSignIn = false.obs;
  FirebaseAuth firebaseAuth = FirebaseAuth.instance;
  String deviceId = ""; //*
  //  var homeController=Get.find<HomeController>();
  late Customer sp;
  var language = 0.obs;
  var loginByNamePass = false.obs;
  SharedPreferences? sharedPreferences;

  @override
  void onInit() async{
    super.onInit();
     final FirebaseMessaging _fcm = FirebaseMessaging.instance;
    _fcm
        .getToken()
        .then((token) => {print('The token||' + token!), deviceId = token});
    changeLanguage();
     bool checkRegis=Get.isRegistered<LoginControllerV2>(tag: "noty");
        if(checkRegis==true){
           ever(isSignIn, handleAuthStateChanged);
           sharedPreferences = await SharedPreferences.getInstance();
          print("hochi,");
           if (sharedPreferences!.containsKey("loginFace")) {
      isSignIn.value = true;
    } else if (sharedPreferences!.containsKey("loginAccount")) {
      isSignIn.value = true;
    } else {
      googleSign = GoogleSignIn();
      isSignIn.value = firebaseAuth.currentUser != null;
      firebaseAuth.authStateChanges().listen((event) {
        isSignIn.value = event != null;
      });
    }
         
        }
  }

  @override
  void onReady() async {
    super.onReady();
    changeLanguage();
      // var check=Get.isRegistered<LoginControllerV2>(tag: "noty");
    // if(check==true) print("Hoan HÔ");
    sharedPreferences = await SharedPreferences.getInstance();
    print("[Login V2]-L28-ONREADY :");
    ever(isSignIn, handleAuthStateChanged);
    if (sharedPreferences!.containsKey("loginFace")) {
      isSignIn.value = true;
    } else if (sharedPreferences!.containsKey("loginAccount")) {
      isSignIn.value = true;
    } else {
      googleSign = GoogleSignIn();
      isSignIn.value = firebaseAuth.currentUser != null;
      firebaseAuth.authStateChanges().listen((event) {
        isSignIn.value = event != null;
      });
    }
   
  }

  void handleAuthStateChanged(isLoggedIn) async {
    print("[LoginController V2]-L162-DeviceID:" + deviceId);
    if (isLoggedIn) {
      sharedPreferences = await SharedPreferences.getInstance();
      print("[LoginControllerV2]-L164: ");
      if (sharedPreferences!.containsKey("loginFace")) {
        String? token = sharedPreferences!.getString("resource");
        sp = await LoginService().checkFacebookLogin(token!);
      } else if (sharedPreferences!.containsKey("loginAccount")) {
        String? userName = sharedPreferences!.getString("userName");
        String? password = sharedPreferences!.getString("password");
        loginUsernamePassword(userName!, password!);
      } else {
        print("ahaha"+deviceId);
        sp = await LoginService().apiCheckLogin(
            await firebaseAuth.currentUser!.getIdToken(), deviceId);
      }

      if (sp != null) {
        //  Get.put(HomeController(),permanent: true);
        bool checkRegis=Get.isRegistered<LoginControllerV2>(tag: "noty");
        if(checkRegis==true){
          print("hochi,");
          // Get.push()
           Get.offAllNamed(KPlayingQuest);
        }else{
        Get.offAllNamed(KWelcomeScreen, arguments: firebaseAuth.currentUser);
             print("hochi3,");
        }
      } else {
        await googleSign.disconnect();
        await firebaseAuth.signOut();
      }
    } else {
      Get.offAllNamed(KLoginScreen);
    }
  }

  void login() async {
    CustomFullScreenDialog.showDialog();
    GoogleSignInAccount? googleSignInAccount = await googleSign.signIn();
    if (googleSignInAccount == null) {
      CustomFullScreenDialog.cancelDialog();
    } else {
      GoogleSignInAuthentication googleSignInAuthentication =
          await googleSignInAccount.authentication;
      OAuthCredential oAuthCredential = GoogleAuthProvider.credential(
          accessToken: googleSignInAuthentication.accessToken,
          idToken: googleSignInAuthentication.idToken);
      // print(googleSignInAuthentication.idToken);
      // print("Tesst");
      await firebaseAuth.signInWithCredential(oAuthCredential);
      CustomFullScreenDialog.cancelDialog();
    }
  }

  void logout() async {
    if (!sharedPreferences!.containsKey("loginAccount") ||
        sharedPreferences!.containsKey("loginFace")) {
      await GoogleSignIn().signOut();
      await firebaseAuth.signOut();
    }
    sharedPreferences = await SharedPreferences.getInstance();
    sharedPreferences?.clear();
    Get.offAll(LoginScreen());
  }

  void loginFacebook() async {
    firebaseAuth = FirebaseAuth.instance;
    final LoginResult facebookLoginResult = await FacebookAuth.instance
        .login(permissions: ['email', 'public_profile']);
    final accessToken = await FacebookAuth.instance.accessToken;

    final AuthCredential credential =
        FacebookAuthProvider.credential(accessToken!.token);
    // print(accessToken.token);
    Map data2 = {'resource': accessToken.token};
    var body = json.encode(data2);
    var response = await http.post(
        Uri.parse(Api.baseUrl +
            ApiEndPoints.loginFacebook +
            '?resource=' +
            accessToken.token),
        headers: {"Content-Type": "application/json"},
        body: body);
    // print(response.body);
    if (response.statusCode == 200) {
      final responseData = json.decode(response.body);
      var response2 = await http.get(
          Uri.parse(
              Api.baseUrl + ApiEndPoints.customer + responseData['accountId']),
          headers: {
            "Content-Type": "application/json",
            'Authorization': 'Bearer ' + responseData['jwtToken']
          });
      if (response2.statusCode == 200) {
        final responseData2 = json.decode(response2.body);
        sp = Customer.fromJson(responseData2['data']);
        jwtToken.value = responseData['jwtToken'];
        sharedPreferences = await SharedPreferences.getInstance();
        sharedPreferences?.setString('resource', accessToken.token);
        sharedPreferences?.setBool('loginFace', true);
        if (sharedPreferences!.containsKey("loginFace")) {}
        // print(sp);
        Get.offAllNamed(KWelcomeScreen, arguments: firebaseAuth.currentUser);
      }
    }
  }

  void loginUsernamePassword(String userName, String password) async {
    // if (!sharedPreferences!.containsKey("loginAccount")) {
    //   CustomFullScreenDialog.showDialog();
    // }

    Map data2 = {'email': userName, 'password': password};
    var body = json.encode(data2);
    var response = await http.post(
        Uri.parse(Api.baseUrl + ApiEndPoints.loginUsenamePassword),
        headers: {"Content-Type": "application/json"},
        body: body);
    // print(response.body);
    if (response.statusCode == 200) {
      final responseData = json.decode(response.body);
      var response2 = await http.get(
          Uri.parse(
              Api.baseUrl + ApiEndPoints.customer + responseData['accountId']),
          headers: {
            "Content-Type": "application/json",
            'Authorization': 'Bearer ' + responseData['jwtToken']
          });
      if (response2.statusCode == 200) {
        final responseData2 = json.decode(response2.body);
        sp = Customer.fromJson(responseData2['data']);
        jwtToken.value = responseData['jwtToken'];
        // print(sp);
        sharedPreferences = await SharedPreferences.getInstance();
        sharedPreferences?.setString('userName', userName);
        sharedPreferences?.setString('password', password);
        sharedPreferences?.setBool('loginAccount', true);
        // if (!sharedPreferences!.containsKey("loginAccount")) {
        //   CustomFullScreenDialog.cancelDialog();
        // }
        Get.offAllNamed(KWelcomeScreen, arguments: firebaseAuth.currentUser);
      }
    } else {
      final responseData = json.decode(response.body);
      // if (!sharedPreferences!.containsKey("loginAccount")) {
      //   CustomFullScreenDialog.cancelDialog();
      // }
      Get.snackbar(
          "error".tr, 'user not exist or wrong username and password'.tr,
          duration: Duration(seconds: 5),
          backgroundColor: Colors.black,
          colorText: Colors.white,
          snackPosition: SnackPosition.BOTTOM,
          icon: Icon(
            Icons.error,
            color: Colors.red,
          ));
    }
    // if (!sharedPreferences!.containsKey("loginAccount")) {
    //   CustomFullScreenDialog.cancelDialog();
    // }
  }

  void register(String userName, String password) async {
    // CustomFullScreenDialog.showDialog();
    Map data2 = {'email': userName, 'password': password};
    var body = json.encode(data2);
    var response = await http.post(
        Uri.parse(Api.baseUrl + ApiEndPoints.register),
        headers: {"Content-Type": "application/json"},
        body: body);
    // print(response.body);
    if (response.statusCode == 200) {
      // final responseData = json.decode(response.body);
      // print("Ok nè");
      // print(responseData);
      // CustomFullScreenDialog.cancelDialog();
      Get.snackbar("success".tr, 'please confim you email before login!'.tr,
          duration: Duration(seconds: 5),
          backgroundColor: Colors.black,
          colorText: Colors.white,
          snackPosition: SnackPosition.BOTTOM,
          icon: Icon(
            Icons.error,
            color: Colors.green,
          ));
      Get.to(UserLoginPage());
    } else {
      final responseData = json.decode(response.body);
      // print("Hellos");
      // print(responseData);
      // CustomFullScreenDialog.cancelDialog();
      if (responseData["message"] == "User already exists") {
        Get.snackbar("user already exists".tr, 'error register'.tr,
            duration: Duration(seconds: 5),
            backgroundColor: Colors.black,
            colorText: Colors.white,
            snackPosition: SnackPosition.BOTTOM,
            icon: Icon(
              Icons.error,
              color: Colors.red,
            ));
      }
    }
    // CustomFullScreenDialog.cancelDialog();
  }

  Future<bool> changePassword(String oldPassword, String newPassword) async {
    Map data2 = {
      'customerId': Get.find<LoginControllerV2>().sp.id,
      'oldPassword': oldPassword,
      'newPassword': newPassword
    };
    var body = json.encode(data2);
    var response =
        await http.put(Uri.parse(Api.baseUrl + ApiEndPoints.ChangePassword),
            headers: {
              'accept': 'text/plain',
              'Content-Type': 'application/json-patch+json',
              'Authorization':
                  'Bearer ' + Get.find<LoginControllerV2>().jwtToken.value
            },
            body: body);
    // print(data2);
    // print(response.statusCode);
    if (response.statusCode == 200) {
      final responseData = json.decode(response.body);
      Get.snackbar("success".tr, 'success change password'.tr,
          duration: Duration(seconds: 5),
          backgroundColor: Colors.black,
          colorText: Colors.white,
          snackPosition: SnackPosition.BOTTOM,
          icon: Icon(
            Icons.error,
            color: Colors.green,
          ));
      return true;
    } else if (response.statusCode == 400) {
      final responseData = json.decode(response.body);
      // if (responseData["message"] == "User already exists") {
      Get.snackbar("error".tr, 'error change password'.tr,
          duration: Duration(seconds: 5),
          backgroundColor: Colors.black,
          colorText: Colors.white,
          snackPosition: SnackPosition.BOTTOM,
          icon: Icon(
            Icons.error,
            color: Colors.red,
          ));
      return false;
    }
    return false;
  }

  void forgotPassword(String userName) async {
    var response = await http.post(
      Uri.parse(
          Api.baseUrl + ApiEndPoints.forgotPassword + "?email=" + userName),
      headers: {"Content-Type": "application/json"},
    );
    if (response.statusCode == 200) {
      Get.snackbar("success".tr, 'check you email to get new password'.tr,
          duration: Duration(seconds: 5),
          backgroundColor: Colors.black,
          colorText: Colors.white,
          snackPosition: SnackPosition.BOTTOM,
          icon: Icon(
            Icons.error,
            color: Colors.green,
          ));
      Get.to(UserLoginPage());
    }
  }

  Future<bool> editProfile(String address, bool? gender, File? image) async {
    var request = new http.MultipartRequest("PUT",
        Uri.parse("https://citytourist.azurewebsites.net/api/v1/customers"));
    if (image != null) {
      var file = File(image.path);
      request.files.add(await http.MultipartFile.fromPath("image", file.path));
    }
    request.fields["Id"] = Get.find<LoginControllerV2>().sp.id;
    request.fields["Address"] = address;
    request.fields["Gender"] = gender.toString();
    request.headers["accept"] = "text/plain";
    request.headers["Content-Type"] = "multipart/form-data";
    print("Request:" + request.toString());
    var response = await request.send();
    print("Status code:" + response.statusCode.toString());
    if (response.statusCode == 200) {
      response.stream.transform(utf8.decoder).listen((value) {
        // print(value);
        Map<String, dynamic> result = jsonDecode(value);
        // print(result["data"]);
        Get.find<LoginControllerV2>().sp = Customer.fromJson(result["data"]);
      });
      return true;
    }
    return false;
  }

  void changeLanguage() async {
    Locale? locale = Get.locale;
    print(locale);
    if (locale.toString() == "en") {
      language.value = 0;
      print(language);
      // update();
    } else {
      language.value = 1;
      print(language);
      // update();
    }
  }
}
