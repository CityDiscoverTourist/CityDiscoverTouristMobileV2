import 'dart:convert';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import '../models/quest_type.dart';

class QuestTypeService {
 
  static var client = http.Client();
  static Future<List<QuestType>?> fetchQuestTypeData() async {
    // WelcomeController homeController = Get.find<WelcomeController>();
    // var response = await http.get(
    //     Uri.parse('https://citytourist.azurewebsites.net/api/v1/quests'),
    //     headers: {
    //       "Accept": "application/json",
    //       "content-type": "application/json"
    //     });
    // print("API SCHEDULE Status_code: " '${response.statusCode}');
    // if (response.statusCode == 200) {
      // Map data = jsonDecode(response.body);
      // Iterable list = dbc;
      // Iterable list = data['data'];
      // Iterable list = json.decode(jsonString);
       Iterable list = [
    {
      "id": 1,
      "name": "Ẩm Thực",
      "status": "Ok",
      "durationMode": "100",
      "distanceMode": "200",
      "imagePath": 'https://focusasiatravel.vn/wp-content/uploads/2020/01/am-thuc-nepal.jpg'
    },
    {
      "id": 2,
      "name": "Phiêu Lưu",
      "status": "No",
      "durationMode": "200",
      "distanceMode": "120",
      "imagePath": 'https://dotchuoinon.files.wordpress.com/2019/12/phieuluu.jpg'
    },
    {
      "id": 3,
      "name": "Bức tốc",
      "status": "ffff",
      "durationMode": "string",
      "distanceMode": "string",
      "imagePath": 'https://images.unsplash.com/photo-1606787366850-de6330128bfc?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxleHBsb3JlLWZlZWR8OHx8fGVufDB8fHx8&w=1000&q=80'
    }
  ];
      final questTypeMap = list.cast<Map<String, dynamic>>();
      final listQuestType = await questTypeMap.map<QuestType>((json) {
        return QuestType.fromJson(json);
      }).toList();
      // print('object');
      return listQuestType;
    // }
  }
}
