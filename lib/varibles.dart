import 'dart:io';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:image_picker/image_picker.dart';
import 'package:location/location.dart';

Location location = Location();
File? image;
LocationData? currentLocation;
LocationData? locationData;
String address = "";
bool journeyStarted = false;
TimeOfDay currentTime = TimeOfDay.now();
String? addressResult;
LocationPermission? permission;
LocationPermission? permissionResult;

final ImagePicker picker = ImagePicker();
