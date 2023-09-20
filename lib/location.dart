// import 'package:flutter/material.dart';
// import 'package:geocode/geocode.dart';
// import 'package:location/location.dart';

// class GetUserLocation extends StatefulWidget {
//   GetUserLocation({Key? key, this.title}) : super(key: key);
//   final String? title;

//   @override
//   _GetUserLocationState createState() => _GetUserLocationState();
// }

// class _GetUserLocationState extends State<GetUserLocation> {
//   LocationData? currentLocation;
//   String address = "";

//   @override
//   void initState() {
//     super.initState();
//     _getLocationAndAddress();
//     print(_getLocationAndAddress());
//   }

//   Future<void> _getLocationAndAddress() async {
//     // print(_getLocationAndAddress());
//     // final double? latitude;
//     // final double? longitide;
//     Location location = Location();
//     LocationData? locationData;
//     String? addressResult;

//     // Check if location service is enabled.
//     bool serviceEnabled = await location.serviceEnabled();
//     if (!serviceEnabled) {
//       serviceEnabled = await location.requestService();
//       if (!serviceEnabled) {
//         // Handle if the user doesn't enable location services.
//         return;
//       }
//     }

//     // Check and request location permission.
//     PermissionStatus permissionGranted = await location.hasPermission();
//     if (permissionGranted == PermissionStatus.denied) {
//       permissionGranted = await location.requestPermission();
//       if (permissionGranted != PermissionStatus.granted) {
//         // Handle if permission is not granted.
//         return;
//       }
//     }

//     // Get the user's location.
//     locationData = await location.getLocation();

//     // Get the address from the user's location.
//     if (locationData != null) {
//       GeoCode geoCode = GeoCode();
//       Address result = await geoCode.reverseGeocoding(
//         latitude: locationData.latitude!,
//         longitude: locationData.longitude!,
//       );
//       addressResult =
//           "${result.streetAddress}, ${result.city}, ${result.countryName}, ${result.postal}";
//     }
// print(addressResult);
//     //  the state with the location and address.
//     setState(() {
//       currentLocation = locationData;
//       address = addressResult ?? "Address not available";
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(),
//       body: Center(
//         child: Padding(
//           padding: EdgeInsets.all(16.0),
//           child: Column(
//             mainAxisAlignment: MainAxisAlignment.center,
//             children: <Widget>[
//               if (currentLocation != null)
//                 Text("Location: ${currentLocation?.latitude}, ${currentLocation?.longitude}"),
//               if (currentLocation != null) Text("Address: $address"),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
