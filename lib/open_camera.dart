import 'package:image_picker/image_picker.dart';

final ImagePicker _picker = ImagePicker();

  Future<void> openCamera() async {
    final XFile? image = await _picker.pickImage(source: ImageSource.camera);
    if (image != null) {
      // Do something with the image
    }
  }