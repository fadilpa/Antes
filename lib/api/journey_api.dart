import 'dart:convert';
import 'dart:io';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mentegoz_technologies/controller/Provider/location_provider.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;

class PostData {
  Future PostStartData(BuildContext context, firebase_id, currentService,
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
        'http://antesapp.com/api/start_service_journey',
        data: formData,
      );
      ScaffoldMessenger.of(context)
          .showSnackBar(const SnackBar(content: Text('Journey Succesfully Started!')));
      print(response.statusCode);
      print(jsonEncode(response.data));
       return response.statusCode;
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

  Future PostEndData(BuildContext context, firebase_id, currentService,
      addressresult, selectedravelMode, currentTime, amount, image) async {
    final addresSResult =
        Provider.of<LocationProvider>(context, listen: false).address;
    // final selectedTarvelMode =
    //     Provider.of<LocationProvider>(context, listen: false)
    //         .selectedTravelMode;
    final amountcontroller =
        Provider.of<LocationProvider>(context, listen: false).amountController;
    final curretService =
        Provider.of<LocationProvider>(context, listen: false).currentService;

    final dio = Dio();
    // var images= await dio.MultipartFile.from
    var bytes =
        (await rootBundle.load('assets/null.jpeg')).buffer.asUint8List();
    var mpFile = MultipartFile.fromBytes(bytes, filename: 'image.jpeg');

    final formData = FormData.fromMap({
      "firebase_id": firebase_id,
      "service_id": curretService!.id ?? "id not found",
      "geolocation": addresSResult ?? "Address Not Accesible",
      "travel_mode": selectedravelMode ?? "No Options",
      "date_time": currentTime,
      "amount": amountcontroller ?? "not added",
      "image": image != null
          ? await MultipartFile.fromFile(image.toString(),
              filename: 'image.png' //change this'filepath'
              )
          : mpFile,
    });
    print(firebase_id);
    print(currentService.id);
    print(addresSResult ?? "address not found");
    print(selectedravelMode);
    print(currentTime);
    print(amountcontroller);
    print(image);

    try {
      final response = await dio.post(
        'http://antesapp.com/api/end_service_journey',
        data: formData,

        // options: Options(
        //   receiveTimeout: Duration(seconds: 5), // 30 seconds
        //   sendTimeout: Duration(seconds: 5), // 30 seconds
        // ),
      );
      ScaffoldMessenger.of(context)
          .showSnackBar(const SnackBar(content: Text('Journey Successfully Ended!')));

      print(response.statusCode);
      print(jsonEncode(response.data));
      return response.statusCode;
    } catch (error) {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Error'),
            content: Text('Unknown Error Ocuured!'.toString()),
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
      
      // print(error);
    }
    
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
      'http://antesapp.com/api/complete_service',
      data: formData,
    );
    print(response.statusCode);
    print(jsonEncode(response.data));
    // Check the response status code.
    if (response.statusCode == 200) {
      ScaffoldMessenger.of(context)
          .showSnackBar(const SnackBar(content: Text('Service Ended Succesfully!')));
    } else {
      ScaffoldMessenger.of(context)
          .showSnackBar(const SnackBar(content: Text('Check Your Internet')));
      throw Exception();
      // print('Failed to post data: ${response.statusCode}');
    }
  }
}
