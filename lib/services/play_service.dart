import 'package:travel_hour/models/questItem.dart';

class PlayService{

static Future<List<QuestItem>?> fetchTestData() async {
  Iterable list =[
    {
      "id": 1,
      "name": "Quest1",
      "ans":"A"
    },
    {
      "id": 2,
      "name": "Quest2",
      "ans":"A"
    },
    {
      "id": 3,
      "name": "Quest3",
      "ans":"A"
    }
];
    final qItemMap = list.cast<Map<String, dynamic>>();
      final questItemList = await qItemMap.map<QuestItem>((json) {
        return QuestItem.fromJson(json);
      }).toList();
      // print('object');
      return questItemList;
    // }
}

Future<QuestItem> fetchDataQuestItem(){
  QuestItem? questItem;
  return Future<QuestItem>.value(questItem);
}

 Future<bool> checkAnswer(){
  return Future<bool>.value(false);
 }

 Future<bool> checkLocation(){
  return Future<bool>.value(false);
 }

}