import 'dart:convert';

import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:travel_hour/controllers/login_controller_V2.dart';
import 'package:travel_hour/models/comment.dart';
import 'package:travel_hour/models/questItem.dart';
import 'package:http/http.dart' as http;

import '../api/api.dart';
import '../api/api_end_points.dart';

class CommentService {
  static Future<List<Comment>?> fetchCommentsData(
      int lastVisible, String jwtToken, String idCustomer, int idQuest) async {
    print('fetchCommentsData: ' + jwtToken);
    print('fetchCommentsData: ID CUSTOMER-' +
        idCustomer +
        "////" +
        idQuest.toString());
    print("id Quest" + idQuest.toString());
    var response = await http.get(
        Uri.parse(
            'https://citytourist.azurewebsites.net/api/v1/customer-quests/show-comments/${idQuest}'),
        headers: {
          "Accept": "application/json",
          "content-type": "application/json",
          'Authorization': 'Bearer ' + jwtToken
        });
    print("fetchCommentsData Status_code: " '${response.statusCode}');
    Map data = jsonDecode(response.body);
    // Iterable list = dbc;
    Iterable list = data['data'];
    print("fetchCommentsData " + idQuest.toString());
    final commentMap = list.cast<Map<String, dynamic>>();
    final dataComment = await commentMap.map<Comment>((json) {
      return Comment.fromJson(json);
    }).toList();
    return dataComment;
  }

  static Future<Comment>? fetchCommentByCustomerId(
      String jwtToken, String idCustomer, int idQuest) async {
    Comment rs;
    print("id Quest" + idQuest.toString());
    var response = await http.get(
        Uri.parse(
            'https://citytourist.azurewebsites.net/api/v1/customer-quests/get-comment?questId=${idQuest}&customerId=${idCustomer}'),
        headers: {
          "Accept": "application/json",
          "content-type": "application/json",
          'Authorization': 'Bearer ' + jwtToken
        });
    print("fetchCommentByCustomerId Status_code: " '${response.statusCode}');
    if (response.statusCode == 200) {
      Map data = jsonDecode(response.body);
    // Iterable list = dbc;
    Iterable list = data['data'];
    print("fetchCommentByCustomerId " + idQuest.toString());
    final commentMap = list.cast<Map<String, dynamic>>();
    final dataComment = await commentMap.map<Comment>((json) {
      return Comment.fromJson(json);
    }).toList();
    rs=dataComment[0];
      return Future<Comment>.value(rs);
    }
    return Future<Comment>.value(null);
  }

  static Future<bool> pushComment(
      String comment, int? questID, int rating,String customerId) async {
    Map body = {
      "feedBack": comment,
      "rating": rating,
    };
    var response = await http.post(
        Uri.parse(
            "https://citytourist.azurewebsites.net/api/v1/customer-quests/update-comment?questId=${questID}&customerId=${customerId}"),
        headers: {
          "Accept": "application/json",
          "content-type": "application/json",
          'Authorization':
              'Bearer ' + Get.find<LoginControllerV2>().jwtToken.value
        },
        body: jsonEncode(body));
    print('confirmTheFirstStart StatusCode: ' + response.statusCode.toString());
    if (response.statusCode == 200) {
      return Future<bool>.value(true);
    }
    return Future<bool>.value(false);
  }
}
