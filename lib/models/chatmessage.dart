// To parse this JSON data, do
//
//     final chatMessage = chatMessageFromJson(jsonString);

import 'dart:convert';

List<ChatMessage> chatMessageFromJson(String str) => List<ChatMessage>.from(
    json.decode(str).map((x) => ChatMessage.fromJson(x)));

String chatMessageToJson(List<ChatMessage> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class ChatMessage {
  ChatMessage({
    required this.user,
    required this.message,
    required this.conId,
  });

  String user;
  String message;
  String conId;

  factory ChatMessage.fromJson(Map<String, dynamic> json) => ChatMessage(
        user: json["user"],
        message: json["message"],
        conId: json["conId"],
      );

  Map<String, dynamic> toJson() => {
        "user": user,
        "message": message,
        "conId": conId,
      };
}
