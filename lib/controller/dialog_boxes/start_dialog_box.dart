import 'package:flutter/material.dart';
import 'package:mentegoz_technologies/api/journey_api.dart';
import 'package:mentegoz_technologies/controller/Provider/location_provider.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

Future<void> showStartDialog(BuildContext context) async {
  // int count = 1;
  String? currentTime = DateTime.now().toString();
  // final selectedTarvelMode =
  //     context.read<LocationProvider>().selectedTravelMode;
final curretService = Provider.of<LocationProvider>(context,listen: false).currentService;
  final addressresult = context.read<LocationProvider>().address;
  bool isButtonTapped = false; // Initially, assume the button is not tapped

  bool journeyStarted =
      Provider.of<LocationProvider>(context, listen: false).journeyStarted;
  print(journeyStarted);
  if (journeyStarted) {
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
                  items: <String>[
                    "Train",
                    "Bus",
                    "Bike",
                    "Car",
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
                  final prefs = await SharedPreferences.getInstance();
// ignore: unused_local_variable
                  String? Firebase_Id = prefs.getString('Firebase_Id');

                  value.getLocationAndAddress();
                  value.updatejourneyStarted(true);

                  await PostData().PostStartData(
                      context,
                      Firebase_Id,
                      curretService,
                      addressresult,
                      Provider.of<LocationProvider>(context, listen: false)
                          .selectedTravelMode,
                      currentTime);
                  // print(startdata);
                  Navigator.of(context).pop();

                  // isButtonTapped = true;
                  // await prefs.setBool('isButtonTapped', isButtonTapped);
                },
                child: Text("Start"),
              ),
            ],
          );
        });
      },
    );
  }
}
