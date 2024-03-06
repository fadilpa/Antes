import 'package:flutter/material.dart';
import 'package:mentegoz_technologies/api/journey_api.dart';
import 'package:mentegoz_technologies/controller/Provider/image_picker_provider.dart';
import 'package:mentegoz_technologies/controller/Provider/location_provider.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

Future<void> showStartDialog(
    BuildContext context, bool? journeyStarted, StartedId) async {
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
  if (journeyStarted == true) {
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
        final _formKey = GlobalKey<FormState>();

        return Consumer<LocationProvider>(builder: (context, value, child) {
          return AlertDialog(
            title: Text("Start Journey"),
            content: Form(
              key: _formKey,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  SizedBox(height: 16.0),
                  Text("Select your travel mode:"),
                  SizedBox(height: 8),
                  DropdownButtonFormField(
                    
                    // value: Provider.of<LocationProvider>(context, listen: false)
                    // .selectedTravelMode,
                    // decoration:
                    //  validator: (value) => value == null ? 'field required' : null,
                    items: <String>[
                      "Bike",
                      "Bus",
                      "Train",
                      "Other"
                    ].map<DropdownMenuItem<String>>((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(value),
                      );
                    }).toList(),
                    validator: (value) => value == null ? 'required' : null,
                    onChanged: (value) {
                      
                      value;
                      Provider.of<LocationProvider>(context, listen: false)
                          .setTravelMode(value, StartedId);
                          
                    },
                    decoration: InputDecoration(
                      enabledBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.black)),
                      focusedBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.black)),
                      errorBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.black)),
                    ),
                  ),
                  // Provider.of<LocationProvider>(context, listen: false)
                  //         .travelModeRequiredError
                  //     ? Text(
                  //         'Required',
                  //         style: TextStyle(color: Colors.red, fontSize: 12),
                  //       )
                  //     : SizedBox(),
                  SizedBox(height: 10,),
                    TextField(
                  decoration: InputDecoration(
                      labelText: "Upload Image",
                      enabledBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.black)),
                      focusedBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.black)),
                      errorBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.black)),
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
                crossAxisAlignment: CrossAxisAlignment.start,
              ),
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
                  if (_formKey.currentState!.validate()) {
                    value.updateLoader(true, context);
                    final prefs = await SharedPreferences.getInstance();
                    String? Firebase_Id = prefs.getString('Firebase_Id');
                    // prefs.setBool('isStarted', true);

// ignore: unused
                    value.getLocationAndAddress();

                    // if (curretService != null) {
                    //   curretService.journeyStarted = true;
                    // }

                    var status = await PostData().PostStartData(
                        context,
                        Firebase_Id,
                        curretService,
                        addresSResult,
                        Provider.of<LocationProvider>(context, listen: false)
                            .selectedTravelMode,
                        currentTime,  Provider.of<OpenCameraProvider>(context, listen: false)
                          .path);
                    if (status == 200) {
                      final prefs = await SharedPreferences.getInstance();
                      prefs.setBool('isStarted', true);
                      prefs.setInt('SavedId', StartedId);
                    }
                    // print(startdata);
                    Navigator.of(context).pop();

                    print(journeyStarted);
                    Provider.of<LocationProvider>(context, listen: false)
                        .updatejourneyStarted(true);
                    await Provider.of<LocationProvider>(context, listen: false)
                        .setTravelMode(
                            Provider.of<LocationProvider>(context,
                                    listen: false)
                                .selectedTravelMode,
                            StartedId);
                             Provider.of<OpenCameraProvider>(context, listen: false).emptyImage();
                    // final prefs = await SharedPreferences.getInstance();
                    // await prefs.setBool('isButtonTapped', true);
                    value.updateLoader(false, context);
                  }
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
