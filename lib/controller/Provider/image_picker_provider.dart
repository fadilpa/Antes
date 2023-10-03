import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mentegoz_technologies/controller/varibles.dart';

class OpenCameraProvider extends ChangeNotifier {
  final ImagePicker picker = ImagePicker();
  File? image;
  Future<void> openImagePicker() async {
    final XFile? pickedImage =
        await picker.pickImage(source: ImageSource.camera);
    if (pickedImage != null) {
      // ignore: unused_local_variable
      final imageBytes = await pickedImage.readAsBytes();
      image = File(pickedImage.path);
        notifyListeners();
    }
  }
  emptyImage(){
    image=null;
    notifyListeners();
  }
}
