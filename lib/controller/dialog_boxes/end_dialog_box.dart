import 'dart:io';
import 'package:flutter/material.dart';
import 'package:mentegoz_technologies/api/journey_api.dart';
import 'package:mentegoz_technologies/controller/Provider/image_picker_provider.dart';
import 'package:mentegoz_technologies/controller/Provider/location_provider.dart';
import 'package:mentegoz_technologies/controller/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

Future<void> endDialogBox(BuildContext context, Saved_Id, Current_Id) async {
  final _formKey = GlobalKey<FormState>();
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

  if (Current_Id == Saved_Id) {
    await showDialog(
      context: context,
      builder: (context) {
        return Consumer<LocationProvider>(builder: (context, value, child) {
          return AlertDialog(
            title: Text("End Service"),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Form(
                  key: _formKey,
                  child: TextFormField(
                    validator: (value) =>
                        value!.isEmpty ? '*Required' : null,
                    keyboardType: TextInputType.number,
                    controller: AmountController,
                    onChanged: (value) {
                      Provider.of<LocationProvider>(context, listen: false)
                          .setAmount(value);
                    },
                    decoration: InputDecoration(
                      labelText: "Enter Amount",
                      enabledBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.black)),
                      focusedBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.black)),
                      errorBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.black)),
                    ),
                  ),
                ),
                SizedBox(height: MediaQuery.of(context).size.height/20,),
                TextField(
                  decoration: InputDecoration(
                      labelText: "Upload Bill",
                      enabledBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.black)),
                      focusedBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.black)),
                      suffixIcon: SizedBox(
                        width: 100,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Provider.of<OpenCameraProvider>(
                                      context,
                                    ).image !=
                                    null
                                ? Image.file(
                                    Provider.of<OpenCameraProvider>(
                                      context,
                                    ).image!,
                                    height: 45,
                                  )
                                : SizedBox(),
                            IconButton(
                              icon: Icon(Icons.camera_alt),
                              onPressed: () async {
                                Provider.of<OpenCameraProvider>(context,
                                        listen: false)
                                    .openImagePicker();
                              },
                            ),
                          ],
                        ),
                      )),
                ),
              ],
            ),
            // Image.file( Provider.of<OpenCameraProvider>(context).image!,width: 50,
            //             ),
            actions: <Widget>[
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: Text("Back"),
              ),
              TextButton(
                onPressed: () async {
                   
                  if (_formKey.currentState!.validate()) {
                    value.updateLoader(true, context);
                    final prefs = await SharedPreferences.getInstance();
                    String? Firebase_Id = prefs.getString('Firebase_Id');
                    print(journeyStatus);

                    print(curretnService!.id);
                    print('wwwwwwwwwwwwwwwwwwwwwwwwwwwwww');
                    var selectedTarvelMode1 = await prefs
                        .getString('travel_mode-${curretnService!.id}');
                    print(selectedTarvelMode1);
                    var status = await PostData().PostEndData(
                      context,
                      Firebase_Id,
                      curretnService,
                      addressresult,
                      selectedTarvelMode1,
                      currentTime,
                      amountcontroller,
                      Provider.of<OpenCameraProvider>(context, listen: false)
                          .path,
                    );
                    // print(enddata);
                    if (status == 200) {
                      final prefs = await SharedPreferences.getInstance();
                      prefs.setBool('isStarted', false);
                      prefs.remove('SavedId');
                    }

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
                    value.updateLoader(false, context);
                  }
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
