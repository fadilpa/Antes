// // To parse this JSON data, do
// //
// //     final services = servicesFromJson(jsonString);

// import 'dart:convert';

// List<Services> servicesFromJson(String str) => List<Services>.from(json.decode(str).map((x) => Services.fromJson(x)));

// String servicesToJson(List<Services> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

// class Services {
//     List<Datum>? data;
//     String? message;
//     String? statusCode;

//     Services({
//         required this.data,
//         required this.message,
//         required this.statusCode,
//     });

//     factory Services.fromJson(Map<String, dynamic> json) => Services(
//         data: List<Datum>.from(json["data"].map((x) => Datum.fromJson(x))),
//         message: json["message"],
//         statusCode: json["status_code"],
//     );

//     Map<String, dynamic> toJson() => {
//         "data": List<dynamic>.from(data!.map((x) => x.toJson())),
//         "message": message,
//         "status_code": statusCode,
//     };
// }

// class Datum {
//     int? id;
//     String? serviceName;
//     String? refNo;
//     String? startDate;
//     String? startTime;
//     String? endDate;
//     String? endTime;
//     String? priority;
//     String? status;
//     String? clientName;
//     String? category;

//     Datum({
//         required this.id,
//         required this.serviceName,
//         required this.refNo,
//         required this.startDate,
//         required this.startTime,
//         required this.endDate,
//         required this.endTime,
//         required this.priority,
//         required this.status,
//         required this.clientName,
//         required this.category,
//     });

//     factory Datum.fromJson(Map<String, dynamic> json) => Datum(
//         id: json["id"],
//         serviceName: json["service_name"],
//         refNo: json["ref_no"],
//         startDate: json["start_date"],
//         // startDate: DateTime.parse(json["start_date"]),
//         startTime: json["start_time"],
//         // endDate: DateTime.parse(json["end_date"]),
//         endDate: json["end_date"],
//         endTime: json["end_time"],
//         priority: json["priority"],
//         status: json["status"],
//         clientName: json["client_name"],
//         category: json["category"],
//     );

//     Map<String, dynamic> toJson() => {
//         "id": id,
//         "service_name": serviceName,
//         "ref_no": refNo,
//         "start_date":startDate,
//         // "start_date": "${startDate!.year.toString().padLeft(4, '0')}-${startDate!.month.toString().padLeft(2, '0')}-${startDate!.day.toString().padLeft(2, '0')}",
//         "start_time": startTime,
//         "end_date":endDate,
//         // "end_date": "${endDate!.year.toString().padLeft(4, '0')}-${endDate!.month.toString().padLeft(2, '0')}-${endDate!.day.toString().padLeft(2, '0')}",
//         "end_time": endTime,
//         "priority": priority,
//         "status": status,
//         "client_name": clientName,
//         "category": category,
//     };
// }
