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
    required this.imagePath,
    required this.gender,
    required this.address,
    required this.fullName,
    required this.id,
    required this.userName,
    required this.normalizedUserName,
    required this.email,
    required this.normalizedEmail,
    required this.emailConfirmed,
    required this.passwordHash,
    required this.securityStamp,
    required this.concurrencyStamp,
    this.phoneNumber,
    required this.phoneNumberConfirmed,
    required this.twoFactorEnabled,
    this.lockoutEnd,
    required this.lockoutEnabled,
    required this.accessFailedCount,
  });

  String? imagePath;
  bool gender;
  String? address;
  String id;
  String userName;
  String normalizedUserName;
  String email;
  String normalizedEmail;
  bool emailConfirmed;
  String? passwordHash;
  String securityStamp;
  String concurrencyStamp;
  dynamic phoneNumber;
  bool phoneNumberConfirmed;
  bool twoFactorEnabled;
  dynamic lockoutEnd;
  bool lockoutEnabled;
  int accessFailedCount;
  String fullName;

  factory Customer.fromJson(Map<String, dynamic> json) => Customer(
        imagePath: json["imagePath"] == null ? null : json["imagePath"],
        gender: json["gender"],
        address: json["address"] == null ? null : json["address"],
        id: json["id"],
        userName: json["userName"],
        fullName: json["fullName"],
        normalizedUserName: json["normalizedUserName"],
        email: json["email"],
        normalizedEmail: json["normalizedEmail"],
        emailConfirmed: json["emailConfirmed"],
        passwordHash:
            json["passwordHash"] == null ? null : json["passwordHash"],
        securityStamp: json["securityStamp"],
        concurrencyStamp: json["concurrencyStamp"],
        phoneNumber: json["phoneNumber"],
        phoneNumberConfirmed: json["phoneNumberConfirmed"],
        twoFactorEnabled: json["twoFactorEnabled"],
        lockoutEnd: json["lockoutEnd"],
        lockoutEnabled: json["lockoutEnabled"],
        accessFailedCount: json["accessFailedCount"],
      );

  Map<String, dynamic> toJson() => {
        "imagePath": imagePath == null ? null : imagePath,
        "gender": gender,
        "address": address == null ? null : address,
        "id": id,
        "fullName": fullName,
        "userName": userName,
        "normalizedUserName": normalizedUserName,
        "email": email,
        "normalizedEmail": normalizedEmail,
        "emailConfirmed": emailConfirmed,
        "passwordHash": passwordHash == null ? null : passwordHash,
        "securityStamp": securityStamp,
        "concurrencyStamp": concurrencyStamp,
        "phoneNumber": phoneNumber,
        "phoneNumberConfirmed": phoneNumberConfirmed,
        "twoFactorEnabled": twoFactorEnabled,
        "lockoutEnd": lockoutEnd,
        "lockoutEnabled": lockoutEnabled,
        "accessFailedCount": accessFailedCount,
      };
}
