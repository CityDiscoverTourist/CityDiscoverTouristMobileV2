// To parse this JSON data, do
//
//     final quest = questFromJson(jsonString);

import 'dart:convert';

import 'package:travel_hour/models/questItem.dart';

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
    required this.createdDate,
    // this.updatedDate,
    required this.status,
    required this.questTypeId,
    required this.questOwnerId,
    required this.areaId,
    required this.countQuestItem,
    required this.address,
    required this.latLong,
    required this.totalFeedback,
    required this.averageStar,
    // required this.questItems,
    required this.areaName,
  });

  int id;
  String title;
  String description;
  double price;
  String? imagePath;
  String estimatedTime;
  String estimatedDistance;
  String availableTime;
  DateTime createdDate;
  // DateTime? updatedDate;
  String? status;
  int questTypeId;
  int? questOwnerId;
  int areaId;
  int countQuestItem;
  String? address;
  String? latLong;
  int totalFeedback;
  int averageStar;
  String? areaName;
  // List<QuestItem> questItems;

  factory Quest.fromJson(Map<String, dynamic> json) => Quest(
        id: json["id"],
        title: json["title"],
        description: json["description"],
        price: json["price"],
        imagePath: json["imagePath"] == null ? null : json["imagePath"],
        estimatedTime: json["estimatedTime"],
        estimatedDistance: json["estimatedDistance"],
        availableTime: json["availableTime"],
        createdDate: DateTime.parse(json["createdDate"]),
        // updatedDate: DateTime.parse(json["updatedDate"]),
        status: json["status"],
        questTypeId: json["questTypeId"],
        questOwnerId:
            json["questOwnerId"] == null ? null : json["questOwnerId"],
        areaId: json["areaId"],
        countQuestItem: json["countQuestItem"],
        address: json["address"] == null ? null : json["address"],
        latLong: json["latLong"] == null ? null : json["latLong"],
        totalFeedback: json["totalFeedback"],
        averageStar: json["averageStar"],
        areaName: json["areaName"],
        // questItems: List<QuestItem>.from(
        //     json["questItems"].map((x) => QuestItem.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "title": title,
        "description": description,
        "price": price,
        "imagePath": imagePath == null ? null : imagePath,
        "estimatedTime": estimatedTime,
        "estimatedDistance": estimatedDistance,
        "availableTime": availableTime,
        "createdDate": createdDate,
        // "updatedDate": updatedDate,
        "status": status,
        "questTypeId": questTypeId,
        "questOwnerId": questOwnerId == null ? null : questOwnerId,
        "areaId": areaId,
        "countQuestItem": countQuestItem,
        "address": address == null ? null : address,
        "latLong": latLong == null ? null : latLong,
        "totalFeedback": totalFeedback,
        "averageStar": averageStar,
        "areaName": areaName,
        // "questItems": List<dynamic>.from(questItems.map((x) => x.toJson())),
      };
}
