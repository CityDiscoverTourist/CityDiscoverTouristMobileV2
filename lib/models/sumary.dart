// To parse this JSON data, do
//
//     final sumary = sumaryFromJson(jsonString);

import 'dart:convert';

Sumary sumaryFromJson(String str) => Sumary.fromJson(json.decode(str));

String sumaryToJson(Sumary data) => json.encode(data.toJson());

class Sumary {
  Sumary({
    required this.id,
    required this.currentPoint,
    required this.status,
    required this.createdDate,
    required this.questItemId,
    required this.customerQuestId,
    required this.countWrongAnswer,
    required this.countSuggestion,
    required this.isFinished,
    this.customerEmail,
    required this.questName,
    required this.imagePath,
  });

  int id;
  int currentPoint;
  String status;
  DateTime createdDate;
  int questItemId;
  int customerQuestId;
  int countWrongAnswer;
  int countSuggestion;
  bool isFinished;
  dynamic customerEmail;
  String questName;
  String imagePath;

  factory Sumary.fromJson(Map<String, dynamic> json) => Sumary(
        id: json["id"],
        currentPoint: json["currentPoint"],
        status: json["status"],
        createdDate: DateTime.parse(json["createdDate"]),
        questItemId: json["questItemId"],
        customerQuestId: json["customerQuestId"],
        countWrongAnswer: json["countWrongAnswer"],
        countSuggestion: json["countSuggestion"],
        isFinished: json["isFinished"],
        customerEmail: json["customerEmail"],
        questName: json["questName"],
        imagePath: json["imagePath"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "currentPoint": currentPoint,
        "status": status,
        "createdDate": createdDate.toIso8601String(),
        "questItemId": questItemId,
        "customerQuestId": customerQuestId,
        "countWrongAnswer": countWrongAnswer,
        "countSuggestion": countSuggestion,
        "isFinished": isFinished,
        "customerEmail": customerEmail,
        "questName": questName,
        "imagePath": imagePath,
      };
}
