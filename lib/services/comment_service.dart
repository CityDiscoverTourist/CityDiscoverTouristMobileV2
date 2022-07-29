import 'dart:convert';

import 'package:geolocator/geolocator.dart';
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

  static Future<bool> pushComment(String comment, int? customerQuestID,int rating) async {
    Map body = {
      "feedBack": comment,
      "rating": rating,
    };
    var response = await http.post(
        Uri.parse(
            "https://citytourist.azurewebsites.net/api/v1/customer-quests/feed-back/${customerQuestID}"),
        headers: {
          "Accept": "application/json",
          "content-type": "application/json"
        },
        body: jsonEncode(body));
    print('confirmTheFirstStart StatusCode: ' + response.statusCode.toString());
    if (response.statusCode == 200) {

      return Future<bool>.value(true);
    }
    return Future<bool>.value(false);
  }
}
