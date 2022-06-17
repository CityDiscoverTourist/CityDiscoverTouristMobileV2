// To parse this JSON data, do
//
//     final comment = commentFromJson(jsonString);

import 'dart:convert';

List<Comment> commentFromJson(String str) => List<Comment>.from(json.decode(str).map((x) => Comment.fromJson(x)));

String commentToJson(List<Comment> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Comment {
    Comment({
        required this.id,
        required this.name,
        required this.imageUrl,
        required this.comment,
        required this.rating,
        required this.date,
    });

    int id;
    String name;
    String imageUrl;
    String comment;
    int rating;
    String date;

    factory Comment.fromJson(Map<String, dynamic> json) => Comment(
        id: json["id"],
        name: json["name"],
        imageUrl: json["imageUrl"],
        comment: json["comment"],
        rating: json["rating"],
        date:json["date"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "imageUrl": imageUrl,
        "comment": comment,
        "rating": rating,
        "date": date,
    };
}
