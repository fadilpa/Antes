import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:mentegoz_technologies/custom_button.dart';
import 'package:mentegoz_technologies/pending_service_page.dart';
import 'package:mentegoz_technologies/start_journey_function.dart';
import 'package:shared_preferences/shared_preferences.dart';

List<String> category_list = <String>['Food'];
List<String> option_list = <String>['Break Fast', 'Lunch', 'Dinner'];

class UpLoadBill extends StatefulWidget {
  const UpLoadBill({Key? key}) : super(key: key);

  @override
  UpLoadBillState createState() => UpLoadBillState();
}

class UpLoadBillState extends State<UpLoadBill> {
  String dropdownValue = category_list.first;
  String Option_value = option_list.first;
  TextEditingController Description_Controller = TextEditingController();
  TextEditingController Amount_Controller = TextEditingController();
  File? _selectedImage;
  String? name;
  String? number;
  Future<void> pickImage(ImageSource source) async {
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

    if (imageSizeInBytes > 100) {
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
              'https://antes.meduco.in/api/upload_bill'), // Replace with your API endpoint
          body: {
            "firebase_id": "syuxKE42GTXQaZaZBdoUBwgTAfi1",
            "service_id": "1",
            "geolocation": "",
            "category": "",
            "option": "",
            "description": "",
            "date_time": "",
            "amount": "",
            "image": ""
            // base64Encode(compressedImage!), // Convert to base64 if needed
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
              'https://antes.meduco.in/api/upload_bill'), // Replace with your API endpoint
          body: {
            "firebase_id": "syuxKE42GTXQaZaZBdoUBwgTAfi1",
            "service_id": 'Service 1',
            "geolocation": addressResult,
            "travel_mode": '56eesdtry',
            "date_time": currentTime,
            'image': MultipartFile.fromFile(_selectedImage as String,
                filename: 'image'),
            // base64Encode(_selectedImage!
            //     .readAsBytesSync()),

            // Convert to base64 if needed
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

  File? _image;
  final _picker = ImagePicker();
  // Implementing the image picker
  Future<void> _openImagePicker() async {
    final XFile? pickedImage =
        await _picker.pickImage(source: ImageSource.gallery);
    if (pickedImage != null) {
      final imageBytes = await pickedImage.readAsBytes();
      setState(() {
        _image = File(pickedImage.path);
      });
    }
  }

  final dio = Dio();

  String? serviceCount;

  Future Upload(serviceCount, filepath, description, amount) async {
    // print(caption + title + filepath);
    print('aaaaaaaaaaaaaaaaaaaaa');
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final firebase_id = prefs.getString('Firebase_Id');
    final formData = FormData.fromMap({
      "firebase_id": firebase_id,
      "service_id": "Serive $serviceCount",
      "geolocation": addressResult,
      "category": dropdownValue,
      "option": Option_value,
      "description": description,
      "date_time": currentTime.toString(),
      "amount": amount,
      'image': await MultipartFile.fromFile(filepath, filename: 'image'),
    });
    final response = await dio.post(
      'https://antes.meduco.in/api/upload_bill',
      data: formData,
    );
    print(response.statusCode);

    if (response.statusCode == 200) {
      // Navigator.pop(context);
      ScaffoldMessenger.of(context)
          .showSnackBar(const SnackBar(content: Text('Upload Succesful')));
    } else {
      ScaffoldMessenger.of(context)
          .showSnackBar(const SnackBar(content: Text('Check Your Internet')));
      throw Exception();
      // ignore: prefer_const_constructors
    }
  }

  getusername_and_number() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      name = prefs.getString('Name');
    number = prefs.getString('Mobile');
    });
  }

  @override
  void initState() {
    super.initState();
    getusername_and_number();
  }

  @override
  Widget build(BuildContext context) {
    String? selectedTravelMode;
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
                  fontSize: 15.0,
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
                        name ?? "User Name",
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 13,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      Text(
                        number ?? "Emp_no",
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 13,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    width: MediaQuery.of(context).size.width /30,
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
                  height: screenHeight / 13,
                ),

                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    const Text("Category   "),
                    Container(
                      width: screenWidth / 2,
                      height: screenHeight / 15,
                      padding: EdgeInsets.all(5),
                      decoration: BoxDecoration(
                        border: Border.all(),
                        borderRadius: BorderRadius.circular(5),
                        color: Colors.grey[200],
                      ),
                      child: Center(
                        child: DropdownButtonHideUnderline(
                          child: DropdownButton<String>(
                            value: dropdownValue,
                            // icon: const Icon(Icons.arrow_downward),
                            elevation: 16,
                            style: const TextStyle(color: Colors.black),
                            // underline: Container(
                            //   height: 2,
                            //   color: Colors.deepPurpleAccent,
                            // ),
                        
                            onChanged: (String? value) {
                              // This is called when the user selects an item.
                              setState(() {
                                dropdownValue = value!;
                              });
                            },
                            items: category_list
                                .map<DropdownMenuItem<String>>((String value) {
                              return DropdownMenuItem<String>(
                                value: value,
                                child: Text(value),
                              );
                            }).toList(),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),

                SizedBox(
                  height: 25,
                ),
                Center(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Text("Options    "),
                      Center(
                        child: Container(
                          width: screenWidth / 2,
                          height: screenHeight / 18,
                          decoration: BoxDecoration(
                            border: Border.all(),
                            borderRadius: BorderRadius.circular(5),
                            color: Colors.grey[200],
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              // Text("Select"),
                              DropdownButtonHideUnderline(
                                child: DropdownButton<String>(
                                  value: Option_value,
                                  // icon: const Icon(Icons.arrow_downward),
                                  elevation: 16,
                                  // style: const TextStyle(color: Colors.deepPurple),
                                  // underline: Container(
                                  //   height: 2,
                                  //   color: Colors.deepPurpleAccent,
                                  // ),
                                  onChanged: (String? value) {
                                    // This is called when the user selects an item.
                                    setState(() {
                                      Option_value = value!;
                                    });
                                  },
                                  items: option_list
                                      .map<DropdownMenuItem<String>>(
                                          (String value) {
                                    return DropdownMenuItem<String>(
                                      value: value,
                                      child: Text(value),
                                    );
                                  }).toList(),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Center(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Text("Amount     "),
                      SizedBox(
                        height: 50,
                        width: screenWidth / 2,
                        child: Container(
                          color: Colors.grey[200],
                          child: TextField(
                              controller: Amount_Controller,
                              decoration: InputDecoration(
                                border: OutlineInputBorder(),
                                
                                
                                hintText: "Enter Amount",
                              )),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 15,
                ),
                Center(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Text("Description"),
                      SizedBox(
                        height: 100,
                        width: screenWidth / 2,
                        child: Container(
                          color: Colors.grey[200],
                          child: TextField(
                              maxLines: 3,
                              controller: Description_Controller,
                              decoration: InputDecoration(
                                border: OutlineInputBorder(),
                                hintText: "EnterDescription",
                              )),
                        ),
                      ),
                    ],
                  ),
                ),
                // Text("Amount"),
                //  Container(
                //   height: 50,
                //   width: 100,
                //   color: Colors.white60,
                //   child: Row(
                //     mainAxisAlignment: MainAxisAlignment.center,
                //     children: [
                //       Text("Select"),
                //       DropdownButton<String>(
                //         items: <String>['A', 'B', 'C', 'D']
                //             .map((String value) {
                //           return DropdownMenuItem<String>(
                //             value: value,
                //             child: Text(value),
                //           );
                //         }).toList(),
                //         onChanged: (_) {},
                //       )
                //     ],
                //   ),
                // ),
                //     Text("Amount"),
                //      TextField(
                //   decoration: InputDecoration(
                //     labelText: "Enter Amount",
                //   ),
                // ),
                // Text("Description"),
                //  TextField(
                //   decoration: InputDecoration(
                //     labelText: "Enter Description",
                //   ),
                // ),
                // SizedBox(
                //   height: screenHeight / 3.5,
                // ),

                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                     SizedBox(
                      height: screenHeight/15,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        GestureDetector(
                          onTap: () {
                            pickImage(ImageSource.camera);
                          },
                          child: Container(
                            height: screenHeight/12,
                            width: screenWidth/5.5,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: Color.fromARGB(255, 60, 180, 229),
                            ),
                            child: const Icon(
                              Icons.camera_alt,
                              size: 50,
                              color: Colors.white,
                            ),
                          ),
                        ),
                          SizedBox(
                      width: screenWidth/15,
                    ),
                        
                        GestureDetector(
                          onTap: () {
                            pickImage(ImageSource.gallery);
                          },
                          child: Container(
                            height: screenHeight/12,
                            width: screenWidth/5.5,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: Color.fromARGB(255, 60, 180, 229),
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
                    
                      SizedBox(
                      height: screenHeight/35,
                    ),
                    CustmButton(
                        butoontext: 'Upload',
                        buttonaction: () {
                          Upload(
                              serviceCount,
                              _image!.path,
                              Description_Controller.text,
                              Amount_Controller.text);
                        }),
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