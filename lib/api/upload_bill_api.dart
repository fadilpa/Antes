import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:mentegoz_technologies/controller/Provider/location_provider.dart';
import 'package:mentegoz_technologies/view/upload_bill/uploadedbill.dart';
import 'package:mentegoz_technologies/controller/varibles.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

Future Upload(context, firebase_id, count, addressresult, dropdownvalue,
    optionlist, description, currentTime, amount, filepath) async {
  String? currentTime = DateTime.now().toString();
  final addressresult =
      Provider.of<LocationProvider>(context, listen: false).address;
  final amountcontroller = Provider.of<LocationProvider>(context, listen: false).uploadAmountController;
  final descrptioncontroller =
      Provider.of<LocationProvider>(context, listen: false).uploadDescriptionController;
  final categoryValue =
      Provider.of<LocationProvider>(context, listen: false).category;
  final optionsValue =
      Provider.of<LocationProvider>(context, listen: false).options;
  final curretService =
      Provider.of<LocationProvider>(context, listen: false).currentService;
  final dio = Dio();
  SharedPreferences prefs = await SharedPreferences.getInstance();
  final firebase_id = prefs.getString('Firebase_Id');
  final formData = FormData.fromMap({
    "firebase_id": firebase_id,
    "service_id": curretService!.id,
    "geolocation": addressresult ?? "adresf noy fifd",
    "category": categoryValue, 
    "option": optionsValue,
    "description": descrptioncontroller,
    "date_time": currentTime,
    "amount": amountcontroller,
    'image': filepath != null
        ? await MultipartFile.fromFile(filepath, //change this'filepath'
            filename: 'image')
        : null,
  });

  print(firebase_id);
  print(curretService.id);
  print(addressresult);
  print(categoryValue);
  print(optionsValue);
  print(descrptioncontroller);
  print(amountcontroller);

  final response = await dio.post(
    'https://antes.meduco.in/api/upload_bill',
    data: formData,
  );
  print(response.statusCode);
  print(jsonEncode(response.data));
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