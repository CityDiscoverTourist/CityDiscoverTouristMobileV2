// To parse this JSON data, do
//
//     final quest = questFromJson(jsonString);

import 'dart:convert';
import 'dart:ffi';

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
    this.imagePath,
    required this.estimatedTime,
    required this.estimatedDistance,
    // required this.availableTime,
    required this.createdDate,
    // required this.updatedDate,
    required this.status,
    required this.questTypeId,
    // required this.questOwnerId,
    required this.areaId,
  });

  int id;
  String title;
  String description;
  num price;
  dynamic imagePath;
  String estimatedTime;
  String estimatedDistance;
  // DateTime availableTime;
  DateTime? createdDate;
  // DateTime updatedDate;
  String status;
  int questTypeId;
  // int questOwnerId;
  int areaId;

  factory Quest.fromJson(Map<String, dynamic> json) => Quest(
        id: json["id"],
        title: json["title"],
        description: json["description"],
        price: json["price"],
        imagePath: json["imagePath"],
        estimatedTime: json["estimatedTime"],
        estimatedDistance: json["estimatedDistance"],
        // availableTime: DateTime.parse(json["availableTime"]),
        createdDate: DateTime.parse(json["createdDate"].toString()),
        // updatedDate: DateTime.parse(json["updatedDate"]),
        status: json["status"],
        questTypeId: json["questTypeId"],
        // questOwnerId: json["questOwnerId"],
        areaId: json["areaId"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "title": title,
        "description": description,
        "price": price,
        "imagePath": imagePath,
        "estimatedTime": estimatedTime,
        "estimatedDistance": estimatedDistance,
        // "availableTime": availableTime.toIso8601String(),
        "createdDate": createdDate!.toString(),
        // "updatedDate": updatedDate.toIso8601String(),
        "status": status,
        "questTypeId": questTypeId,
        // "questOwnerId": questOwnerId,
        "areaId": areaId,
      };
}
