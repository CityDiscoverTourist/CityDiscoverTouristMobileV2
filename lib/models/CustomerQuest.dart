// To parse this JSON data, do
//
//     final customerQuest = customerQuestFromJson(jsonString);

import 'dart:convert';

CustomerQuest customerQuestFromJson(String str) =>
    CustomerQuest.fromJson(json.decode(str));

String customerQuestToJson(CustomerQuest data) => json.encode(data.toJson());

class CustomerQuest {
  CustomerQuest({
    required this.data,
  });

  List<Datum> data;

  factory CustomerQuest.fromJson(Map<String, dynamic> json) => CustomerQuest(
        data: List<Datum>.from(json["data"].map((x) => Datum.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
      };
}

class Datum {
  Datum({
    required this.beginPoint,
    this.endPoint,
    this.createdDate,
    required this.rating,
    required this.feedBack,
    required this.customerId,
    required this.competitionId,
    this.paymentMethod,
  });

  String beginPoint;
  dynamic endPoint;
  dynamic createdDate;
  int rating;
  String feedBack;
  String customerId;
  int competitionId;
  dynamic paymentMethod;

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        beginPoint: json["beginPoint"],
        endPoint: json["endPoint"],
        createdDate: json["createdDate"],
        rating: json["rating"],
        feedBack: json["feedBack"],
        customerId: json["customerId"],
        competitionId: json["competitionId"],
        paymentMethod: json["paymentMethod"],
      );

  Map<String, dynamic> toJson() => {
        "beginPoint": beginPoint,
        "endPoint": endPoint,
        "createdDate": createdDate,
        "rating": rating,
        "feedBack": feedBack,
        "customerId": customerId,
        "competitionId": competitionId,
        "paymentMethod": paymentMethod,
      };
}
