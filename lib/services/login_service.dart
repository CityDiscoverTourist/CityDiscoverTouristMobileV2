import 'dart:convert';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:travel_hour/controllers/home_controller.dart';
import 'package:travel_hour/controllers/login_controller_V2.dart';
import 'package:travel_hour/models/customer.dart';

import '../api/api.dart';
import '../api/api_end_points.dart';

class LoginService {
  final user = FirebaseAuth.instance.currentUser;

  Future<Customer> apiCheckLogin(String token, String deviceId) async {
    Customer rs;
    var myController = Get.find<LoginControllerV2>();
    Map data2 = {'tokenId': token};
    var body = json.encode(data2);
    var response = await http.post(Uri.parse(Api.baseUrl + ApiEndPoints.login),
        headers: {"Content-Type": "application/json"}, body: body);
    if (response.statusCode == 200) {
      // String email = firebaseUser.email!;

      final responseData = json.decode(response.body);
      myController.jwtToken.value = responseData['jwtToken'];
      print("JWT: "+responseData['jwtToken']);
      var response2 = await http.get(
        Uri.parse(
            Api.baseUrl + ApiEndPoints.customer + responseData['accountId']),
        headers: {
          "Content-Type": "application/json",
          'Authorization': 'Bearer ' + myController.jwtToken.value
        },
      );
      print(myController.jwtToken.toString());
      if (response2.statusCode == 200) {
        final responseData2 = json.decode(response2.body);
        rs = Customer.fromJson(responseData2['data']);
        var token = responseData['jwtToken'];
        // print(customer);
        return Future<Customer>.value(rs);
      } else
        return Future<Customer>.value(null);
    } else
      return Future<Customer>.value(null);
  }
}
