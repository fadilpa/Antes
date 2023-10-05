import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UserNameAndNumber extends ChangeNotifier{

  String name="";
  String? number;

    get_user_name_and_number() async {
    final prefs = await SharedPreferences.getInstance();
    name = prefs.getString('Name')!;
    number = prefs.getString('Mobile');
    notifyListeners();
 
  }
}