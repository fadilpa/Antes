import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:location/location.dart';
import 'package:mentegoz_technologies/controller/Provider/location_provider.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

Future Upload(
    BuildContext context,
    firebase_id,
    count,
    addressresult,
    dropdownvalue,
    optionlist,
    description,
    currentTime,
    amount,
    filepath) async {
  String? currentTime = DateTime.now().toString();
 final LocationData? addressresult =
      Provider.of<LocationProvider>(context, listen: false).currentLocation;
       final adress =
      Provider.of<LocationProvider>(context, listen: false).address;
  final amountcontroller = Provider.of<LocationProvider>(context, listen: false)
      .uploadAmountController;
  final descrptioncontroller =
      Provider.of<LocationProvider>(context, listen: false)
          .uploadDescriptionController;
  final categoryValue =
      Provider.of<LocationProvider>(context, listen: false).category ?? "Food";
  var optionsValue =
      Provider.of<LocationProvider>(context, listen: false).options ??
          "BreakFast";
  final curretService =
      Provider.of<LocationProvider>(context, listen: false).currentService;
  final dio = Dio();
  SharedPreferences prefs = await SharedPreferences.getInstance();
  final firebase_id = prefs.getString('Firebase_Id');

  if (categoryValue != "Food") {
    optionsValue = "";
  }
  final formData = FormData.fromMap({
    "firebase_id": firebase_id,
    "service_id": curretService!.id,
    "geolocation": adress ?? "Address Not Found",
    "coordinates": addressresult!.latitude.toString()+","+addressresult.longitude.toString() ?? "No Options",
    "category": categoryValue,
    "option": optionsValue,
    "description": descrptioncontroller,
    "date_time": currentTime,
    "amount": amountcontroller,
    'image': await MultipartFile.fromFile(filepath.toString(),
        filename: 'image.png' //change this'filepath'
        ),
  });

  print(firebase_id);
  print(curretService.id);
  print(addressresult);
  print(categoryValue);
  print(optionsValue);
  print(descrptioncontroller);
  print(amountcontroller);
  print(filepath);
  final response = await dio.post(
    'http://antesapp.com/api/upload_bill',
    data: formData,
  );
  print(response.statusCode);
  print(jsonEncode(response.data));
  if (response.statusCode == 200) {
    // Navigator.pop(context);
    ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Bill Uploaded Succesfully!')));
  } else {
    ScaffoldMessenger.of(context)
        .showSnackBar(const SnackBar(content: Text('Check Your Internet')));
    throw Exception();
    // ignore: prefer_const_constructors
  }
}
