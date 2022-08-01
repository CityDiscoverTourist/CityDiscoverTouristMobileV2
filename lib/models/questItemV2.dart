// To parse this JSON data, do
//
//     final questItem2 = questItem2FromJson(jsonString);

import 'dart:convert';

List<QuestItem2> questItem2FromJson(String str) =>
    List<QuestItem2>.from(json.decode(str).map((x) => QuestItem2.fromJson(x)));

String questItem2ToJson(List<QuestItem2> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class QuestItem2 {
  QuestItem2({
    required this.id,
    required this.questItemTypeId,
    required this.locationId,
    required this.questId,
    required this.content,
    required this.description,
    required this.duration,
    required this.updatedDate,
    required this.qrCode,
    required this.rightAnswer,
    required this.status,
    required this.itemId,
    required this.createdDate,
    required this.answerImageUrl,
  });

  int id;
  int questItemTypeId;
  int locationId;
  int questId;
  String content;
  String description;
  int duration;
  DateTime? updatedDate;
  String? qrCode;
  String rightAnswer;
  String status;
  int itemId;
  DateTime? createdDate;
  String? answerImageUrl;
  // String story;

  factory QuestItem2.fromJson(Map<String, dynamic> json) => QuestItem2(
        id: json["id"],
        questItemTypeId: json["questItemTypeId"],
        locationId: json["locationId"],
        questId: json["questId"],
        content: json["content"],
        description: json["description"],
        duration: json["duration"],
        updatedDate: json["updatedDate"] == null
            ? null
            : DateTime.parse(json["updatedDate"]),
        qrCode: json["qrCode"] == null ? null : json["qrCode"],
        rightAnswer: json["rightAnswer"],
        status: json["status"],
        itemId: json["itemId"],
        createdDate: json["createdDate"] == null
            ? null
            : DateTime.parse(json["createdDate"]),
        answerImageUrl:
            json["answerImageUrl"] == null ? null : json["answerImageUrl"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "questItemTypeId": questItemTypeId,
        "locationId": locationId,
        "questId": questId,
        "content": content,
        "description": description,
        "duration": duration,
        "updatedDate":
            updatedDate == null ? null : updatedDate?.toIso8601String(),
        "qrCode": qrCode == null ? null : qrCode,
        "rightAnswer": rightAnswer,
        "status": status,
        "itemId": itemId,
        "createdDate":
            createdDate == null ? null : createdDate?.toIso8601String(),
        "answerImageUrl": answerImageUrl == null ? null : answerImageUrl,
      };
}
