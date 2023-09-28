import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:mentegoz_technologies/controller/Provider/location_provider.dart';
import 'package:provider/provider.dart';

class PostData {
  Future<void> PostStartData(BuildContext context, firebase_id, currentService,
      addressresult, selectedTravelMode, currentTime) async {
    final curretService =
        Provider.of<LocationProvider>(context, listen: false).currentService;
    // int count =1;
    final addresSResult =
        Provider.of<LocationProvider>(context, listen: false).address;

    final dio = Dio();
    // Create a FormData object.
    final formData = FormData.fromMap({
      "firebase_id": firebase_id,
      "service_id": curretService!.id != null ? curretService!.id : 1,
      "geolocation": addresSResult ?? "Address not Accessible",
      "travel_mode": selectedTravelMode,
      "date_time": currentTime,
    });
    print(firebase_id);
    print(currentService.id);
    print(addresSResult ?? "address not found");
    // print(curretService);
    print(selectedTravelMode);
    print(currentTime);
    try {
      final response = await dio.post(
        'https://antes.meduco.in/api/start_service_journey',
        data: formData,
      );
      print(response.statusCode);
      print(jsonEncode(response.data));
    } catch (error) {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Error'),
            content: Text(error.toString()),
            actions: <Widget>[
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: Text('OK'),
              ),
            ],
          );
        },
      );
      print(error);
    }
    // Check the response status code.
    // if (response.statusCode == 200) {
    //   // Print the response body.
    //   print(jsonEncode(response.data));
    // } else {
    //   // Print an error message.
    //   print('Failed to post data: ${response.statusCode}');
  }

  Future<void> PostEndData(BuildContext context, firebase_id, currentService,
      addressresult, selectedravelMode, currentTime, amount, filepath) async {
    final addresSResult =
        Provider.of<LocationProvider>(context, listen: false).address;
    final selectedTarvelMode =
        Provider.of<LocationProvider>(context, listen: false).selectedTravelMode;
    final amountcontroller = Provider.of<LocationProvider>(context, listen: false).amountController;
    final curretService =
        Provider.of<LocationProvider>(context, listen: false).currentService;

    final dio = Dio();

    final formData = FormData.fromMap({
      "firebase_id": firebase_id,
      "service_id": curretService!.id??"id not found",
      "geolocation": addresSResult ?? "Address Not Accesible",
      "travel_mode": selectedTarvelMode ?? "error",
      "date_time": currentTime,
      "amount": amountcontroller ?? "not added",
      "image": filepath != null
          ? await MultipartFile.fromFile(filepath, //change this'filepath'
              filename: 'image')
          : null,
    });
    print(firebase_id);
    print(currentService.id);
    print(addresSResult ?? "address not found");
    print(selectedTarvelMode);
    print(currentTime);
    print(amountcontroller);
    print(filepath ?? "image not loaded");
    // Post the form data to the API.

    // final response = await dio.post(
    //   'https://antes.meduco.in/api/end_service_journey',
    //   data: formData,
    // );
    // print(response.statusCode);
    try {
      final response = await dio.post(
        'https://antes.meduco.in/api/end_service_journey',
        data: formData,
      );
      print(response.statusCode);
      print(jsonEncode(response.data));
    } catch (error) {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Error'),
            content: Text(error.toString()),
            actions: <Widget>[
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: Text('OK'),
              ),
            ],
          );
        },
      );
      print(error);
    }

    // // Check the response status code.
    // if (response.statusCode == 200) {
    //   // Print the response body.
    //    print(jsonEncode(response.data));
    // } else {
    //   // Print an error message.
    //   print('Failed to post data: ${response.statusCode}');
    // }
  }

  Future<void> PostEndService(BuildContext context, firebase_id, count,
      addressresult, currentTime) async {
    // Get the current address result from the LocationProvider.
    // Get the current address result from the LocationProvider.
    final addresSResult =
        Provider.of<LocationProvider>(context, listen: false).address;
    final curretService =
        Provider.of<LocationProvider>(context, listen: false).currentService;
//     final prefs = await SharedPreferences.getInstance();
// // ignore: unused_local_variable
//     String? Firebase_Id = prefs.getString('Firebase_Id');
    // Create a Dio client.
    final dio = Dio();
    // Create a FormData object.
    final formData = FormData.fromMap({
      "firebase_id": firebase_id,
      "service_id": curretService!.id,
      "geolocation": addresSResult ?? "Address Not Found",
      "date_time": currentTime,
    });
    print(firebase_id);
    print(addresSResult);
    print(curretService.id);
    print(currentTime);

    // Post the form data to the API.

    final response = await dio.post(
      'https://antes.meduco.in/api/complete_service',
      data: formData,
    );
    print(response.statusCode);
    print(jsonEncode(response.data));
    // Check the response status code.
    if (response.statusCode == 200) {
      // Print the response body.
      //  print(response.body);
    } else {
      // Print an error message.
      print('Failed to post data: ${response.statusCode}');
    }
  }
}
