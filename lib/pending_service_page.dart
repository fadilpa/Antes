import 'dart:io';

import 'package:dio/dio.dart';
import 'package:expand_widget/expand_widget.dart';
import 'package:geocode/geocode.dart';
// import 'package:http/http.dart';
import 'package:location/location.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mentegoz_technologies/api.dart';
import 'package:mentegoz_technologies/custom_button.dart';
import 'package:mentegoz_technologies/pendin_model.dart';
import 'package:mentegoz_technologies/start_api_journey.dart';
import 'package:mentegoz_technologies/ticketpage.dart';
import 'package:mentegoz_technologies/uploadedbill.dart';
import 'package:mentegoz_technologies/util/styles.dart';
import 'package:shared_preferences/shared_preferences.dart';

String? addressResult;

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
      this.starttime,
      this.Catgory,
      this.Landmark,
      this.Email,
      this.Address,
      this.Phone});

  final int index;
  final clientName;
  final refNo;
  final category;
  final startdate;
  final enddate;
  final servicename;
  final endtime;
  final starttime;
  final Catgory;
  final Landmark;
  final Email;
  final Address;
  final Phone;

  @override
  State<PendingServicePage> createState() => _PendingServicePageState();
}

class _PendingServicePageState extends State<PendingServicePage> {
  // StartJourneyState startjourney = StartJourneyState();
  // EndJourneyState endjourney = EndJourneyState();
  // LocateUserAddress locateuser = LocateUserAddress();

  String? name;
  String? number;
  LocationData? currentLocation;
  String address = "";
  bool journeyStarted = false;
  String currentTime = TimeOfDay.now().toString();
  final geolocate = Geolocator();
  var data = {};
  var datas = {};
  var enddata = {};
  String? selectedTravelMode;

  // Future<Position> _determinePosition() async {
  //   bool serviceEnabled;
  //   LocationPermission permission;

  //   // Test if location services are enabled.
  //   serviceEnabled = await Geolocator.isLocationServiceEnabled();
  //   if (!serviceEnabled) {
  //     // Location services are not enabled don't continue
  //     // accessing the position and request users of the
  //     // App to enable the location services.
  //     return Future.error('Location services are disabled.');
  //   }

  //   permission = await Geolocator.checkPermission();
  //   if (permission == LocationPermission.denied) {
  //     permission = await Geolocator.requestPermission();
  //     if (permission == LocationPermission.denied) {
  //       // Permissions are denied, next time you could try
  //       // requesting permissions again (this is also where
  //       // Android's shouldShowRequestPermissionRationale
  //       // returned true. According to Android guidelines
  //       // your App should show an explanatory UI now.
  //       return Future.error('Location permissions are denied');
  //     }
  //   }

  //   if (permission == LocationPermission.deniedForever) {
  //     // Permissions are denied forever, handle appropriately.
  //     return Future.error(
  //         'Location permissions are permanently denied, we cannot request permissions.');
  //   }

  //   // When we reach here, permissions are granted and we can
  //   // continue accessing the position of the device.
  //   return await Geolocator.getCurrentPosition();
  // }

  // double? latitude;
  // double? longitide;

