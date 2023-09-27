import 'package:flutter/material.dart';
import 'package:geocode/geocode.dart';
import 'package:location/location.dart';
import 'package:mentegoz_technologies/controller/varibles.dart';

class LocationProvider extends ChangeNotifier {
  bool journeyStarted = false;
  updatejourneyStarted(bool value) {
    journeyStarted = value;
    notifyListeners();
  }

  // LocationData? currentLocation;
  // String address = "";

  Future<void> getLocationAndAddress() async {
    // Location location = Location();
    LocationData? locationData;
    // String? addressResult;

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
    // ignore: unnecessary_null_comparison
    if (locationData != null) {
      GeoCode geoCode = GeoCode();
      Address result = await geoCode.reverseGeocoding(
        latitude: locationData.latitude!,
        longitude: locationData.longitude!,
      );
      addressResult =
          "${result.streetAddress}, ${result.city}, ${result.countryName}, ${result.postal}";
      print(addressResult);
    }

    // Update the current location and address.
    currentLocation = locationData;
    address = addressResult ?? "Address not available";
    print(address);
    // Notify all of the Consumer widgets that the location and address have changed.
    notifyListeners();
  }
}
