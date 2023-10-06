//   import 'package:flutter/material.dart';
// import 'package:image_picker/image_picker.dart';

// Future<void> showImageSourceDialog(BuildContext context) async {
//     return showDialog<void>(
//       context: context,
//       builder: (BuildContext context) {
//         return AlertDialog(
//           title: const Text('Select Image Source'),
//           actions: <Widget>[
//             TextButton(
//               onPressed: () async {
//                 Navigator.of(context).pop();
//                 final pickedImage = await ImagePicker().pickImage(
//                   source: ImageSource.camera,
//                 );
//                 // Handle the selected image from the camera
//                 if (pickedImage != null) {
//                   final imagebytes = await pickedImage.readAsBytes();
//                   // setState(() {
//                   //   image = File(pickedImage.path);
//                   // });
//                   // Process the image here

//                   // Once processing is successful, set the flag to true
//                   // setState(() {
//                   //   isTicketSubmitted = true;
//                   // });
//                 }
//               },
//               child: const Text('Camera'),
//             ),
//             TextButton(
//               onPressed: () async {
//                 Navigator.of(context).pop();
//                 final pickedImage = await ImagePicker().pickImage(
//                   source: ImageSource.gallery,
//                 );
//                 // Handle the selected image from the gallery
//                 if (pickedImage != null) {
//                   final imagebytes = await pickedImage.readAsBytes();

//                   // Process the image here
//                 }
//               },
//               child: const Text('Gallery'),
//             ),
//           ],
//         );
//       },
//     );
//   }