  Future<void> getLocationAndAddress() async {
    Location location = Location();
    LocationData? locationData;

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
  File? _image;
  // Implementing the image picker
  Future<void> _openImagePicker() async {
    final XFile? pickedImage =
        await _picker.pickImage(source: ImageSource.camera);
    if (pickedImage != null) {
      final imageBytes = await pickedImage.readAsBytes();
      setState(() {
        _image = File(pickedImage.path);
      });
    }
  }

  // ignore: non_constant_identifier_names, prefer_typing_uninitialized_variables
  var serviceCount, filepath, Amount;
  TextEditingController AmountController = TextEditingController();

  final dio = Dio();
  Future UploadEndData(
    Firebase_Id,
    serviceCount,
    filepath,
  ) async {
    print('aaaaaaaaaaaaaaaaaaaaa');
    final prefs = await SharedPreferences.getInstance();
// ignore: unused_local_variable
    String? Firebase_Id = prefs.getString('Firebase_Id');
    // SharedPreferences prefs = await SharedPreferences.getInstance();
    // final firebaseId = prefs.getString('Firebase_Id');
    final formData = FormData.fromMap({
      "firebase_id": Firebase_Id,
      "service_id": 'Service $serviceCount',
      "geolocation": addressResult,
      "travel_mode": selectedTravelMode,
      "date_time": currentTime.toString(),
      "amount": Amount,
      'image': await MultipartFile.fromFile(filepath, filename: 'image'),
    });
    final response = await dio.post(
      'https://antes.meduco.in/api/end_service_journey',
      data: formData,
      // options: Options(headers: {'Authorization': 'Bearer $firebsaeId'}),
      // onSendProgress: (int sent, int total) {
      //   String percentage = (sent / total * 100).toStringAsFixed(2);
      // },
    );
    print(response.statusCode);
    // print('yyyyyyyyyyyyyy');
    if (response.statusCode == 200) {
      ScaffoldMessenger.of(context)
          .showSnackBar(const SnackBar(content: Text('Upload Succesful')));
    } else {
      ScaffoldMessenger.of(context)
          .showSnackBar(const SnackBar(content: Text('Check Your Internet')));
      throw Exception();
      // ignore: prefer_const_constructors
    }
  }

  Future UploadStartData() async {
    print('aaaaaaaaaaaaaaaaaaaaa');
    final prefs = await SharedPreferences.getInstance();
// ignore: unused_local_variable
    String? Firebase_Id = prefs.getString('Firebase_Id');
    final formData = FormData.fromMap({
      "firebase_id": Firebase_Id,
      "service_id": 'Service $serviceCount',
      "geolocation": addressResult,
      "travel_mode": selectedTravelMode,
      "date_time": currentTime.toString(),
    });
    final response = await dio.post(
      'https://antes.meduco.in/api/start_service_journey',
      data: formData,
      // options: Options(headers: {'Authorization': 'Bearer $firebaseId'}),
      // onSendProgress: (int sent, int total) {
      //   String percentage = (sent / total * 100).toStringAsFixed(2);
      // },
    );
    print(response.statusCode);
    // print('yyyyyyyyyyyyyy');
    if (response.statusCode == 200) {
      ScaffoldMessenger.of(context)
          .showSnackBar(const SnackBar(content: Text('Upload Succesful')));
    } else {
      ScaffoldMessenger.of(context)
          .showSnackBar(const SnackBar(content: Text('Check Your Internet')));
      throw Exception();
      // ignore: prefer_const_constructors
    }
  }

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

  Future<dynamic> start_dialog(BuildContext context) async {
    final prefs = await SharedPreferences.getInstance();
// ignore: unused_local_variable
    String? Firebase_Id = prefs.getString('Firebase_Id');
    int n = 1;
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
                  setState(() {
                    selectedTravelMode = value;
                  });
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
                // UploadStartData(Firebase_Id,selectedTravelMode,_image!.path);
                // Start a new journey here
                getLocationAndAddress();
                currentTime;
                data = {
                  "firebase_id": Firebase_Id,
                  "service_id": 'Service $n',
                  "geolocation": addressResult,
                  "travel_mode": selectedTravelMode,
                  "date_time": currentTime,
                };
                print(data);

                await PostData().postData(
                  data,
                  selectedTravelMode,
                );
                setState(() {
                  n++;
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

  Future<void> showEndConfirmationDialog(BuildContext context) async {
    final prefs = await SharedPreferences.getInstance();
// ignore: unused_local_variable
    String? Firebase_Id = prefs.getString('Firebase_Id');
    int serbiceCount = 1;
    // filepath;
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("End Journey"),
          content: Text("Are you sure you want to end the journey?"),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // Close the dialog
              },
              child: Text("Cancel"),
            ),
            TextButton(
              onPressed: () async {},
              child: Text("OK"),
            ),
          ],
        );
      },
    );
  }

  Future<void> endDialogBox(BuildContext context) async {
    final prefs = await SharedPreferences.getInstance();
// ignore: unused_local_variable
    String? Firebase_Id = prefs.getString('Firebase_Id');
    UpLoadBillState uploadbill = UpLoadBillState();
    int serbiceCount = 1;
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
                  controller: AmountController,
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
                        // uploadbill.pickImage(ImageSource.camera);
                        _openImagePicker();
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
                  getLocationAndAddress();
                  Navigator.of(context).pop(); // Close the dialog
                  currentTime.toString();
                  setState(() {
                    serbiceCount++;
                    journeyStarted =
                        false; // Journey has ended, enable "Start" button
                  });
                  datas = {
                    "firebase_id": Firebase_Id,
                    "service_id": 'Service $serbiceCount',
                    "geolocation": addressResult ?? "",
                    "travel_mode": selectedTravelMode,
                    "date_time": currentTime,
                    "amount": Amount,
                    'image': await MultipartFile.fromFile(filepath,
                        filename: 'image'),
                  };
                  print(datas);

                  await PostData().postEndData(
                    datas,
                    selectedTravelMode,
                    AmountController.text,
                    image!.path,
                  );
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
            title: const Text("Journey not started"),
            content: const Text("Please start the journey before ending it."),
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
    setState(() {
      name = prefs.getString('Name');
      number = prefs.getString('Mobile');
    });
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
                           captilaize( widget.servicename)??
                                    "No Service Name".toUpperCase(),
                            style:mainTextStyle.copyWith(fontWeight: FontWeight.w600,color: Colors.black,fontSize: 15),
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
                                    name!.split(' ').first ??
                                        "User Name",
                                    style: mainTextStyleBlack.copyWith(fontSize: 12,fontWeight: FontWeight.bold)
                                  ),
                                  Text(
                                    number ?? "Emp_no",
                                    style: TextStyle(
                                      color: Colors.black54,
                                      fontSize: 13,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(
                                width: MediaQuery.of(context).size.width / 30,
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
                  body: SingleChildScrollView(
                    child: Column(
                      
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                      height: 40,
                        ),
                        Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Padding(
                                padding:
                                    EdgeInsets.only(left: 30),
                                child: Text(
                                 captilaize( widget.servicename )??
                                      "No Service Name",
                                  style: mainTextStyleBlack.copyWith(fontWeight: FontWeight.w600,decoration: TextDecoration.underline),
                                ),
                              ),
                             
                              SizedBox(
                                height: screenHeight / 25,
                              ),
                              Padding(
                                padding:
                                    const EdgeInsets.only(left: 30),
                                child: Column(children: [
                                  Row(
                                    children: [
                                      const Icon(
                                        CupertinoIcons.person_solid,
                                        color:
                                            Color.fromARGB(255, 60, 180, 229),
                                      ),
                                      SizedBox(
                                        width: screenWidth / 50,
                                      ),
                                      Flexible(
                                        child: Text(
                                          widget.clientName ??
                                              "No Client Name".toUpperCase(),
                                          style:mainTextStyleBlack.copyWith(fontSize: 16)
                                        ),
                                      )
                                    ],
                                  ),
                                  SizedBox(
                                    height: screenHeight / 25,
                                  ),
                                  Row(
                                    children: [
                                      const Icon(
                                        Icons.location_on,
                                        color:
                                            Color.fromARGB(255, 60, 180, 229),
                                      ),
                                      SizedBox(
                                        width: screenWidth / 50,
                                      ),
                                      Flexible(
                                        child: Text(
                                          widget.Address ??
                                              "No Address added".toUpperCase(),
                                          style: mainTextStyleBlack.copyWith(fontSize: 16)
                                        ),
                                      )
                                    ],
                                  ),
                                  SizedBox(
                                    height: screenHeight / 25,
                                  ),
                                  Row(
                                    children: [
                                      const Icon(
                                       Icons.landscape,
                                        color:
                                            Color.fromARGB(255, 60, 180, 229),
                                      ),
                                      SizedBox(
                                        width: screenWidth / 50,
                                      ),
                                      Flexible(
                                        child: Text(
                                          widget.Phone ??
                                              "No Categorised",
                                          style: mainTextStyleBlack.copyWith(fontSize: 16)
                                        ),
                                      )
                                    ],
                                  ),
                                  SizedBox(
                                    height: screenHeight / 25,
                                  ),
                                  Row(
                                    children: [
                                      const Icon(
                                        CupertinoIcons.clock_fill,
                                        color:
                                            Color.fromARGB(255, 60, 180, 229),
                                      ),
                                      SizedBox(
                                        width: screenWidth / 50,
                                      ),
                                      Text(
                                        (widget.startdate == null
                                                ? "Date Not Defined"
                                                    .toUpperCase()
                                                : widget.startdate)+
                                            (widget.starttime != null
                                                ? ", ${widget.starttime}"
                                                : "Time Not Defined"
                                                    .toUpperCase()),
                                        style: mainTextStyleBlack.copyWith(fontSize: 16)
                                      )
                                    ],
                                  ),
                                  SizedBox(
                                    height: screenHeight / 25,
                                  ),
                                  Row(
                                    children: [
                                      const Icon(
                                          CupertinoIcons.clock_fill,
                                        color:
                                            Color.fromARGB(255, 60, 180, 229),
                                      ),
                                      SizedBox(
                                        width: screenWidth / 50,
                                      ),
                                      Text(
                                        (widget.enddate == null
                                                ? "Date Not Defined"
                                                    .toUpperCase()
                                                : widget.enddate) +
                                            (widget.endtime != null
                                                ? " ${widget.endtime}"
                                                : "Time Not Defined"
                                                    .toUpperCase()),
                                        style: mainTextStyleBlack.copyWith(fontSize: 16)
                                      ),
                                    ],
                                  ),
                                  SizedBox(
                                    height: screenHeight / 25,
                                  ),
                                  Padding(
                                    padding: EdgeInsets.only(
                                        right: screenWidth / 8.5),
                                    child: ExpandChild(
                                      child: Column(
                                        children: [
                                          Row(
                                            children: [
                                              const Icon(
                                                Icons.category,
                                                color: Color.fromARGB(
                                                    255, 60, 180, 229),
                                              ),
                                              SizedBox(
                                                width: screenWidth / 50,
                                              ),
                                              Text(
                                                widget.Catgory ??
                                                    "No Category",
                                                style: GoogleFonts.montserrat(
                                                    fontSize: 16,
                                                    fontWeight: FontWeight.w400,
                                                    color: Colors.black),
                                              )
                                            ],
                                          ),
                                          SizedBox(
                                            height: screenHeight / 25,
                                          ),
                                          Row(
                                            children: [
                                              const Icon(
                                                Icons.location_city_rounded,
                                                color: Color.fromARGB(
                                                    255, 60, 180, 229),
                                              ),
                                              SizedBox(
                                                width: screenWidth / 50,
                                              ),
                                              Text(
                                                widget.Landmark.toUpperCase() ??
                                                    "No Landmark".toUpperCase(),
                                                style: GoogleFonts.montserrat(
                                                    fontSize: 16,
                                                    fontWeight: FontWeight.w400,
                                                    color: Colors.black),
                                              )
                                            ],
                                          ),
                                          SizedBox(
                                            height: screenHeight / 25,
                                          ),
                                          Row(
                                            children: [
                                              const Icon(
                                                CupertinoIcons.mail,
                                                color: Color.fromARGB(
                                                    255, 60, 180, 229),
                                              ),
                                              SizedBox(
                                                width: screenWidth / 50,
                                              ),
                                              Flexible(
                                                child: Text(
                                                  widget.Email ??
                                                      "No Email".toUpperCase(),
                                                  style: GoogleFonts.montserrat(
                                                      fontSize: 16,
                                                      fontWeight: FontWeight.w400,
                                                      color: Colors.black),
                                                ),
                                              )
                                            ],
                                          ),
                                          SizedBox(
                                            height: screenHeight / 25,
                                          ),
                                          Row(
                                            children: [
                                              const Icon(
                                                CupertinoIcons.tag_fill,
                                                color: Color.fromARGB(
                                                    255, 60, 180, 229),
                                              ),
                                              SizedBox(
                                                width: screenWidth / 50,
                                              ),
                                              Text(
                                                widget.refNo.toUpperCase() ??
                                                    "No refno".toUpperCase(),
                                                style: GoogleFonts.montserrat(
                                                    fontSize: 16,
                                                    fontWeight: FontWeight.w400,
                                                    color: Colors.black),
                                              )
                                            ],
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ]),
                              ),
                            ]),
                        // SizedBox(
                        //   height: screenHeight / 20,
                        // ),
                        Column(
                            // crossAxisAlignment: CrossAxisAlignment.center,
                            // mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
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
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  CustmButton(
                                      butoontext: '   Upload Bill    ',
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
                                          builder: (context) => RaisedTicket(),
                                        ));
                                      })
                                ],
                              ),
                              SizedBox(
                                height: screenHeight / 50,
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  SizedBox(
                                    height: screenHeight / 17,
                                    width: screenWidth / 2.7,
                                    child: ElevatedButton(
                                      style: ElevatedButton.styleFrom(
                                          shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(32.0)),
                                          backgroundColor:
                                              (const Color.fromARGB(
                                                  255, 60, 180, 229))),
                                      child: Text('End Service'),
                                      onPressed: () async {
                                        final prefs = await SharedPreferences
                                            .getInstance();
                                        // ignore: unused_local_variable
                                        String? Firebase_Id =
                                            prefs.getString('Firebase_Id');
                                        print(Firebase_Id);
                                        print('suiiiiiiiiiiiiiiiiiiiiiiiiii');
                                        int serbiceCount = 1;
                                        getLocationAndAddress();
                                        currentTime.toString();
                                        enddata = {
                                          "firebase_id": Firebase_Id,
                                          "service_id": 'Service $serbiceCount',
                                          "geolocation": addressResult ?? "",
                                          "date_time": currentTime,
                                        };
                                        setState(() {
                                          serbiceCount++;
                                        });
                                        await PostData().postEndService(
                                          enddata,
                                        );
                                      },
                                    ),
                                  ),
                                ],
                              ),
                            ])
                      ],
                    ),
                  ),
                ),
              ),
            );
          }
          return Container(
            color: Colors.red,
          );
        });
  }
}
captilaize(String a){
 final RegExp pattern = RegExp(r'([a-zA-Z]+)([0-9]+)');
  

  String result = a.replaceAllMapped(pattern, (match) {
    return '${match.group(1)} ${match.group(2)}';
  });

  return '${result[0].toUpperCase()}${result.substring(1)}';
}
//give a space between alphabtes and numver in fluter?