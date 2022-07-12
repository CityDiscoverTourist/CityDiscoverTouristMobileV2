// To parse this JSON data, do
//
//     final questType = questTypeFromJson(jsonString);

import 'dart:convert';

List<QuestType> questTypeFromJson(String str) => List<QuestType>.from(json.decode(str).map((x) => QuestType.fromJson(x)));

String questTypeToJson(List<QuestType> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class QuestType {
    QuestType({
        required this.id,
        required this.name,
        required this.status,
        this.imagePath,
    });

    int id;
    String name;
    String status;
    dynamic imagePath;

    factory QuestType.fromJson(Map<String, dynamic> json) => QuestType(
        id: json["id"],
        name: json["name"],
        status: json["status"],
        imagePath: json["imagePath"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "status": status,
        "imagePath": imagePath,
    };
}
