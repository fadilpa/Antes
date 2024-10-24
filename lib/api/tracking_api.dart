import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:mentegoz_technologies/model/ticket_tracking_model.dart';

import 'package:mentegoz_technologies/model/tracking_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class TrackingApiService {
  Future<TrackingRespones> fetchJourneys(var currentServiceId) async {
    final prefs = await SharedPreferences.getInstance();
// ignore: unused_local_variable
    String? firebase_Id = prefs.getString('Firebase_Id');
    final dio = Dio();
    const url = 'http://antesapp.com/api/service_activity_list';

    final formData = FormData.fromMap({
      "firebase_id": firebase_Id,
      "service_id": currentServiceId,
    });
    final response = await dio.post(
      url,
      data: formData,
    );

 
    if (response.statusCode == 200) {
      
      return TrackingRespones.fromJson(response.data[0]);
    } else {
      throw Exception('Failed to load journeys');
    }
  }
    Future<TicketTracking> fetchTicketsTracking(var ticket_id) async {
    final prefs = await SharedPreferences.getInstance();
// ignore: unused_local_variable
    String? firebase_Id = prefs.getString('Firebase_Id');
    final dio = Dio();
    const url = 'http://antesapp.com/api/ticket_activity_list';

    final formData = FormData.fromMap({
      "firebase_id": firebase_Id,
      "ticket_id": ticket_id,
    });
    final response = await dio.post(
      url,
      data: formData,
    );

 
    if (response.statusCode == 200) {
      
      return TicketTracking.fromJson(response.data[0]);
    } else {
      throw Exception('Failed to load journeys');
    }
  }
}
