import 'dart:convert';
import 'dart:io';
import 'dart:ui';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';

import 'package:travel_hour/common/customFullScreenDialog.dart';
import 'package:travel_hour/controllers/home_controller.dart';
import 'package:travel_hour/models/customer.dart';
import 'package:travel_hour/pages/register.dart';
import 'package:travel_hour/pages/sign_inV2.dart';

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

  @override
  void onInit() {
    super.onInit();
    changeLanguage();
  }

  @override
  void onReady() async {
    super.onReady();
    changeLanguage();
    print("[Login V2]-L28-ONREADY :");
    googleSign = GoogleSignIn();
    ever(isSignIn, handleAuthStateChanged);
    isSignIn.value = firebaseAuth.currentUser != null;
    firebaseAuth.authStateChanges().listen((event) {
      isSignIn.value = event != null;
    });
  }

  void handleAuthStateChanged(isLoggedIn) async {
    print("[LoginController V2]-L162-DeviceID:" + deviceId);
    if (isLoggedIn) {
      print("[LoginControllerV2]-L164: ");
      sp = await LoginService().apiCheckLogin(
          await firebaseAuth.currentUser!.getIdToken(), deviceId);
      if (sp != null) {
        //  Get.put(HomeController(),permanent: true);
        Get.offAllNamed(KWelcomeScreen, arguments: firebaseAuth.currentUser);
      } else if (loginByNamePass == true) {
        Get.offAllNamed(KWelcomeScreen, arguments: firebaseAuth.currentUser);
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
    if (loginByNamePass.value == false) {
      await GoogleSignIn().signOut();
      await firebaseAuth.signOut();
    }
    Get.offAll(LoginScreen());
  }

  void loginFacebook() async {
    firebaseAuth = FirebaseAuth.instance;
    final LoginResult facebookLoginResult = await FacebookAuth.instance
        .login(permissions: ['email', 'public_profile']);
    final accessToken = await FacebookAuth.instance.accessToken;

    final AuthCredential credential =
        FacebookAuthProvider.credential(accessToken!.token);
    print(accessToken.token);
    Map data2 = {'resource': accessToken.token};
    var body = json.encode(data2);
    var response = await http.post(
        Uri.parse(Api.baseUrl +
            ApiEndPoints.loginFacebook +
            '?resource=' +
            accessToken.token),
        headers: {"Content-Type": "application/json"},
        body: body);
    print(response.body);
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
        Get.offAllNamed(KWelcomeScreen, arguments: firebaseAuth.currentUser);
      }
    }
  }

  void loginUsernamePassword(String userName, String password) async {
    Map data2 = {'email': userName, 'password': password};
    var body = json.encode(data2);
    var response = await http.post(
        Uri.parse(Api.baseUrl + ApiEndPoints.loginUsenamePassword),
        headers: {"Content-Type": "application/json"},
        body: body);
    print(response.body);
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
        Get.offAllNamed(KWelcomeScreen, arguments: firebaseAuth.currentUser);
      } else {
        Get.snackbar(responseData["message"], 'Error Login',
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
  }

  void register(String userName, String password) async {
    Map data2 = {'email': userName, 'password': password};
    var body = json.encode(data2);
    var response = await http.post(
        Uri.parse(Api.baseUrl + ApiEndPoints.register),
        headers: {"Content-Type": "application/json"},
        body: body);
    print(response.body);
    if (response.statusCode == 200) {
      final responseData = json.decode(response.body);
      Get.snackbar(responseData["message"], 'Success register',
          duration: Duration(seconds: 5),
          backgroundColor: Colors.black,
          colorText: Colors.white,
          snackPosition: SnackPosition.BOTTOM,
          icon: Icon(
            Icons.error,
            color: Colors.green,
          ));
      Get.to(UserLoginPage());
    } else if (response.statusCode == 400) {
      final responseData = json.decode(response.body);
      if (responseData["message"] == "User already exists") {
        Get.snackbar(responseData["message"], 'Error register',
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
    print(data2);
    print(response.statusCode);
    if (response.statusCode == 200) {
      final responseData = json.decode(response.body);
      Get.snackbar(responseData["message"], 'Success change password',
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
      Get.snackbar(responseData["message"], 'Error change password',
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
      Get.snackbar("Success", 'Check you email to get new password',
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
