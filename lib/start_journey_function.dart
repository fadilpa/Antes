  import 'package:flutter/material.dart';
  TimeOfDay currentTime = TimeOfDay.now();
  bool journeyStarted = false;

Future<void> showStartDialog(BuildContext context) async {
  
    if (journeyStarted) {
      // Show a dialog indicating that an ongoing journey is not ended.
      await showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text("Ongoing Journey"),
            content: Text(
                "Please end the ongoing journey before starting a new one."),
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
      // Show the regular start journey dialog if no journey is in progress.
      
    return showDialog(
      context: context,
      builder: (BuildContext context) {
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
                  // Handle dropdown value change if needed
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
                // Start a new journey here
                // getLocationAndAddress();
                
                currentTime;
                print(currentTime);
                journeyStarted=true;
                Navigator.of(context).pop();
              },
              child: Text("Start"),
            ),
          ],
        );
      },
    );
  }
}