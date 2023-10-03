import 'dart:io';
import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart' as permission_handler;
import 'package:permission_handler/permission_handler.dart';

class ReqMedia extends StatelessWidget {
  const ReqMedia({super.key});

  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }


Future<void> requestMediaPermissions() async {
  // Check if the camera and microphone permissions are already granted
  permission_handler.PermissionStatus cameraStatus =
      await permission_handler.Permission.camera.status;
  permission_handler.PermissionStatus microphoneStatus =
      await permission_handler.Permission.microphone.status;

  if (cameraStatus.isDenied || microphoneStatus.isDenied) {
    // Request permissions
    Map<permission_handler.Permission, permission_handler.PermissionStatus> statuses =
        await [
      permission_handler.Permission.camera,
      permission_handler.Permission.microphone,
    ].request();

    // Check the status of each permission
    if (statuses[permission_handler.Permission.camera]!.isDenied ||
        statuses[permission_handler.Permission.microphone]!.isDenied) {
      // Handle denied permissions
      // print('denieedddddd');
      // You can show a dialog or message to the user explaining why the permissions are necessary.
      //close the application
      exit(0);
    }
  }
}
}