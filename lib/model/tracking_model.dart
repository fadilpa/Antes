// To parse this JSON data, do
//
//     final trackingRespones = trackingResponesFromJson(jsonString);

import 'dart:convert';

List<TrackingRespones> trackingResponesFromJson(String str) => List<TrackingRespones>.from(json.decode(str).map((x) => TrackingRespones.fromJson(x)));

String trackingResponesToJson(List<TrackingRespones> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class TrackingRespones {
    List<Datum>? data;
    String? message;
    String? statusCode;

    TrackingRespones({
        this.data,
        this.message,
        this.statusCode,
    });

    factory TrackingRespones.fromJson(Map<String, dynamic> json) => TrackingRespones(
        data: json["data"] == null ? [] : List<Datum>.from(json["data"]!.map((x) => Datum.fromJson(x))),
        message: json["message"],
        statusCode: json["status_code"],
    );

    Map<String, dynamic> toJson() => {
        "data": data == null ? [] : List<dynamic>.from(data!.map((x) => x.toJson())),
        "message": message,
        "status_code": statusCode,
    };
}

class Datum {
    String type;
    String category;
    String message;

    Datum({
        required this.type,
        required this.category,
        required this.message,
    });

    factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        type: json["type"],
        category: json["category"],
        message: json["message"],
    );

    Map<String, dynamic> toJson() => {
        "type": type,
        "category": category,
        "message": message,
    };
}
