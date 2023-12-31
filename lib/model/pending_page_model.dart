import 'dart:convert';

List<Autogenerated> GeneratedFromJson(String str) => List<Autogenerated>.from(
    json.decode(str).map((x) => Autogenerated.fromJson(x)));

class Autogenerated {
  List<PendingPageDataModel>? data;

  Autogenerated({this.data});

  Autogenerated.fromJson(Map<String, dynamic> json) {
    if (json['data'] != null) {
      data = <PendingPageDataModel>[];
      json['data'].forEach((v) {
        data!.add(new PendingPageDataModel.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class PendingPageDataModel {
  int? id;
  String? serviceName;
  String? refNo;
  String? startDate;
  String? startTime;
  String? endDate;
  String? endTime;
  String? priority;
  String? status;
  String? clientName;
  String? phone;
  String? email;
  String? address;
  String? landmark;
  String? category;

  PendingPageDataModel(
      {this.id,
      this.serviceName,
      this.refNo,
      this.startDate,
      this.startTime,
      this.endDate,
      this.endTime,
      this.priority,
      this.status,
      this.clientName,
      this.phone,
      this.email,
      this.address,
      this.landmark,
      this.category});

  PendingPageDataModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    serviceName = json['service_name'] ?? "";
    refNo = json['ref_no'] ?? "";
    startDate = json['start_date'] ?? "";
    startTime = json['start_time'] ?? "";
    endDate = json['end_date'] ?? "";
    endTime = json['end_time'] ?? "";
    priority = json['priority'] ?? "";
    status = json['status'] ?? "";
    clientName = json['client_name'] ?? "";
    phone = json['phone'] ?? "";
    email = json['email'] ?? "";
    address = json['address'] ?? "";
    landmark = json['landmark'] ?? "";
    category = json['category'] ?? "";
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['service_name'] = this.serviceName;
    data['ref_no'] = this.refNo;
    data['start_date'] = this.startDate;
    data['start_time'] = this.startTime;
    data['end_date'] = this.endDate;
    data['end_time'] = this.endTime;
    data['priority'] = this.priority;
    data['status'] = this.status;
    data['client_name'] = this.clientName;
    data['phone'] = this.phone;
    data['email'] = this.email;
    data['address'] = this.address;
    data['landmark'] = this.landmark;
    data['category'] = this.category;
    return data;
  }
}
