import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:image_picker/image_picker.dart';

class OpenCameraProvider extends ChangeNotifier {
  final ImagePicker picker = ImagePicker();
  File? image;
  var imageBytes;
  var path;
  // var gallpick;

  openImagePicker() async {
    final XFile? pickedImage =
        await picker.pickImage(source: ImageSource.camera,imageQuality: 5);
    if (pickedImage != null) {
      // ignore: unused_local_variable
      imageBytes = await pickedImage.readAsBytes();
      path = pickedImage.path;
      image = File(pickedImage.path);
      print(pickedImage.length());
      print('llllllllllllllllllll');
      // compressFile(File(pickedImage.path));
   
    }
      notifyListeners();
  }
// Future<XFile?> compressFile(File file) async {
//   final filePath = file.absolute.path;
//   // Create output file path
//   // eg:- "Volume/VM/abcd_out.jpeg"
//   final lastIndex = filePath.lastIndexOf(new RegExp(r'.jp'));
//   final splitted = filePath.substring(0, (lastIndex));
//   final outPath = "${splitted}_out${filePath.substring(lastIndex)}";
//   var result = await FlutterImageCompress.compressAndGetFile(
//     file.absolute.path, outPath,
//     quality: 5,
//   );
//   // int ? datalenth=result!.length as int?;
//   // print(datalenth);
//   print(file.lengthSync());
//   print(result!.length());
//   print('AAAAAAAAAAAAAAAAAAAAAAAAAAAAA');
//    imageBytes = await file.readAsBytes();
//       path = file.path;
//       image = File(file.path);
//   return result;
//  }
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
        await picker.pickImage(source: ImageSource.gallery,imageQuality: 5);
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
