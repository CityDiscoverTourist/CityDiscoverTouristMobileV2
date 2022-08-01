// To parse this JSON data, do
//
//     final questItem = questItemFromJson(jsonString);

import 'dart:convert';

QuestItem questItemFromJson(String str) => QuestItem.fromJson(json.decode(str));

String questItemToJson(QuestItem data) => json.encode(data.toJson());

class QuestItem {
  QuestItem({
    required this.id,
    required this.questItemTypeId,
    required this.locationId,
    required this.questId,
    required this.content,
    required this.description,
    required this.duration,
    //  this.createdDate,
    //  this.updatedDate,
    required this.story,
    required this.rightAnswer,
    required this.answerImageUrl,
    required this.status,
    required this.listImages,
    // required this.suggestions,
    required this.itemId,
  });

  int id;
  int questItemTypeId;
  int locationId;
  int questId;
  String content;
  String description;
  int duration;
  // DateTime? createdDate;
  // DateTime? updatedDate;
  String story;
  String? rightAnswer;
  String? answerImageUrl;
  String status;
  List<String> listImages;
  // List<Suggestion> suggestions;
  int itemId;

  factory QuestItem.fromJson(Map<String, dynamic> json) => QuestItem(
        id: json["id"],
        questItemTypeId: json["questItemTypeId"],
        locationId: json["locationId"],
        questId: json["questId"],
        content: json["content"],
        description: json["description"],
        duration: json["duration"],
        // createdDate: DateTime.parse(json["createdDate"]),
        // updatedDate: DateTime.parse(json["updatedDate"]),
        story: json["story"],
        rightAnswer: json["rightAnswer"],
        answerImageUrl: json["answerImageUrl"],
        status: json["status"],
        listImages: List<String>.from(json["listImages"].map((x) => x)),
        // suggestions: List<Suggestion>.from(json["suggestions"].map((x) => Suggestion.fromJson(x))),
        itemId: json["itemId"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "questItemTypeId": questItemTypeId,
        "locationId": locationId,
        "questId": questId,
        "content": content,
        "description": description,
        "duration": duration,
        // "createdDate": createdDate.toString(),
        // "updatedDate": updatedDate.toString(),
        "story": story,
        "rightAnswer": rightAnswer,
        "answerImageUrl": answerImageUrl,
        "status": status,
        "listImages": List<dynamic>.from(listImages.map((x) => x)),
        // "suggestions": List<dynamic>.from(suggestions.map((x) => x.toJson())),
        "itemId": itemId,
      };
}
