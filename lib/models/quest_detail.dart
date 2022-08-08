// To parse this JSON data, do
//
//     final questDetail = questDetailFromJson(jsonString);

import 'dart:convert';

QuestDetail questDetailFromJson(String str) => QuestDetail.fromJson(json.decode(str));

String questDetailToJson(QuestDetail data) => json.encode(data.toJson());

class QuestDetail {
    QuestDetail({
        required this.id,
        required this.title,
        required this.description,
        required this.price,
        required this.imagePath,
        required this.estimatedTime,
        required this.estimatedDistance,
        required this.availableTime,
        required this.status,
        required this.questTypeId,
        required this.areaId,
        required this.countQuestItem,
        required this.address,
        required this.latLong,
        required this.totalFeedback,
        required this.averageStar,
        required this.areaName,
    });

    int id;
    String title;
    String description;
    double price;
    String imagePath;
    String estimatedTime;
    String estimatedDistance;
    String availableTime;
    String status;
    int questTypeId;
    int areaId;
    int countQuestItem;
    String address;
    String latLong;
    int totalFeedback;
    double averageStar;
    String? areaName;

    factory QuestDetail.fromJson(Map<String, dynamic> json) => QuestDetail(
        id: json["id"],
        title: json["title"],
        description: json["description"],
        price: json["price"],
        imagePath: json["imagePath"],
        estimatedTime: json["estimatedTime"],
        estimatedDistance: json["estimatedDistance"],
        availableTime: json["availableTime"],
        status: json["status"],
        questTypeId: json["questTypeId"],
        areaId: json["areaId"],
        countQuestItem: json["countQuestItem"],
        address: json["address"],
        latLong: json["latLong"],
        totalFeedback: json["totalFeedback"],
        averageStar: json["averageStar"].toDouble(),
        areaName: json["areaName"].toString(),
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "title": title,
        "description": description,
        "price": price,
        "imagePath": imagePath,
        "estimatedTime": estimatedTime,
        "estimatedDistance": estimatedDistance,
        "availableTime": availableTime,
        "status": status,
        "questTypeId": questTypeId,
        "areaId": areaId,
        "countQuestItem": countQuestItem,
        "address": address,
        "latLong": latLong,
        "totalFeedback": totalFeedback,
        "averageStar": averageStar,
        "areaName": areaName.toString(),
    };
}
