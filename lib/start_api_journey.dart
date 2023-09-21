import 'dart:io';
import 'package:dio/dio.dart';


class PostData {
  Future<void> postData(data,selectedTravelMode) async {
    // SharedPreferences prefs = await SharedPreferences.getInstance();
    // final firebaseId = prefs.getString('Firebase_id');
    final dio = Dio();
    final url = 'https://antes.meduco.in/api/start_service_journey';

    // final formdata = FormData.fromMap({
    //   "firebase_id": firebaseId.toString(),
    //   "service_id": 'Service 1',
    //   "geolocation":addressResult.toString(),
    //   "travel_mode": selectedTravelMode.toString(),
    //   "date_time": TimeOfDay.now().toString(),
    // });

    try {
      final response = await dio.post(
        url,
        data: data,
      );

      if (response.statusCode == 200) {
        // print('Data posted successfully');
        print(response.data); // Use response.data instead of response.body
      } else {
        print('Failed to post data: ${response.statusCode}');
      }
    } catch (e) {
      print('Error: $e');
    }
  }

  Future<void> postEndData(data) async {
    // SharedPreferences prefs = await SharedPreferences.getInstance();
    // final firebaseId = prefs.getString('Firebase_id');
    File? _selectedImage;
    final dio = Dio();
    final url = 'https://antes.meduco.in/api/end_service_journey';

    // final formdata = FormData.fromMap({
    //   "firebase_id": firebaseId,
    //   "service_id": 'Service ',
    //   "geolocation": addressResult,
    //   "travel_mode":travel_mode,
    //   "date_time": TimeOfDay.now().toString(),
    //   "amount": '53',
    //   'image': MultipartFile.fromFile(image.toString(), filename: 'image'),
    // });

    try {
      final response = await dio.post(
        url,
        data: data, // Use the data parameter for the request body
        
      );
      print(data);

      if (response.statusCode == 200) {
        // print('Data posted successfully');
        print(response.data); // Use response.data instead of response.body
      } else {
        print('Failed to post data: ${response.statusCode}');
      }
    } catch (e) {
      print('Error: $e');
    }
  }
}
