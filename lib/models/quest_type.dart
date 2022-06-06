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
        required this.durationMode,
        required this.distanceMode,
        this.imagePath,
    });

    int id;
    String name;
    String status;
    String durationMode;
    String distanceMode;
    dynamic imagePath;

    factory QuestType.fromJson(Map<String, dynamic> json) => QuestType(
        id: json["id"],
        name: json["name"],
        status: json["status"],
        durationMode: json["durationMode"],
        distanceMode: json["distanceMode"],
        imagePath: json["imagePath"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "status": status,
        "durationMode": durationMode,
        "distanceMode": distanceMode,
        "imagePath": imagePath,
    };
}
