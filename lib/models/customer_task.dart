// To parse this JSON data, do
//
//     final customerTask = customerTaskFromJson(jsonString);

import 'dart:convert';

CustomerTask customerTaskFromJson(String str) => CustomerTask.fromJson(json.decode(str));

String customerTaskToJson(CustomerTask data) => json.encode(data.toJson());

class CustomerTask {
    CustomerTask({
        required this.id,
        required this.currentPoint,
        required this.status,
        required this.createdDate,
        required this.questItemId,
        required this.customerQuestId,
        required this.countWrongAnswer,
        required this.countSuggestion,
        required this.isFinished,
    });

    int id;
    double currentPoint;
    String? status;
    DateTime createdDate;
    int questItemId;
    int customerQuestId;
    int countWrongAnswer;
    int countSuggestion;
    bool isFinished;

    factory CustomerTask.fromJson(Map<String, dynamic> json) => CustomerTask(
        id: json["id"],
        currentPoint: json["currentPoint"],
        status: json["status"],
        createdDate: DateTime.parse(json["createdDate"]),
        questItemId: json["questItemId"],
        customerQuestId: json["customerQuestId"],
        countWrongAnswer: json["countWrongAnswer"],
        countSuggestion: json["countSuggestion"],
        isFinished: json["isFinished"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "currentPoint": currentPoint,
        "status": status,
        "createdDate": createdDate.toString(),
        "questItemId": questItemId,
        "customerQuestId": customerQuestId,
        "countWrongAnswer": countWrongAnswer,
        "countSuggestion": countSuggestion,
        "isFinished": isFinished,
    };
}
