// To parse this JSON data, do
//
//     final questItem = questItemFromJson(jsonString);

import 'dart:convert';

List<QuestItem> questItemFromJson(String str) => List<QuestItem>.from(json.decode(str).map((x) => QuestItem.fromJson(x)));

String questItemToJson(List<QuestItem> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class QuestItem {
    QuestItem({
        required this.id,
        required this.name,
        required this.ans,
    });

    int id;
    String name;
    String ans;

    factory QuestItem.fromJson(Map<String, dynamic> json) => QuestItem(
        id: json["id"],
        name: json["name"],
        ans: json["ans"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "ans": ans,
    };
}
