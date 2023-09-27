import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:mentegoz_technologies/controller/Provider/name_and_num_provider.dart';
import 'package:mentegoz_technologies/controller/custom_button.dart';
import 'package:mentegoz_technologies/controller/varibles.dart';
import 'package:mentegoz_technologies/view/app_bars/upload_bill_app_bar.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

// List<String> category_list = <String>['Food', 'Travel'];
// List<String> option_list = <String>['Break Fast', 'Lunch', 'Dinner'];

Map<String, List<String>> categoryToOptions = {
  'Food': ['Breakfast', 'Lunch', 'Dinner'],
  'Travel': [],
  
};

String dropdownValue = categoryToOptions.keys.first;
List<String> optionList = categoryToOptions[dropdownValue]!;
String selectedOption = optionList.first;

class UpLoadBill extends StatefulWidget {
  const UpLoadBill({Key? key}) : super(key: key);

  @override
  UpLoadBillState createState() => UpLoadBillState();
}

class UpLoadBillState extends State<UpLoadBill> {
  // String dropdownValue = category_list.first;
  // String Option_value = option_list.first;
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
            "travel_mode": 'jvjjb',
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
    var userProvider = Provider.of<UserNameAndNumber>(context);
    userProvider.get_user_name_and_number();
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      body: CustomScrollView(
        slivers: <Widget>[
          UploadBillAppBar(screenHeight: screenHeight, userProvider: userProvider, screenWidth: screenWidth),
          SliverList(
            delegate: SliverChildListDelegate(
              [
                SizedBox(
                  height: screenHeight / 13,
                ),

                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                     Text("Category    ".toUpperCase()),
                    Container(
                      width: screenWidth / 2,
                      height: screenHeight / 15,
                      padding: EdgeInsets.all(5),
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: Colors.grey
                        ),
                        borderRadius: BorderRadius.circular(5),
                        color: Colors.grey[200],
                      ),
                      child: Center(
                        child: DropdownButtonHideUnderline(
                          child: DropdownButton<String>(
                            value: dropdownValue,
                            onChanged: (String? newValue) {
                              setState(() {
                                dropdownValue = newValue!;
                                optionList = categoryToOptions[dropdownValue]!;
                                space();
                                
                              });
                            },
                            items: categoryToOptions.keys
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

                optionList.isNotEmpty?
                
                Padding(
                  padding:  EdgeInsets.only(top:screenHeight/35),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Text("Options     ".toUpperCase()),
                      Center(
                        child: Container(
                          width: screenWidth / 2,
                          height: screenHeight / 18,
                          decoration: BoxDecoration(
                            border: Border.all(
                              color: Colors.grey
                            ),
                            borderRadius: BorderRadius.circular(5),
                            color: Colors.grey[200],
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              // Text("Select"),
                              DropdownButtonHideUnderline(
                                child: DropdownButton<String>(
                                  value: selectedOption,
                                  onChanged: (newValue) {
                                    setState(() {
                                      // print(dropdownValue);
                                      selectedOption = newValue!;
                                    });
                                  },
                                  items: optionList
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
                )
                :
                const SizedBox(),
                 SizedBox(height: screenHeight/35,),
                Center(
                  
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Text("Amount      ".toUpperCase()),
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
                  height: screenHeight/35,
                ),
                Center(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Text("Description".toUpperCase()),
                      SizedBox(
                        // height: screenHeight/6,
                        width: screenWidth / 2,
                        child: Container(
                          color: Colors.grey[200],
                          child: TextField(
                              maxLines: 4,
                              controller: Description_Controller,
                              decoration: InputDecoration(
                                border: OutlineInputBorder(),
                                hintText: "Enter Description",
                              )),
                        ),
                      ),
                    ],
                  ),
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(
                      height: screenHeight / 15,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        GestureDetector(
                          onTap: () {
                            pickImage(ImageSource.camera);
                          },
                          child: Container(
                            height: screenHeight / 12,
                            width: screenWidth / 5.5,
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
                          width: screenWidth / 15,
                        ),
                        GestureDetector(
                          onTap: () {
                            pickImage(ImageSource.gallery);
                          },
                          child: Container(
                            height: screenHeight / 12,
                            width: screenWidth / 5.5,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: Color.fromARGB(255, 60, 180, 229),
                            ),
                            child: const Icon(
                              Icons.photo,
                              size: 50,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: screenHeight / 35,
                    ),
                    CustmButton(
                        buttontext: 'Upload',
                        buttonaction: () {
                        
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

space(){
if(categoryToOptions[0]==0){
  optionList.first;

}else{
  
null;
    }
}
