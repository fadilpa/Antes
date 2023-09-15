import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'package:http/http.dart' as http;

class UpLoadBill extends StatefulWidget {
  const UpLoadBill({Key? key}) : super(key: key);

  @override
  _UpLoadBillState createState() => _UpLoadBillState();
}

class _UpLoadBillState extends State<UpLoadBill> {
  File? _selectedImage;

  Future<void> _pickImage(ImageSource source) async {
    final pickedImage = await ImagePicker().pickImage(source: source);

    if (pickedImage == null) {
      // User canceled image selection
      return;
    }

    setState(() {
      _selectedImage = File(pickedImage.path);
    });

    // Check the size of the selected image
    final imageSizeInBytes = _selectedImage!.lengthSync();
    final double imageSizeInMb = imageSizeInBytes / (1024 * 1024);

    if (imageSizeInMb > 1.0) {
      // Compress the image if it's larger than 1 MB
      final compressedImage = await FlutterImageCompress.compressWithFile(
        _selectedImage!.path,
        quality: 70, // Adjust the quality as needed (0-100)
      );

      // Now, you can send the compressedImage to your API using an HTTP library like Dio or http.
      // Make an HTTP POST request and attach the compressed image data.
      try {
        final response = await http.post(
          Uri.parse(
              'https://api.escuelajs.co/api/v1/files/upload'), // Replace with your API endpoint
          body: {
            'image':
                base64Encode(compressedImage!), // Convert to base64 if needed
          },
        );

        if (response.statusCode == 200) {
          // Image successfully uploaded, you can handle the response here
        } else {
          // Handle errors or issues with the API request
          print('API request failed with status code: ${response.statusCode}');
        }
      } catch (error) {
        // Handle exceptions or network errors
        print('Error sending image to API: $error');
      }
    } else {
      // Image is already below 1 MB, you can directly upload it.
      // Send _selectedImage to your API.
      try {
        final response = await http.post(
          Uri.parse(
              'https://api.escuelajs.co/api/v1/files/upload'), // Replace with your API endpoint
          body: {
            'image': base64Encode(_selectedImage!
                .readAsBytesSync()), // Convert to base64 if needed
          },
        );

        if (response.statusCode == 200) {
          // Image successfully uploaded, you can handle the response here
        } else {
          // Handle errors or issues with the API request
          print('API request failed with status code: ${response.statusCode}');
        }
      } catch (error) {
        // Handle exceptions or network errors
        print('Error sending image to API: $error');
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      body: CustomScrollView(
        slivers: <Widget>[
          SliverAppBar(
            pinned: true,
            floating: true,
            expandedHeight: screenHeight * 0.13,
            forceElevated: true,
            elevation: 3,
            backgroundColor: Colors.white,
            flexibleSpace: const FlexibleSpaceBar(
              centerTitle: true,
              title: Text(
                "Upload Bill",
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 16.0,
                ),
              ),
            ),
            leading: IconButton(
              icon: const Icon(
                Icons.arrow_back_ios_outlined,
                color: Colors.black,
              ),
              tooltip: 'Menu',
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            actions: <Widget>[
              Row(
                children: [
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Thomas',
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      Text(
                        '12345678910',
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    width: MediaQuery.of(context).size.width * 0.02,
                  ),
                  Padding(
                    padding: EdgeInsets.only(right: screenWidth / 30),
                    child: CircleAvatar(),
                  ),
                ],
              )
            ],
          ),
          SliverList(
            delegate: SliverChildListDelegate(
              [
                SizedBox(
                  height: screenHeight / 3.5,
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Lorem ipsum dolor sit amet consectetur.\n                     Feugiat et aliquat',
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        GestureDetector(
                          onTap: () {
                            _pickImage(ImageSource.camera);
                          },
                          child: Container(
                            height: 70,
                            width: 70,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                             color: Color.fromARGB(255, 60,180,229),
                            ),
                            child: const Icon(
                              Icons.camera_alt,
                              size: 50,
                              color: Colors.white,
                            ),
                          ),
                        ),
                        const SizedBox(
                          width: 20,
                        ),
                        GestureDetector(
                          onTap: () {
                            _pickImage(ImageSource.gallery);
                          },
                          child: Container(
                            height: 70,
                            width: 70,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color:Color.fromARGB(255, 60,180,229),
                            ),
                            child: const Icon(
                              Icons.photo_album,
                              
                              size: 60,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
