// To parse this JSON data, do
//
//     final customer = customerFromJson(jsonString);

import 'dart:convert';

List<Customer> customerFromJson(String str) =>
    List<Customer>.from(json.decode(str).map((x) => Customer.fromJson(x)));

String customerToJson(List<Customer> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Customer {
  Customer({
    this.imagePath,
    required this.id,
    required this.userName,
    required this.normalizedUserName,
    required this.email,
    required this.normalizedEmail,
    required this.emailConfirmed,
    this.passwordHash,
    required this.securityStamp,
    required this.concurrencyStamp,
    this.phoneNumber,
    required this.phoneNumberConfirmed,
    required this.twoFactorEnabled,
    // required this.lockoutEnd,
    required this.lockoutEnabled,
    required this.accessFailedCount,
  });

  dynamic imagePath;
  String id;
  String userName;
  String normalizedUserName;
  String email;
  String normalizedEmail;
  bool emailConfirmed;
  dynamic passwordHash;
  String securityStamp;
  String concurrencyStamp;
  dynamic phoneNumber;
  bool phoneNumberConfirmed;
  bool twoFactorEnabled;
  // DateTime lockoutEnd;
  bool lockoutEnabled;
  int accessFailedCount;

  factory Customer.fromJson(Map<String, dynamic> json) => Customer(
        imagePath: json["imagePath"],
        id: json["id"],
        userName: json["userName"],
        normalizedUserName: json["normalizedUserName"],
        email: json["email"],
        normalizedEmail: json["normalizedEmail"],
        emailConfirmed: json["emailConfirmed"],
        passwordHash: json["passwordHash"],
        securityStamp:
            json["securityStamp"] == null ? null : json["securityStamp"],
        concurrencyStamp:
            json["concurrencyStamp"] == null ? null : json["concurrencyStamp"],
        phoneNumber: json["phoneNumber"],
        phoneNumberConfirmed: json["phoneNumberConfirmed"],
        twoFactorEnabled: json["twoFactorEnabled"],
        // lockoutEnd: json["lockoutEnd"] == null ? null : DateTime.parse(json["lockoutEnd"]),
        lockoutEnabled: json["lockoutEnabled"],
        accessFailedCount: json["accessFailedCount"],
      );

  Map<String, dynamic> toJson() => {
        "imagePath": imagePath,
        "id": id,
        "userName": userName,
        "normalizedUserName": normalizedUserName,
        "email": email,
        "normalizedEmail": normalizedEmail,
        "emailConfirmed": emailConfirmed,
        "passwordHash": passwordHash,
        "securityStamp": securityStamp == null ? null : securityStamp,
        "concurrencyStamp": concurrencyStamp == null ? null : concurrencyStamp,
        "phoneNumber": phoneNumber,
        "phoneNumberConfirmed": phoneNumberConfirmed,
        "twoFactorEnabled": twoFactorEnabled,
        // "lockoutEnd": lockoutEnd == null ? null : lockoutEnd.toIso8601String(),
        "lockoutEnabled": lockoutEnabled,
        "accessFailedCount": accessFailedCount,
      };
}
