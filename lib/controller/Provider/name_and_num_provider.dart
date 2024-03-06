import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:mentegoz_technologies/model/ticket_model.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart'as http;


class UserNameAndNumber extends ChangeNotifier{

  String name="";
  String? number;

    get_user_name_and_number() async {
    final prefs = await SharedPreferences.getInstance();
    name = prefs.getString('Name')!;
    number = prefs.getString('Mobile');
    notifyListeners();
 
  }
 ///api call for getting the requested services for the user

}