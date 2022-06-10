// To parse this JSON data, do
//
//     final customerQuest = customerQuestFromJson(jsonString);

import 'dart:convert';

List<CustomerQuest> customerQuestFromJson(String str) =>
    List<CustomerQuest>.from(
        json.decode(str).map((x) => CustomerQuest.fromJson(x)));

String customerQuestToJson(List<CustomerQuest> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class CustomerQuest {
  CustomerQuest({
    required this.id,
    required this.beginPoint,
    this.endPoint,
    this.createdDate,
    required this.rating,
    required this.feedBack,
    required this.customerId,
    required this.isFinished,
    required this.questId,
    this.status,
    this.paymentMethod,
  });

  int id;
  String beginPoint;
  dynamic endPoint;
  dynamic createdDate;
  int rating;
  String feedBack;
  String customerId;
  bool isFinished;
  int questId;
  dynamic status;
  dynamic paymentMethod;

  factory CustomerQuest.fromJson(Map<String, dynamic> json) => CustomerQuest(
        id: json["id"],
        beginPoint: json["beginPoint"],
        endPoint: json["endPoint"],
        createdDate: json["createdDate"],
        rating: json["rating"],
        feedBack: json["feedBack"],
        customerId: json["customerId"],
        isFinished: json["isFinished"],
        questId: json["questId"],
        status: json["status"],
        paymentMethod: json["paymentMethod"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "beginPoint": beginPoint,
        "endPoint": endPoint,
        "createdDate": createdDate,
        "rating": rating,
        "feedBack": feedBack,
        "customerId": customerId,
        "isFinished": isFinished,
        "questId": questId,
        "status": status,
        "paymentMethod": paymentMethod,
      };
}
