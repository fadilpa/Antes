import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:mentegoz_technologies/view/upload_bill/uploadedbill.dart';
import 'package:mentegoz_technologies/controller/varibles.dart';
import 'package:shared_preferences/shared_preferences.dart';

Future Upload(serviceCount, filepath, description, amount) async {
  final dio = Dio();
  SharedPreferences prefs = await SharedPreferences.getInstance();
  final firebase_id = prefs.getString('Firebase_Id');
  final formData = FormData.fromMap({
    "firebase_id": firebase_id,
    "service_id": "Service ",
    "geolocation": addressResult,
    "category": dropdownValue,
    "option": optionList.first,
    "description": description,
    "date_time": currentTime.toString(),
    "amount": amount,
    'image': await MultipartFile.fromFile(filepath, filename: 'image'),
  });
  final response = await dio.post(
    'https://antes.meduco.in/api/upload_bill',
    data: formData,
  );
  print(response.statusCode);

  if (response.statusCode == 200) {
    // Navigator.pop(context);
    ScaffoldMessenger.of(amount)
        .showSnackBar(const SnackBar(content: Text('Upload Succesful')));
  } else {
    ScaffoldMessenger.of(description)
        .showSnackBar(const SnackBar(content: Text('Check Your Internet')));
    throw Exception();
    // ignore: prefer_const_constructors
  }
}
