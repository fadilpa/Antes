import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';

class RequestLocation extends StatefulWidget {
  const RequestLocation({super.key});

  @override
  State<RequestLocation> createState() => ReqLocation();
}

class ReqLocation extends State<RequestLocation> {
  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }

  Future<void> requestLocationPermission() async {
    LocationPermission? permission;
    LocationPermission permissionResult;
    try {
      permissionResult = await Geolocator.requestPermission();
      setState(() {
        permission = permissionResult;
      });
    } catch (e) {
      // Handle any errors related to location permission
      print("Error requesting location permission: $e");
    }
  }
}
