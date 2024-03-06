import 'package:flutter/material.dart';
import 'package:geocode/geocode.dart';
import 'package:location/location.dart';
import 'package:mentegoz_technologies/model/completed_model.dart';
import 'package:mentegoz_technologies/model/pending_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

// class JourneyStartedData {
//   int? id;
//   bool journeyStarted;

//   JourneyStartedData(this.id, this.journeyStarted);
// }

class LocationProvider extends ChangeNotifier {
  PendingDataModel? currentService;
  CompleteDataModel? completeCurrentService;
  bool journeyStarted = false;
  bool loaderStarted = false;
  bool isTicketSubmitted = false;
  bool uploadBillCameraError = false;

//  final Map<bool, JourneyStartedData> _journeyStartedData = {};

  // updateJourneyStarted(int? id, bool journeyStarted) {
  //   _journeyStartedData[id]?.journeyStarted = journeyStarted;
  //   notifyListeners();
  // }
  updateUploadBillCameraError(bool value) {
    uploadBillCameraError = value;
    notifyListeners();
  }

  updateLoader(bool value, context) async {
    loaderStarted = value;

    notifyListeners();

    if (value) {
      await Future.delayed(Duration(seconds: 20));

      if (loaderStarted) {
        // print('poor internet connection');
        loaderStarted = false;
        showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
              title: const Text('Poor Internet Connection'),
              actions: [
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
        print('ok');
      }
    }
    notifyListeners();
  }

  updateIsTicketSubmitted(bool value) {
    isTicketSubmitted = value;
    notifyListeners();
  }

  updatejourneyStarted(bool value) async {
    // Provider.of<ServiceProvider>(context,listen: false).pendingData!;
    print(value);
    print('????????????????????????///');
    journeyStarted = value;
    notifyListeners();

    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('journeyStarted', journeyStarted);
  }

  LocationData? currentLocation;
  String? address;

  String? selectedTravelMode;
  setTravelMode(String? travel_mode, service_id) async {
    selectedTravelMode = travel_mode;

    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('travel_mode-$service_id', travel_mode!);
  }

  String? amountController;
  setAmount(String? amount_data) {
    amountController = amount_data;
  }

  setCurrentService(PendingDataModel? currentServices) async {
    currentService = currentServices;
    //    final prefs = await SharedPreferences.getInstance();
    // await prefs.setInt('current_services-$service_id', currentService!.id!);
  }

  setCompleteCurrentService(CompleteDataModel? completeCurrentServices) {
    completeCurrentService = completeCurrentServices;
  }

  String? category;
  setCategory(String? category_value) {
    category = category_value;
  }

  String? options;
  setOptions(String? options_value) {
    options = options_value;
  }

  String? uploadDescriptionController;
  setUploadDescription(String? upload_description) {
    uploadDescriptionController = upload_description;
  }

  String? uploadAmountController;
  setUploadAmount(String? upload_amount) {
    uploadAmountController = upload_amount;
  }

  String? ticketDescriptionController;
  setTicketDescription(String? ticket_description) {
    ticketDescriptionController = ticket_description;
  }

  String? ticketSubjectController;
  setTicketSubject(String? ticket_subject) {
    ticketSubjectController = ticket_subject;
  }

  Future<void> getLocationAndAddress() async {
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
    // ignore: unnecessary_null_comparison
    if (locationData != null) {
      GeoCode geoCode = GeoCode();
      Address result = await geoCode.reverseGeocoding(
        latitude: locationData.latitude!,
        longitude: locationData.longitude!,
      );
      addressResult =
          "${result.streetAddress}, ${result.city}, ${result.countryName}, ${result.postal}";
      // print(addressResult);
    }

    // Update the current location and address.
    currentLocation = locationData;
    address = addressResult ?? "Address not available";
    print(address); 
    // Notify all of the Consumer widgets that the location and address have changed.
    notifyListeners();
  }
}
