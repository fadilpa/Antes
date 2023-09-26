// import 'dart:io';
// import 'package:flutter/material.dart';
// import 'package:mentegoz_technologies/Provider/start_journey_provider.dart';
// import 'package:mentegoz_technologies/Provider/image_picker_provider.dart';
// import 'package:mentegoz_technologies/Provider/location_provider.dart';
// import 'package:mentegoz_technologies/pending_service_page.dart';
// import 'package:mentegoz_technologies/start_api_journey.dart';
// import 'package:mentegoz_technologies/start_journey_function.dart';
// import 'package:mentegoz_technologies/ticketpage.dart';
// import 'package:provider/provider.dart';
// import 'package:shared_preferences/shared_preferences.dart';
// import 'package:dio/dio.dart';

// TextEditingController AmountController = TextEditingController();

// class EndDialogBox extends ChangeNotifier {
//   Future<void> endDialogBox(BuildContext context) async {
//     var  filepath;
//     final prefs = await SharedPreferences.getInstance();
//     // ignore: unused_local_variable
//     String? Firebase_Id = prefs.getString('Firebase_Id');
//     final journeyStateProvider = Provider.of<JourneyStateProvider>(context);

//     if (journeyStateProvider.journeyStarted) {
//       await showDialog(
//         context: context,
//         builder: (BuildContext context) {
//           return AlertDialog(
//             title: Text("End Service"),
//             content: Column(
//               mainAxisSize: MainAxisSize.min,
//               children: [
//                 TextField(
//                   controller: AmountController,
//                   decoration: InputDecoration(
//                     labelText: "Enter Amount",
//                   ),
//                 ),
//                 TextField(
//                   decoration: InputDecoration(
//                     labelText: "Upload Bill",
//                     suffixIcon: IconButton(
//                       icon: Icon(Icons.camera_alt),
//                       onPressed: () async {
//                         await Provider.of<OpenCameraProvider>(context,
//                                 listen: false)
//                             .openImagePicker();
//                       },
//                     ),
//                   ),
//                 ),
//               ],
//             ),
//             actions: <Widget>[
//               TextButton(
//                 onPressed: () {
//                   Navigator.of(context).pop();
//                 },
//                 child: Text("Back"),
//               ),
//               TextButton(
//                 onPressed: () async {
//                   await Provider.of<LocationProvider>(context, listen: false)
//                       .getLocationAndAddress();
//                   Navigator.of(context).pop(); // Close the dialog
//                   currentTime.toString();

//                   journeyStateProvider.setJourneyStarted(journeyStarted);
//                   datas = {
//                     "firebase_id": Firebase_Id,
//                     "service_id": 'Service',
//                     "geolocation": addressResult ?? "",
//                     "travel_mode": selectedTravelMode,
//                     "date_time": currentTime,
//                     "amount": 'Amount',
//                     'image': await MultipartFile.fromFile(filepath,
//                         filename: 'image'),
//                   };
//                   print(datas);

//                   await PostData().postEndData(
//                     datas,
//                     selectedTravelMode,
//                     AmountController.text,
//                     image!.path,
//                   );
//                 },
//                 child: Text("End"),
//               ),
//             ],
//           );
//         },
//       );
//     } else {
//       // Journey hasn't started yet, show a message or take appropriate action.
//       showDialog(
//         context: context,
//         builder: (BuildContext context) {
//           return AlertDialog(
//             title: const Text("Journey not started"),
//             content: const Text("Please start the journey before ending it."),
//             actions: <Widget>[
//               TextButton(
//                 onPressed: () {
//                   Navigator.of(context).pop();
//                 },
//                 child: Text("OK"),
//               ),
//             ],
//           );
//         },
//       );
//     }
//   }
// }
