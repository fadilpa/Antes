// To parse this JSON data, do
//
//     final tickets = ticketsFromJson(jsonString);

import 'dart:convert';

List<Tickets> ticketsFromJson(String str) => List<Tickets>.from(json.decode(str).map((x) => Tickets.fromJson(x)));

String ticketsToJson(List<Tickets> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Tickets {
    List<Datum>? data;
    String? message;
    String? statusCode;

    Tickets({
        this.data,
        this.message,
        this.statusCode,
    });

    factory Tickets.fromJson(Map<String, dynamic> json) => Tickets(
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
    String ticketNumber;
    String subject;
    String? description;
    DateTime dateTime;
    int? reqAmount;
    String? status;
    String? reason;
    String serviceName;

    Datum({
        required this.ticketNumber,
        required this.subject,
        required this.description,
        required this.dateTime,
        required this.reqAmount,
        required this.status,
        required this.reason,
        required this.serviceName,
    });

    factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        ticketNumber: json["ticket_number"],
        subject: json["subject"],
        description: json["description"],
        dateTime: DateTime.parse(json["date_time"]),
        reqAmount: json["req_amount"],
        status: json["status"],
        reason: json["reason"],
        serviceName: json["service_name"],
    );

    Map<String, dynamic> toJson() => {
        "ticket_number": ticketNumber,
        "subject": subject,
        "description": description,
        "date_time": dateTime.toIso8601String(),
        "req_amount": reqAmount,
        "status": status,
        "reason": reason,
        "service_name": serviceName,
    };
}
