import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class OpenCameraProvider extends ChangeNotifier {
  final ImagePicker picker = ImagePicker();
  File? image;
  var imageBytes;
  var path;
  // var gallpick;

  openImagePicker() async {
    final XFile? pickedImage =
        await picker.pickImage(source: ImageSource.camera,imageQuality: 10);
    if (pickedImage != null) {
      // ignore: unused_local_variable
      imageBytes = await pickedImage.readAsBytes();
      path = pickedImage.path;
      image = File(pickedImage.path);
   
    }
      notifyListeners();
  }

 emptyImage(){
    image=null;
    path=null;
    notifyListeners();
  }

}

class OpenGalleyProvider extends ChangeNotifier{
 final ImagePicker picker = ImagePicker();
  File? image;
  var imageBytes;
  var gallpick;

 OpenGalleryPicker() async {
    final XFile? pickedImage =
        await picker.pickImage(source: ImageSource.gallery,imageQuality: 10);
    if (pickedImage != null) {
      // ignore: unused_local_variable
      imageBytes = await pickedImage.readAsBytes();
      gallpick = pickedImage.path;
      image = File(pickedImage.path);
      notifyListeners();
    }
  }
   emptyImage(){
    image=null;
    gallpick=null;
    notifyListeners();
  }
}
