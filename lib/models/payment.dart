// To parse this JSON data, do
//
//     final payment = paymentFromJson(jsonString);

import 'dart:convert';

List<Payment> paymentFromJson(String str) =>
    List<Payment>.from(json.decode(str).map((x) => Payment.fromJson(x)));

String paymentToJson(List<Payment> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Payment {
  Payment({
    required this.id,
    required this.paymentMethod,
    required this.quantity,
    required this.totalAmount,
    required this.status,
    required this.createdDate,
    required this.customerId,
    required this.isValid,
    required this.questId,
    required this.questName,
    required this.questDescription,
  });

  String id;
  dynamic paymentMethod;
  int quantity;
  int totalAmount;
  String status;
  DateTime createdDate;
  String customerId;
  bool isValid;
  int questId;
  String questName;
  String questDescription;

  factory Payment.fromJson(Map<String, dynamic> json) => Payment(
        id: json["id"],
        paymentMethod: json["paymentMethod"],
        quantity: json["quantity"],
        totalAmount: json["totalAmount"],
        status: json["status"],
        createdDate: DateTime.parse(json["createdDate"]),
        customerId: json["customerId"],
        isValid: json["isValid"],
        questId: json["questId"],
        questName: json["questName"],
        questDescription: json["questDescription"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "paymentMethod": paymentMethod,
        "quantity": quantity,
        "totalAmount": totalAmount,
        "status": status,
        "createdDate": createdDate.toIso8601String(),
        "customerId": customerId,
        "isValid": isValid,
        "questId": questId,
        "questName": questName,
        "questDescription": questDescription,
      };
}
