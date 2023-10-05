import 'package:flutter/material.dart';
import 'package:mentegoz_technologies/api/journey_api.dart';
import 'package:mentegoz_technologies/controller/Provider/location_provider.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

Future<void> showStartDialog(BuildContext context,bool? journeyStarted,StartedId) async {
  // int count = 1;
  String? currentTime = DateTime.now().toString();
  // final selectedTarvelMode =
  //     context.read<LocationProvider>().selectedTravelMode;
  final curretService =
      Provider.of<LocationProvider>(context, listen: false).currentService;
  final addresSResult = context.read<LocationProvider>().address;
  
  // bool journeyStatus = curretService?.journeyStarted ?? false;
  bool isButtonTapped = false; // Initially, assume the button is not tapped
  // bool journeyStarted =
  //     Provider.of<LocationProvider>(context, listen: false).journeyStarted;
  final isLoading =
      Provider.of<LocationProvider>(context, listen: false).loaderStarted;
  print(journeyStarted);
  print('%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%');
  if (journeyStarted ==true) {
    // Show a dialog indicating that an ongoing journey is not ended.
    await showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("Ongoing Journey"),
          content:
              Text("Please end the ongoing journey before starting a new one."),
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
  } else {
    return showDialog(
      context: context,
      builder: (BuildContext context) {
        return Consumer<LocationProvider>(builder: (context, value, child) {
          return AlertDialog(
            title: Text("Start Service"),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                SizedBox(height: 16.0),
                Text("Select your travel mode:"),
                SizedBox(height: 8),
                DropdownButtonFormField(
                  // decoration:

                  items: <String>[
                    "Bike",
                    "Taxi Autorickshoaw",
                    "Taxi Car",
                    "Bus",
                    "Train",
                    "Other"
                  ].map<DropdownMenuItem<String>>((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    );
                  }).toList(),
                  onChanged: (value) {
                    value;
                    Provider.of<LocationProvider>(context, listen: false)
                        .setTravelMode(value);
                  },
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
                  value.updateLoader(true);
                  final prefs = await SharedPreferences.getInstance();
                  prefs.setBool('isStarted', true);
                  prefs.setInt('SavedId',StartedId );
// ignore: unused_local_variable
                  String? Firebase_Id = prefs.getString('Firebase_Id');
                  value.getLocationAndAddress();

                  // if (curretService != null) {
                  //   curretService.journeyStarted = true;
                  // }
                
                  await PostData().PostStartData(
                      context,
                      Firebase_Id,
                      curretService,
                      addresSResult,
                      Provider.of<LocationProvider>(context, listen: false)
                          .selectedTravelMode,
                      currentTime);
                  // print(startdata);
                  Navigator.of(context).pop();
             
                  print(journeyStarted);
                  Provider.of<LocationProvider>(context, listen: false)
                      .updatejourneyStarted(true);
                  // final prefs = await SharedPreferences.getInstance();
                  // await prefs.setBool('isButtonTapped', true);
                  value.updateLoader(false);
                },
                child: Consumer<LocationProvider>(
                  builder: (context, state, child) {
                    return state.loaderStarted
                        ? CircularProgressIndicator()
                        : Text("Start");
                  },
                ),
              ),
            ],
          );
        });
      },
    );
  }
}
