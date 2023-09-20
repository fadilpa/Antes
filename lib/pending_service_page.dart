import 'package:geocode/geocode.dart';
import 'package:location/location.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mentegoz_technologies/api.dart';
import 'package:mentegoz_technologies/custom_button.dart';
import 'package:mentegoz_technologies/pendin_model.dart';
import 'package:mentegoz_technologies/ticketpage.dart';
import 'package:mentegoz_technologies/uploadedbill.dart';
import 'package:shared_preferences/shared_preferences.dart';

class PendingServicePage extends StatefulWidget {
   PendingServicePage(
      {super.key,
      required this.index,
      required this.clientName,
      this.refNo,
      this.category,
      this.startdate,
      this.enddate,
      this.servicename,
      this.endtime,
      this.starttime});

  final int index;
  final clientName;
  final refNo;
  final category;
  final startdate;
  final enddate;
  final servicename;
  final endtime;
  final starttime;

  @override
  State<PendingServicePage> createState() => _PendingServicePageState();
}

class _PendingServicePageState extends State<PendingServicePage> {
     String? name;
 String? number;
  LocationData? currentLocation;
  String address = "";
  bool journeyStarted = false;
  TimeOfDay currentTime = TimeOfDay.now();
  final geolocate = Geolocator();
  Future<Position> _determinePosition() async {
    bool serviceEnabled;
    LocationPermission permission;

    // Test if location services are enabled.
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      // Location services are not enabled don't continue
      // accessing the position and request users of the
      // App to enable the location services.
      return Future.error('Location services are disabled.');
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        // Permissions are denied, next time you could try
        // requesting permissions again (this is also where
        // Android's shouldShowRequestPermissionRationale
        // returned true. According to Android guidelines
        // your App should show an explanatory UI now.
        return Future.error('Location permissions are denied');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      // Permissions are denied forever, handle appropriately.
      return Future.error(
          'Location permissions are permanently denied, we cannot request permissions.');
    }

    // When we reach here, permissions are granted and we can
    // continue accessing the position of the device.
    return await Geolocator.getCurrentPosition();
  }

  double? latitude;
  double? longitide;

  Future<void> _getLocationAndAddress() async {
    Location location = Location();
    LocationData? locationData;
    String? addressResult;

    // Check if location service is enabled.
    bool serviceEnabled = await location.serviceEnabled();
    if (!serviceEnabled) {
      serviceEnabled = await location.requestService();
      if (!serviceEnabled) {
        // Handle if the user doesn't enable location services.
        return;
      }
    }

    // Check and request location permission.
    PermissionStatus permissionGranted = await location.hasPermission();
    if (permissionGranted == PermissionStatus.denied) {
      permissionGranted = await location.requestPermission();
      if (permissionGranted != PermissionStatus.granted) {
        // Handle if permission is not granted.
        return;
      }
    }

    // Get the user's location.
    locationData = await location.getLocation();

    // Get the address from the user's location.
    if (locationData != null) {
      GeoCode geoCode = GeoCode();
      Address result = await geoCode.reverseGeocoding(
        latitude: locationData.latitude!,
        longitude: locationData.longitude!,
      );
      addressResult =
          "${result.streetAddress}, ${result.city}, ${result.countryName}, ${result.postal}";
    }
    print(addressResult);
    //  the state with the location and address.
    setState(() {
      currentLocation = locationData;
      address = addressResult ?? "Address not available";
    });
  }

  final ImagePicker _picker = ImagePicker();

  Future<void> openCamera() async {
    final XFile? image = await _picker.pickImage(source: ImageSource.camera);
    if (image != null) {
      // Do something with the image
    }
  }

  // static Future<String?> pickUserDueTime(
  //   BuildContext context,
  // ) async {
  //   final TimeOfDay? picked = await showTimePicker(
  //     context: context,
  //     initialTime: TimeOfDay.now(),
  //     // onEntryModeChanged:
  //   );
  //   if (picked != null) {
  //     print('selected time$picked');
  //   }
  //   return "${picked?.format(context)}";
  // }

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
      await start_dialog(context);
    }
  }

  Future<dynamic> start_dialog(BuildContext context) {
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
                _getLocationAndAddress();
                currentTime;
                print(currentTime);
                setState(() {
                  journeyStarted = true;
                });
                Navigator.of(context).pop();
              },
              child: Text("Start"),
            ),
          ],
        );
      },
    );
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
                  _getLocationAndAddress();
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

    getusername_and_number() async {
    final prefs = await SharedPreferences.getInstance();
    name = prefs.getString('Name');
    number = prefs.getString('Mobile');
  }
