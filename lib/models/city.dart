// To parse this JSON data, do
//
//     final city = cityFromJson(jsonString);

import 'dart:convert';

List<City> cityFromJson(String str) => List<City>.from(json.decode(str).map((x) => City.fromJson(x)));

String cityToJson(List<City> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class City {
    City({
        required this.id,
        required this.name,
        required this.status,
        required this.cityId,
        required this.locations,
    });

    int id;
    String name;
    String status;
    int cityId;
    List<dynamic> locations;

    factory City.fromJson(Map<String, dynamic> json) => City(
        id: json["id"],
        name: json["name"],
        status: json["status"],
        cityId: json["cityId"],
        locations: List<dynamic>.from(json["locations"].map((x) => x)),
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "status": status,
        "cityId": cityId,
        "locations": List<dynamic>.from(locations.map((x) => x)),
    };
}
