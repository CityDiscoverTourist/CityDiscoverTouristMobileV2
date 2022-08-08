import 'dart:convert';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:travel_hour/controllers/home_controller.dart';
import 'package:travel_hour/controllers/login_controller_V2.dart';
import 'package:travel_hour/models/customer.dart';

import '../api/api.dart';
import '../api/api_end_points.dart';
import '../common/customFullScreenDialog.dart';

class LoginService {
  final user = FirebaseAuth.instance.currentUser;

  Future<Customer> apiCheckLogin(String token, String deviceId) async {
    Customer rs;
    var myController = Get.find<LoginControllerV2>();
    Map data2 = {'tokenId': token, "deviceId": deviceId};
    var body = json.encode(data2);
    var response = await http.post(Uri.parse(Api.baseUrl + ApiEndPoints.login),
        headers: {"Content-Type": "application/json"}, body: body);
    print(response.body);
    if (response.statusCode == 200) {
      // String email = firebaseUser.email!;
      final responseData = json.decode(response.body);
      myController.jwtToken.value = responseData['jwtToken'];
      print("HOME CONTROLLER: " + myController.jwtToken.value.toString());
      // print("JWT: "+responseData['jwtToken']);
      var response2 = await http.get(
        Uri.parse(
            Api.baseUrl + ApiEndPoints.customer + responseData['accountId']),
        headers: {
          "Content-Type": "application/json",
          'Authorization': 'Bearer ' + myController.jwtToken.value
        },
      );
      if (response2.statusCode == 200) {
        final responseData2 = json.decode(response2.body);
        rs = Customer.fromJson(responseData2['data']);
        var token = responseData['jwtToken'];
        // print(customer);
        return Future<Customer>.value(rs);
      } else
        return Future<Customer>.value(null);
    } else {
      final responseData = json.decode(response.body);
      Get.find<LoginControllerV2>().logout();
      if (responseData['message'] == "Account not allowed to login") {
        Get.snackbar("error".tr, 'account not allowed to login'.tr,
            duration: Duration(seconds: 5),
            backgroundColor: Colors.black,
            colorText: Colors.white,
            snackPosition: SnackPosition.BOTTOM,
            icon: Icon(
              Icons.error,
              color: Colors.red,
            ));
        return Future<Customer>.value(null);
      }
    }
    return Future<Customer>.value(null);
  }

  Future<Customer> checkFacebookLogin(
      String accessToken, String deviceId) async {
    Customer rs;
    var myController = Get.find<LoginControllerV2>();
    Map data2 = {'resource': accessToken};
    var body = json.encode(data2);
    var response = await http.post(
        Uri.parse(Api.baseUrl +
            ApiEndPoints.loginFacebook +
            '?resource=' +
            accessToken +
            "&deviceId=" +
            deviceId),
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
        rs = Customer.fromJson(responseData2['data']);
        myController.jwtToken.value = responseData['jwtToken'];
        // print(sp);
        // Get.offAllNamed(KWelcomeScreen, arguments: firebaseAuth.currentUser);
        return Future<Customer>.value(rs);
      }
    } else {
      final responseData = json.decode(response.body);
      Get.find<LoginControllerV2>().logout();
      // await Get.find<LoginControllerV2>().googleSign.disconnect();
      // await Get.find<LoginControllerV2>().firebaseAuth.signOut();
      if (responseData['message'] == "Account not allowed to login") {
        Get.snackbar("error".tr, 'account not allowed to login'.tr,
            duration: Duration(seconds: 5),
            backgroundColor: Colors.black,
            colorText: Colors.white,
            snackPosition: SnackPosition.BOTTOM,
            icon: Icon(
              Icons.error,
              color: Colors.red,
            ));
        return Future<Customer>.value(null);
      }
    }
    return Future<Customer>.value(null);
  }
}