@override
  void initState() {
    super.initState();
    getusername_and_number();
  }

  @override
  Widget build(BuildContext context) {
    // ignore: unused_local_variable
    List<Autogenerated> serviceData = [];

    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;

    return FutureBuilder<List<Autogenerated>>(
      
        future: fetchAlbum(), // Provide the correct firebaseId
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
                child:
                    CircularProgressIndicator()); // Show a loading indicator while fetching data
          } else if (snapshot.hasData) {
            // Data is available, update the serviceData variable
            serviceData = snapshot.data!;

            // Continue building your UI with the fetched data
            return SafeArea(
              child: Scaffold(
                body: NestedScrollView(
                  headerSliverBuilder:
                      (BuildContext context, bool innerBoxIsScrolled) {
                    return <Widget>[
                      SliverAppBar(
                        pinned: true,
                        floating: true,
                        expandedHeight: screenHeight * 0.13,
                        forceElevated: true,
                        elevation: 3,
                        backgroundColor: Colors.white,
                        flexibleSpace: FlexibleSpaceBar(
                          centerTitle: true,
                          title: Text(
                            "Services",
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 16.0,
                            ),
                          ),
                        ),
                        leading: IconButton(
                          icon: const Icon(
                            Icons.arrow_back_ios_outlined,
                            color: Colors.black,
                          ),
                          tooltip: 'Back',
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                        ),
                        actions: <Widget>[
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                   name??"User Name",
                                    style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 16,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                  Text(
                                  number??"NO Number",
                                    style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 16,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(
                                width: MediaQuery.of(context).size.width * 0.02,
                              ),
                              Padding(
                                padding:
                                    EdgeInsets.only(right: screenWidth / 30),
                                child: CircleAvatar(),
                              ),
                            ],
                          )
                        ],
                      ),
                    ];
                  },
                  body: Container(
                    height: screenHeight / 1,
                    width: screenWidth / 2,
                    color: Colors.transparent,
                    child: Padding(
                      padding: const EdgeInsets.only(left: 40),
                      child: Column(
                        // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(
                            height: screenHeight / 15,
                          ),
                          Text(
                            widget.servicename.toUpperCase() ??
                                "No Service Name".toUpperCase(),
                            style: GoogleFonts.montserrat(
                              fontSize: 20,
                              fontWeight: FontWeight.w600,
                              color: Colors.black,
                              decoration: TextDecoration.underline,
                            ),
                          ),
                          SizedBox(
                            height: screenHeight / 20,
                          ),
                          Row(
                            children: [
                              const Icon(
                                CupertinoIcons.person_solid,
                                color: Color.fromARGB(255, 60, 180, 229),
                              ),
                              SizedBox(
                                width: screenWidth / 50,
                              ),
                              Text(
                                widget.clientName.toUpperCase() ??
                                    "No Client Name".toUpperCase(),
                                style: GoogleFonts.montserrat(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w400,
                                    color: Colors.black),
                              )
                            ],
                          ),
                          SizedBox(
                            height: screenHeight / 20,
                          ),
                          Row(
                            children: [
                              const Icon(
                                CupertinoIcons.location_solid,
                                color: Color.fromARGB(255, 60, 180, 229),
                              ),
                              SizedBox(
                                width: screenWidth / 50,
                              ),
                              Text(
                                widget.refNo.toUpperCase() ??
                                    "No Referred".toUpperCase(),
                                style: GoogleFonts.montserrat(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w400,
                                    color: Colors.black),
                              )
                            ],
                          ),
                          SizedBox(
                            height: screenHeight / 20,
                          ),
                          Row(
                            children: [
                              const Icon(
                                CupertinoIcons.phone_fill,
                                color: Color.fromARGB(255, 60, 180, 229),
                              ),
                              SizedBox(
                                width: screenWidth / 50,
                              ),
                              Text(
                                widget.category.toUpperCase() ??
                                    "No Categorised".toUpperCase(),
                                style: GoogleFonts.montserrat(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w400,
                                    color: Colors.black),
                              )
                            ],
                          ),
                          SizedBox(
                            height: screenHeight / 20,
                          ),
                          Row(
                            children: [
                              const Icon(
                                Icons.access_time_filled_rounded,
                                color: Color.fromARGB(255, 60, 180, 229),
                              ),
                              SizedBox(
                                width: screenWidth / 50,
                              ),
                              Text(
                                (widget.startdate == null
                                        ? "Date Not Defined".toUpperCase()
                                        : widget.startdate) +
                                    (widget.starttime != null
                                        ? " (${widget.starttime})"
                                        : "Time Not Defined".toUpperCase()),
                                style: GoogleFonts.montserrat(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w400,
                                    color: Colors.black),
                              )
                            ],
                          ),
                          SizedBox(
                            height: screenHeight / 20,
                          ),
                          Row(
                            children: [
                              const Icon(
                                Icons.access_time_filled_rounded,
                                color: Color.fromARGB(255, 60, 180, 229),
                              ),
                              SizedBox(
                                width: screenWidth / 50,
                              ),
                              Text(
                                (widget.enddate == null
                                        ? "Date Not Defined".toUpperCase()
                                        : widget.enddate) +
                                    (widget.endtime != null
                                        ? " (${widget.endtime})"
                                        : "Time Not Defined".toUpperCase()),
                                style: GoogleFonts.montserrat(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w400,
                                    color: Colors.black),
                              )
                            ],
                          ),
                          SizedBox(
                            height: screenHeight / 15,
                          ),
                          Column(
                              // mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Row(
                                  children: [
                                    CustmButton(
                                        butoontext: 'Start Journey',
                                        buttonaction: () {
                                          showStartDialog(context);
                                        }),
                                    SizedBox(
                                      width: screenWidth / 50,
                                    ),
                                    CustmButton(
                                        butoontext: 'End Journey',
                                        buttonaction: () {
                                          endDialogBox(context);
                                        })
                                  ],
                                ),
                                SizedBox(
                                  height: screenHeight / 50,
                                ),
                                Row(
                                  children: [
                                    CustmButton(
                                        butoontext: 'Upload Bill',
                                        buttonaction: () {
                                          Navigator.of(context)
                                              .push(MaterialPageRoute(
                                            builder: (context) => UpLoadBill(),
                                          ));
                                        }),
                                    SizedBox(
                                      width: screenWidth / 50,
                                    ),
                                    CustmButton(
                                        butoontext: 'Raise a Ticket',
                                        buttonaction: () {
                                          Navigator.of(context)
                                              .push(MaterialPageRoute(
                                            builder: (context) =>
                                                RaisedTicket(),
                                          ));
                                        })
                                  ],
                                ),
                              ])
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            );
          }
          return Container(
            color: Colors.amber,
          );
        });
  }
}
