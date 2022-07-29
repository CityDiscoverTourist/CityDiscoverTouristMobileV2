// To parse this JSON data, do
//
//     final reward = rewardFromJson(jsonString);

import 'dart:convert';

List<Reward> rewardFromJson(String str) =>
    List<Reward>.from(json.decode(str).map((x) => Reward.fromJson(x)));

String rewardToJson(List<Reward> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Reward {
  Reward({
    required this.name,
    required this.code,
    required this.receivedDate,
    required this.expiredDate,
    required this.percentDiscount,
    required this.customerId,
    required this.status,
  });

  String name;
  String code;
  DateTime receivedDate;
  DateTime expiredDate;
  int percentDiscount;
  String customerId;
  String status;

  factory Reward.fromJson(Map<String, dynamic> json) => Reward(
        name: json["name"],
        code: json["code"],
        receivedDate: DateTime.parse(json["receivedDate"]),
        expiredDate: DateTime.parse(json["expiredDate"]),
        percentDiscount: json["percentDiscount"],
        customerId: json["customerId"],
        status: json["status"],
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "code": code,
        "receivedDate": receivedDate.toIso8601String(),
        "expiredDate": expiredDate.toIso8601String(),
        "percentDiscount": percentDiscount,
        "customerId": customerId,
        "status": status,
      };
}
