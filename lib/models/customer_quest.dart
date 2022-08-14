// To parse this JSON data, do
//
//     final customerQuest = customerQuestFromJson(jsonString);

import 'dart:convert';

CustomerQuest customerQuestFromJson(String str) => CustomerQuest.fromJson(json.decode(str));

String customerQuestToJson(CustomerQuest data) => json.encode(data.toJson());

class CustomerQuest {
    CustomerQuest({
        this.id,
        this.beginPoint,
        this.endPoint,
        required this.createdDate,
        this.rating,
        this.feedBack,
        this.customerId,
        this.customerName,
        this.isFinished,
        this.questId,
        required this.questName,
        this.imagePath,
        this.paymentId,
        this.status,
        this.isFeedbackApproved,
        this.rewardCode,
        this.percentDiscount,
        this.percentPointRemain,
    });

    int? id;
    String? beginPoint;
    String? endPoint;
    DateTime createdDate;
    int? rating;
    String? feedBack;
    String? customerId;
    String? customerName;
    bool? isFinished;
    int? questId;
    String? questName;
    String? imagePath;
    String? paymentId;
    String? status;
    bool? isFeedbackApproved;
    String? rewardCode;
    int? percentDiscount;
    double? percentPointRemain;

    factory CustomerQuest.fromJson(Map<String, dynamic> json) => CustomerQuest(
        id: json["id"],
        beginPoint: json["beginPoint"],
        endPoint: json["endPoint"],
        createdDate: DateTime.parse(json["createdDate"]),
        rating: json["rating"],
        feedBack: json["feedBack"],
        customerId: json["customerId"],
        customerName: json["customerName"],
        isFinished: json["isFinished"],
        questId: json["questId"],
        questName: json["questName"],
        imagePath: json["imagePath"],
        paymentId: json["paymentId"],
        status: json["status"],
        isFeedbackApproved: json["isFeedbackApproved"],
        rewardCode: json["rewardCode"],
        percentDiscount: json["percentDiscount"],
        percentPointRemain: json["percentPointRemain"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "beginPoint": beginPoint,
        "endPoint": endPoint,
        "createdDate": createdDate.toString(),
        "rating": rating,
        "feedBack": feedBack,
        "customerId": customerId,
        "customerName": customerName,
        "isFinished": isFinished,
        "questId": questId,
        "questName": questName,
        "imagePath": imagePath,
        "paymentId": paymentId,
        "status": status,
        "isFeedbackApproved": isFeedbackApproved,
        "rewardCode": rewardCode,
        "percentDiscount": percentDiscount,
        "percentPointRemain": percentPointRemain,
    };
}
