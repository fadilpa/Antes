
//   import 'package:flutter/material.dart';
// import 'package:shared_preferences/shared_preferences.dart';

// Future<void> showEndConfirmationDialog(BuildContext context) async {
//     final prefs = await SharedPreferences.getInstance();
// // ignore: unused_local_variable
//     String? Firebase_Id = prefs.getString('Firebase_Id');
//     int serbiceCount = 1;
//     // filepath;
//     showDialog(
//       context: context,
//       builder: (BuildContext context) {
//         return AlertDialog(
//           title: Text("End Journey"),
//           content: Text("Are you sure you want to end the journey?"),
//           actions: [
//             TextButton(
//               onPressed: () {
//                 Navigator.of(context).pop(); // Close the dialog
//               },
//               child: Text("Cancel"),
//             ),
//             TextButton(
//               onPressed: () async {},
//               child: Text("OK"),
//             ),
//           ],
//         );
//       },
//     );
//   }