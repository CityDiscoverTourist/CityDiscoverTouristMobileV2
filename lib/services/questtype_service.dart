import 'dart:convert';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import '../models/quest_type.dart';

class QuestTypeService {
 
  static var client = http.Client();
  static Future<List<QuestType>?> fetchQuestTypeData() async {
    // WelcomeController homeController = Get.find<WelcomeController>();
    var response = await http.get(
        Uri.parse('https://citytourist.azurewebsites.net/api/v1/quest-types'),
        headers: {
          "Accept": "application/json",
          "content-type": "application/json"
        });
    // print("API SCHEDULE Status_code: " '${response.statusCode}');
    // if (response.statusCode == 200) {
      Map data = jsonDecode(response.body);
      // Iterable list = dbc;
      Iterable list = data['data'];
      // Iterable list = json.decode(jsonString);

      final questTypeMap = list.cast<Map<String, dynamic>>();
      final listQuestType = await questTypeMap.map<QuestType>((json) {
        return QuestType.fromJson(json);
      }).toList();
      // print('object');
      return listQuestType;
    // }
  }
}
