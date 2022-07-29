// To parse this JSON data, do
//
//     final quest = questFromJson(jsonString);

import 'dart:convert';

List<Quest> questFromJson(String str) =>
    List<Quest>.from(json.decode(str).map((x) => Quest.fromJson(x)));

String questToJson(List<Quest> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Quest {
  Quest({
    required this.id,
    required this.title,
    required this.description,
    required this.price,
    required this.imagePath,
    required this.estimatedTime,
    required this.estimatedDistance,
    required this.availableTime,
    // required this.createdDate,
    required this.status,
    required this.questTypeId,
    required this.questOwnerId,
    required this.areaId,
    required this.countQuestItem,
    required this.totalFeedback,
    required this.averageStar,
  });

  int id;
  String title;
  String description;
  double price;
  dynamic imagePath;
  String estimatedTime;
  String estimatedDistance;
  String? availableTime;
  // DateTime createdDate;
  String? status;
  int questTypeId;
  int? questOwnerId;
  int areaId;
  int countQuestItem;
  int totalFeedback;
  int? averageStar;

  factory Quest.fromJson(Map<String, dynamic> json) => Quest(
        id: json["id"],
        title: json["title"],
        description: json["description"],
        price: json["price"],
        imagePath: json["imagePath"],
        estimatedTime: json["estimatedTime"],
        estimatedDistance: json["estimatedDistance"],
        availableTime: json["availableTime"],
        // createdDate: DateTime.parse(json["createdDate"].toString()),
        status: json["status"],
        questTypeId: json["questTypeId"],
        questOwnerId: json["questOwnerId"],
        areaId: json["areaId"],
        countQuestItem: json["countQuestItem"],
        totalFeedback: json["totalFeedback"],
        averageStar: json["averageStar"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "title": title,
        "description": description,
        "price": price,
        "imagePath": imagePath,
        "estimatedTime": estimatedTime,
        "estimatedDistance": estimatedDistance,
        "availableTime": availableTime,
        // "createdDate": createdDate!.toString(),
        "status": status,
        "questTypeId": questTypeId,
        "questOwnerId": questOwnerId,
        "areaId": areaId,
        "countQuestItem": countQuestItem,
        "totalFeedback": totalFeedback,
        "averageStar": averageStar,
      };
}
