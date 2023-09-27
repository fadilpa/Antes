// import 'package:dio/dio.dart';
// import 'package:flutter_image_compress/flutter_image_compress.dart';
// import 'package:image_picker/image_picker.dart';
// import 'package:mentegoz_technologies/varibles.dart';
// import 'package:http/http.dart'as http;

// Future<void> pickImage(ImageSource source) async {
//   // final dio = Dio();
//     final pickedImage = await ImagePicker().pickImage(source: source);

//     if (pickedImage == null) {
//       // User canceled image selection
//       return;
//     }

//     setState(() {
//       _selectedImage = File(pickedImage.path);
//     });
//     // Check the size of the selected image
//     final imageSizeInBytes = _selectedImage!.lengthSync();
//     final double imageSizeInMb = imageSizeInBytes / (1024 * 1024);

//     if (imageSizeInBytes > 100) {
//       // Compress the image if it's larger than 1 MB
//       final compressedImage = await FlutterImageCompress.compressWithFile(
//         _selectedImage!.path,
//         quality: 70, // Adjust the quality as needed (0-100)
//       );

//       // Now, you can send the compressedImage to your API using an HTTP library like Dio or http.
//       // Make an HTTP POST request and attach the compressed image data.
//       try {
//         final response = await http.post(
//           Uri.parse(
//               'https://antes.meduco.in/api/upload_bill'), // Replace with your API endpoint
//           body: {
//             "firebase_id": "syuxKE42GTXQaZaZBdoUBwgTAfi1",
//             "service_id": "1",
//             "geolocation": "",
//             "category": "",
//             "option": "",
//             "description": "",
//             "date_time": "",
//             "amount": "",
//             "image": ""
//             // base64Encode(compressedImage!), // Convert to base64 if needed
//           },
//         );

//         if (response.statusCode == 200) {
//           // Image successfully uploaded, you can handle the response here
//         } else {
//           // Handle errors or issues with the API request
//           print('API request failed with status code: ${response.statusCode}');
//         }
//       } catch (error) {
//         // Handle exceptions or network errors
//         print('Error sending image to API: $error');
//       }
//     } else {
//       // Image is already below 1 MB, you can directly upload it.
//       // Send _selectedImage to your API.
//       try {
//         final response = await http.post(
//           Uri.parse(
//               'https://antes.meduco.in/api/upload_bill'), // Replace with your API endpoint
//           body: {
//             "firebase_id": "syuxKE42GTXQaZaZBdoUBwgTAfi1",
//             "service_id": 'Service 1',
//             "geolocation": addressResult,
//             "travel_mode": 'jvjjb',
//             "date_time": currentTime,
//             'image': MultipartFile.fromFile(_selectedImage,
//                 filename: 'image'),
//             // base64Encode(_selectedImage!
//             //     .readAsBytesSync()),

//             // Convert to base64 if needed
//           },
//         );

//         if (response.statusCode == 200) {
//           // Image successfully uploaded, you can handle the response here
//         } else {
//           // Handle errors or issues with the API request
//           print('API request failed with status code: ${response.statusCode}');
//         }
//       } catch (error) {
//         // Handle exceptions or network errors
//         print('Error sending image to API: $error');
//       }
//     }
//   }
