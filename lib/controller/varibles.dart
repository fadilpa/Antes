import 'dart:io';
import 'package:geolocator/geolocator.dart';
import 'package:image_picker/image_picker.dart';
import 'package:location/location.dart';

// TextEditingController AmountController = TextEditingController();
// String amount = AmountController.text;
Location location = Location();
File? image;
LocationData? currentLocation;
LocationData? locationData;
String? address = "";
// bool journeyStarted = false;
String? currentTime = DateTime.now().toString();
String? addressResult;
LocationPermission? permission;
LocationPermission? permissionResult;
var startdata = {};
var enddata = {};
var endservicedata = {};
String? selectedTravelMode;
String? name;
String? number;

final ImagePicker picker = ImagePicker();
