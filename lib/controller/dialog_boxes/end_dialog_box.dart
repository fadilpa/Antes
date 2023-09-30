import 'dart:io';
import 'package:flutter/material.dart';
import 'package:mentegoz_technologies/api/journey_api.dart';
import 'package:mentegoz_technologies/controller/Provider/location_provider.dart';
import 'package:mentegoz_technologies/controller/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

Future<void> endDialogBox(BuildContext context) async {
  File? filepath;
  // String? selectedTravelMode;

  String? currentTime = DateTime.now().toString();
  File? image;
  final curretnService =
      Provider.of<LocationProvider>(context, listen: false).currentService;
  TextEditingController AmountController = TextEditingController();
  final amountcontroller = context.read<LocationProvider>().amountController;
  // String amount = AmountController.text;
  final addressresult = context.read<LocationProvider>().address;
  final selectedTarvelMode =
      context.read<LocationProvider>().selectedTravelMode;
  bool journeyStatus = curretnService?.journeyStarted ?? false;
  bool isButtonTapped = false; // Initially, assume the button is not tapped
  bool journeyStarted =
      Provider.of<LocationProvider>(context, listen: false).journeyStarted;
  bool isLoading =
      Provider.of<LocationProvider>(context, listen: false).loaderStarted;

  if (journeyStarted == false) {
    await showDialog(
      context: context,
      builder: (context) {
        return Consumer<LocationProvider>(builder: (context, value, child) {
          return AlertDialog(
            title: Text("End Service"),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextField(
                  controller: AmountController,
                  onChanged: (value) {
                    Provider.of<LocationProvider>(context, listen: false)
                        .setAmount(value);
                  },
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
                        Provider.of<OpenCameraProvider>(context, listen: false)
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
                  value.updateLoader(true);
                  final prefs = await SharedPreferences.getInstance();
// ignore: unused_local_variable
                  String? Firebase_Id = prefs.getString('Firebase_Id');
                  // if (curretnService != null) {
                  //   curretnService.journeyStarted = false;
                  // }
                  print(journeyStatus);

                  await PostData().PostEndData(
                      context,
                      Firebase_Id,
                      curretnService,
                      addressresult,
                      selectedTarvelMode,
                      currentTime,
                      amountcontroller,
                      filepath);
                  // print(enddata);
                  Navigator.of(context).pop();

                  // isButtonTapped = false;
                  // await prefs.setBool('isButtonTapped', isButtonTapped);
                  print(isButtonTapped);
                  // print(journeyStatus);
                  print(journeyStarted);
                  Provider.of<LocationProvider>(context, listen: false)
      .updatejourneyStarted(false);
                  // final prefs = await SharedPreferences.getInstance();
                  // await prefs.setBool('isButtonTapped', false);
                  value.updateLoader(false);
                },
                child: Consumer<LocationProvider>(
                  builder: (context, state, child) {
                    return state.loaderStarted
                        ? CircularProgressIndicator()
                        : Text("End");
                  },
                ),
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
