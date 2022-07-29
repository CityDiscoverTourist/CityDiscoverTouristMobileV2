// To parse this JSON data, do
//
//     final historyQuest = historyQuestFromJson(jsonString);

import 'dart:convert';

List<PurchasedQuest> historyQuestFromJson(String str) => List<PurchasedQuest>.from(json.decode(str).map((x) => PurchasedQuest.fromJson(x)));

String historyQuestToJson(List<PurchasedQuest> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class PurchasedQuest {
    PurchasedQuest({
        required this.id,
        this.paymentMethod,
        required this.quantity,
        required this.totalAmount,
        required this.status,
        required this.createdDate,
        required this.customerId,
        // required this.customerEmail,
        required this.isValid,
        required this.questId,
        required this.questName,
        required this.questDescription,
        this.imagePath
    });

    String id;
    dynamic paymentMethod;
    int quantity;
    double totalAmount;
    String status;
    DateTime createdDate;
    String customerId;
    // String customerEmail;
    bool isValid;
    int questId;
    String questName;
    String questDescription;
  dynamic imagePath;


    factory PurchasedQuest.fromJson(Map<String, dynamic> json) => PurchasedQuest(
        id: json["id"],
        paymentMethod: json["paymentMethod"],
        quantity: json["quantity"],
        totalAmount: json["totalAmount"],
        status: json["status"],
        createdDate: DateTime.parse(json["createdDate"]),
        customerId: json["customerId"],
        // customerEmail: json["customerEmail"],
        isValid: json["isValid"],
        questId: json["questId"],
        questName: json["questName"],
        questDescription: json["questDescription"],
        imagePath: json["imagePath"]
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "paymentMethod": paymentMethod,
        "quantity": quantity,
        "totalAmount": totalAmount,
        "status": status,
        "createdDate": createdDate.toIso8601String(),
        "customerId": customerId,
        // "customerEmail": customerEmail,
        "isValid": isValid,
        "questId": questId,
        "questName": questName,
        "questDescription": questDescription,
        "imagePath":imagePath
    };
}
