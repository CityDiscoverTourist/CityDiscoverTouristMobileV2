// To parse this JSON data, do
//
//     final comment = commentFromJson(jsonString);

import 'dart:convert';

List<Comment> commentFromJson(String str) => List<Comment>.from(json.decode(str).map((x) => Comment.fromJson(x)));

String commentToJson(List<Comment> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Comment {
    Comment({
        required this.id,
        required this.customerId,
        required this.name,
        this.imagePath,
        this.feedBack,
        required this.rating,
        required this.createdDate,
    });

    int id;
    String customerId;
    String name;
    dynamic imagePath;
    String? feedBack;
    int rating;
    DateTime createdDate;

    factory Comment.fromJson(Map<String, dynamic> json) => Comment(
        id: json["id"],
        customerId: json["customerId"],
        name: json["name"],
        imagePath: json["imagePath"],
        feedBack: json["feedBack"],
        rating: json["rating"],
        createdDate: DateTime.parse(json["createdDate"]),
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "customerId": customerId,
        "name": name,
        "imagePath": imagePath,
        "feedBack": feedBack,
        "rating": rating,
        "createdDate": createdDate.toString(),
    };
}
