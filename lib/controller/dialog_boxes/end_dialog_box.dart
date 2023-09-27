import 'package:flutter/material.dart';
import 'package:mentegoz_technologies/controller/Provider/location_provider.dart';
import 'package:mentegoz_technologies/controller/api/journey_api.dart';
import 'package:mentegoz_technologies/controller/image_picker.dart';
import 'package:mentegoz_technologies/controller/varibles.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

Future<void> endDialogBox(BuildContext context) async {
  bool isButtonTapped = false; // Initially, assume the button is not tapped
  bool journeyStarted =
      Provider.of<LocationProvider>(context, listen: false).journeyStarted;
  if (journeyStarted) {
    await showDialog(
      context: context,
      builder: (BuildContext context) {
        return Consumer<LocationProvider>(builder: (context, value, child) {
          return AlertDialog(
            title: Text("End Service"),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextField(
                  decoration: InputDecoration(
                    labelText: "Enter Amount",
                  ),
                ),
                TextField(
                  decoration: InputDecoration(
                    labelText: "Upload Bill",
                    suffixIcon: IconButton(
                      icon: Icon(Icons.camera_alt),
                      onPressed: () async {
                        Provider.of<OpenCameraProvider>(context)
                            .openImagePicker();
                      },
                    ),
                  ),
                ),
              ],
            ),
            actions: <Widget>[
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: Text("Back"),
              ),
              TextButton(
                onPressed: () async {
                  final prefs = await SharedPreferences.getInstance();
// ignore: unused_local_variable
                  String? Firebase_Id = prefs.getString('Firebase_Id');
                  await value.getLocationAndAddress();
                  value.updatejourneyStarted(false);
                 
                  enddata = {
                    "firebase_id": Firebase_Id,
                    "service_id": "Service ",
                    "geolocation": addressResult,
                    "travel_mode": 'selectedTravelMode',
                    "date_time": 'currentTime',
                  };
                  
                  await PostData().PostEndData(enddata);
                  print(enddata);
                  Navigator.of(context).pop();

                  isButtonTapped = true;
                  await prefs.setBool('isButtonTapped', isButtonTapped);
                },
                child: Text("End"),
              ),
            ],
          );
        });
      },
    );
  } else {
    // Journey hasn't started yet, show a message or take appropriate action.
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("Journey not started"),
          content: Text("Please start the journey before ending it."),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text("OK"),
            ),
          ],
        );
      },
    );
  }
}
