import 'package:flutter/material.dart';
import 'package:mentegoz_technologies/open_camera.dart';
import 'package:mentegoz_technologies/start_journey_function.dart';

class EndJourney extends StatefulWidget {
  const EndJourney({super.key});

  @override
  State<EndJourney> createState() => EndJourneyState();
}

class EndJourneyState extends State<EndJourney> {
  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }

  Future<void> endDialogBox(BuildContext context) async {
    if (journeyStarted) {
      await showDialog(
        context: context,
        builder: (BuildContext context) {
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
                        openCamera();
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
                onPressed: () {
                  currentTime;
                  print(currentTime.toString());
                  Navigator.of(context).pop();
                  setState(() {
                    journeyStarted =
                        false; // Journey has ended, enable "Start" button
                  });
                },
                child: Text("End"),
              ),
            ],
          );
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
}
