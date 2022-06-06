import 'dart:convert';

import 'package:get/get.dart';
import 'package:http/http.dart' as http;

import '../models/quest.dart';


class QuestService {
 
  static var client = http.Client();
  static Future<List<Quest>?> fetchQuestFeatureData() async {
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
      "id": 9,
      "title": "Quest 1",
      "description": "Quần đảo Phú Quốc nằm trong vịnh Thái Lan, cách TP HCM khoảng 400 km về hướng tây. Nơi đây thu hút du khách trong và ngoài nước bởi các loại hình du lịch đa dạng, với tài nguyên biển, đảo phong phú; hệ sinh thái rừng, biển đa dạng. Vùng biển Phú Quốc có 22 hòn đảo lớn, nhỏ, tổng diện tích khoảng 589,23 km2. Trong đó, đảo Phú Quốc lớn nhất thường được chia thành bắc đảo và nam đảo. Thị trấn Dương Đông nằm ở trung tâm. Hầu hết điểm tham quan, vui chơi hút khách nằm ở nam đảoQuần đảo Phú Quốc nằm trong vịnh Thái Lan, cách TP HCM khoảng 400 km về hướng tây. Nơi đây thu hút du khách trong và ngoài nước bởi các loại hình du lịch đa dạng, với tài nguyên biển, đảo phong phú; hệ sinh thái rừng, biển đa dạng. Vùng biển Phú Quốc có 22 hòn đảo lớn, nhỏ, tổng diện tích khoảng 589,23 km2. Trong đó, đảo Phú Quốc lớn nhất thường được chia thành bắc đảo và nam đảo. Thị trấn Dương Đông nằm ở trung tâm. Hầu hết điểm tham quan, vui chơi hút khách nằm ở nam đảoQuần đảo Phú Quốc nằm trong vịnh Thái Lan, cách TP HCM khoảng 400 km về hướng tây. Nơi đây thu hút du khách trong và ngoài nước bởi các loại hình du lịch đa dạng, với tài nguyên biển, đảo phong phú; hệ sinh thái rừng, biển đa dạng. Vùng biển Phú Quốc có 22 hòn đảo lớn, nhỏ, tổng diện tích khoảng 589,23 km2. Trong đó, đảo Phú Quốc lớn nhất thường được chia thành bắc đảo và nam đảo. Thị trấn Dương Đông nằm ở trung tâm. Hầu hết điểm tham quan, vui chơi hút khách nằm ở nam đảoQuần đảo Phú Quốc nằm trong vịnh Thái Lan, cách TP HCM khoảng 400 km về hướng tây. Nơi đây thu hút du khách trong và ngoài nước bởi các loại hình du lịch đa dạng, với tài nguyên biển, đảo phong phú; hệ sinh thái rừng, biển đa dạng. Vùng biển Phú Quốc có 22 hòn đảo lớn, nhỏ, tổng diện tích khoảng 589,23 km2. Trong đó, đảo Phú Quốc lớn nhất thường được chia thành bắc đảo và nam đảo. Thị trấn Dương Đông nằm ở trung tâm. Hầu hết điểm tham quan, vui chơi hút khách nằm ở nam đảoQuần đảo Phú Quốc nằm trong vịnh Thái Lan, cách TP HCM khoảng 400 km về hướng tây. Nơi đây thu hút du khách trong và ngoài nước bởi các loại hình du lịch đa dạng, với tài nguyên biển, đảo phong phú; hệ sinh thái rừng, biển đa dạng. Vùng biển Phú Quốc có 22 hòn đảo lớn, nhỏ, tổng diện tích khoảng 589,23 km2. Trong đó, đảo Phú Quốc lớn nhất thường được chia thành bắc đảo và nam đảo. Thị trấn Dương Đông nằm ở trung tâm. Hầu hết điểm tham quan, vui chơi hút khách nằm ở nam đảo",
      "price": 100.000,
      "imagePath": 'https://statics.vntrip.vn/data-v2/data-guide/img_content/1470302452_anh-5.jpg',
      "estimatedTime": "120",
      "estimatedDistance": "20",
      "availableTime": "2022-05-03T14:26:57.88",
      "createdDate": "2022-05-03T14:26:57.88",
      "updatedDate": "2022-05-03T14:26:57.88",
      "status": "ok",
      "questTypeId": 1,
      "questOwnerId": 2,
      "areaId": 3
    },
    {
      "id": 10,
      "title": "Quest 2",
      "description": "Đây là Description quest 2",
      "price": 110.000,
      "imagePath": 'https://statics.vntrip.vn/data-v2/data-guide/img_content/1470302452_anh-5.jpg',
      "estimatedTime": "100",
      "estimatedDistance": "2",
      "availableTime": "2022-05-03T13:29:19.9",
      "createdDate": "2022-05-03T13:29:19.9",
      "updatedDate": "2022-05-03T13:29:19.9",
      "status": "string",
      "questTypeId": 1,
      "questOwnerId": 2,
      "areaId": 3
    }
  ];
      final bookingsAccept = list.cast<Map<String, dynamic>>();
      final listOfBookings_Accept = await bookingsAccept.map<Quest>((json) {
        return Quest.fromJson(json);
      }).toList();
      // print('object');
      return listOfBookings_Accept;
    // }
  }
}
