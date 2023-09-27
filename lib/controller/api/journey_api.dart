import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:http/http.dart' as http;

class PostData {
Future<void> PostStartData(startdata) async {
  // Create a Dio client.
  final dio = Dio();

  // Create a FormData object.
  final formData = FormData.fromMap(startdata);

  // Post the form data to the API.
  final response = await dio.post(
    'https://antes.meduco.in/api/start_service_journey',
    data: formData,
    
  );print(formData);

  // Check the response status code.
  if (response.statusCode == 200) {
    // Print the response body.
    print(jsonDecode(response.data));
  } else {
    // Print an error message.
    print('Failed to post data: ${response.statusCode}');
  }
}
  Future<void> PostEndData(enddata) async {
    final response = await http.post(
        Uri.parse('https://antes.meduco.in/api/end_service_journey'),
        body: jsonDecode(enddata));

    if (response.statusCode == 200) {
      print(jsonDecode(response.body));
    } else {
      print('Failed to post data: ${response.statusCode}');
    }
  }

  Future<void> PostEndService(endservice) async {
    final response = await http.post(
      Uri.parse('https://antes.meduco.in/api/complete_service'),
      body: jsonEncode(endservice),
    );

    if (response.statusCode == 200) {
      print(jsonDecode(response.body));
    } else {
      print('Failed to post data: ${response.statusCode}');
    }
  }
}
