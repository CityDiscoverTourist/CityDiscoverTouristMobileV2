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
    required this.receivedDate,
    required this.expiredDate,
    required this.customerId,
    required this.status,
  });

  String name;
  DateTime receivedDate;
  DateTime expiredDate;
  String customerId;
  String status;

  factory Reward.fromJson(Map<String, dynamic> json) => Reward(
        name: json["name"],
        receivedDate: DateTime.parse(json["receivedDate"]),
        expiredDate: DateTime.parse(json["expiredDate"]),
        customerId: json["customerId"],
        status: json["status"],
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "receivedDate": receivedDate.toIso8601String(),
        "expiredDate": expiredDate.toIso8601String(),
        "customerId": customerId,
        "status": status,
      };
}
