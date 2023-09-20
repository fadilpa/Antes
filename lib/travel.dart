// import 'package:camera/camera.dart';
// import 'package:flutter/material.dart';
// import 'package:image_picker/image_picker.dart';


// class StartButtom extends StatefulWidget {
//   @override
//   _StartButtomState createState() => _StartButtomState();
// }

// class _StartButtomState extends State<StartButtom> {
//   // Declare variables to store the user's input
//   String? textInput;
//   double? latitude;
//   double? longitude;
//   String? dropDownValue;
//   DateTime? selectedTime;
//   List<CameraDescription> cameras = [];


//   Future<void> _openCamera() async {
//     if (cameras.isNotEmpty) {
//       final CameraController controller = CameraController(
//         cameras[0], // Use the first available camera
//         ResolutionPreset.medium,
//       );
//       await controller.initialize();
//       final XFile photo = await controller.takePicture();
//       await controller.dispose(); // Dispose of the camera controller
//     }
//   }

// // Future<void> getCurrentLocation() async {
// //   // Get the user's location
// //   final LocationData locationData = await location.getLocation();

// //   // TODO: Implement code to handle the user's location
// // }



// Future<void> selectTime() async {
//   // Show a time picker dialog
//   final TimeOfDay? timeOfDay = await showTimePicker(
//     context: context,
//     initialTime: TimeOfDay.now(),
//   );

//   // TODO: Implement code to handle the selected time
// }


//   @override
//   Widget build(BuildContext context) {
//     return AlertDialog(
//       title: Text('Dialog Box'),
//       content: Column(
//         mainAxisSize: MainAxisSize.min,
//         children: [
//           // Text field with camera icon
//           TextField(
//             decoration: InputDecoration(
//               hintText: 'Enter some text',
//               prefixIcon: IconButton(
//                 icon: Icon(Icons.camera),
//                 onPressed: _openCamera,
//               ),
//             ),
//             onChanged: (value) {
//               textInput = value;
//             },
//           ),

//           // Button to get the user's current location
//           SizedBox(height: 10),
//           ElevatedButton(
//             onPressed: (){

//             },
//             // onPressed: getCurrentLocation,
//             child: Text('Get Current Location'),
//           ),

//           // Drop-down button with four values
//           SizedBox(height: 10),
//           DropdownButton<String>(
//             value: dropDownValue,
//             onChanged: (value) {
//               setState(() {
//                 dropDownValue = value;
//               });
//             },
//             items: [
//               DropdownMenuItem(
//                 child: Text('Train'),
//                 value: 'value1',
//               ),
//               DropdownMenuItem(
//                 child: Text('Bus'),
//                 value: 'value2',
//               ),
//               DropdownMenuItem(
//                 child: Text('Bike'),
//                 value: 'value3',
//               ),
//               DropdownMenuItem(
//                 child: Text('Car'),
//                 value: 'value4',
//               ),
//             ],
//           ),

//           // Button to select the time
//           SizedBox(height: 10),
//           ElevatedButton(
//             onPressed: selectTime,
//             child: Text('Select Time'),
//           ),
//         ],
//       ),
//       actions: [
//         // Button to close the dialog box
//         TextButton(
//           onPressed: () => Navigator.pop(context),
//           child: Text('Cancel'),
//         ),

//         // Button to submit the user's input
//         TextButton(
//           onPressed: () {
//             // TODO: Implement submit functionality
//           },
//           child: Text('Submit'),
//         ),
//       ],
//     );
//   }
// }
