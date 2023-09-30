import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:mentegoz_technologies/api/upload_bill_api.dart';
import 'package:mentegoz_technologies/controller/Provider/location_provider.dart';
import 'package:mentegoz_technologies/controller/Provider/name_and_num_provider.dart';
import 'package:mentegoz_technologies/controller/Provider/shared_pref_provider.dart';
import 'package:mentegoz_technologies/controller/custom_button.dart';
import 'package:mentegoz_technologies/controller/styles.dart';
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
  String? currentTime = DateTime.now().toString();
  // String dropdownValue = category_list.first;
  // String Option_value = option_list.first;
  TextEditingController Description_Controller = TextEditingController();
  TextEditingController Amount_Controller = TextEditingController();
  File? filepath;
  String? name;
  String? number;
  Future<void> pickImage(ImageSource source, context) async {
    // final addressresult = context.read<LocationProvider>().address;
    final pickedImage = await ImagePicker().pickImage(source: source);
    final addresSResult =
        Provider.of<LocationProvider>(context, listen: false).address;
    final selectedTarvelMode =
        context.read<LocationProvider>().selectedTravelMode;
    final amountcontroller =
        Provider.of<LocationProvider>(context, listen: false).amountController;
    final descriptioncontroller =
        Provider.of<LocationProvider>(context, listen: false)
            .uploadDescriptionController;
    final curretService =
        Provider.of<LocationProvider>(context, listen: false).currentService;
    final firebase_id =
        Provider.of<FirebaseIdProvider>(context, listen: false).firebaseId;
    final categoryvalue =
        Provider.of<LocationProvider>(context, listen: false).category;
    final optionValue =
        Provider.of<LocationProvider>(context, listen: false).options;

    if (pickedImage == null) {
      // User canceled image selection
      return;
    }

    setState(() {
      filepath = File(pickedImage.path);
    });
    // Check the size of the selected image
    final imageSizeInBytes = filepath!.lengthSync();
    final double imageSizeInMb = imageSizeInBytes / (1024 * 1024);

    if (imageSizeInBytes > 100) {
      // Compress the image if it's larger than 1 MB
      final compressedImage = await FlutterImageCompress.compressWithFile(
        filepath!.path,
        quality: 70, // Adjust the quality as needed (0-100)
      );

      // Now, you can send the compressedImage to your API using an HTTP library like Dio or http.
      // Make an HTTP POST request and attach the compressed image data.
      try {
        final response = await http.post(
          Uri.parse(
              'https://antes.meduco.in/api/upload_bill'), // Replace with your API endpoint
          body: {
            "firebase_id": firebase_id,
            "service_id": curretService!.id,
            "geolocation": addresSResult ?? "no address fetched",
            "category": categoryvalue,
            "option": optionValue,
            "description": descriptioncontroller,
            "date_time": currentTime,
            "amount": amountcontroller,
            "image": filepath != null
                ? await MultipartFile.fromFile(
                    filepath as String, //change this'filepath'
                    filename: 'image')
                : null,
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
      // Send filepath to your API.
      try {
        final response = await http.post(
          Uri.parse(
              'https://antes.meduco.in/api/upload_bill'), // Replace with your API endpoint
          body: {
            "firebase_id": firebase_id,
            "service_id": curretService!.id,
            "geolocation": addresSResult ?? "no data",
            "travel_mode": selectedTarvelMode,
            "date_time": currentTime,
            'image':
                MultipartFile.fromFile(filename: 'image', filepath as String),
            // base64Encode(filepath!
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
    Provider.of<LocationProvider>(context, listen: false)
        .getLocationAndAddress();
    getusername_and_number();
  }

  @override
  Widget build(BuildContext context) {
    final addresSResult =
        Provider.of<LocationProvider>(context, listen: false).address;
    final selectedTarvelMode =
        context.read<LocationProvider>().selectedTravelMode;
    final amountcontroller =
        Provider.of<LocationProvider>(context, listen: false).uploadAmountController;
    final descriptioncontroller =
        Provider.of<LocationProvider>(context, listen: false)
            .uploadDescriptionController;
    final curretService =
        Provider.of<LocationProvider>(context, listen: false).currentService;
    final firebase_id =
        Provider.of<FirebaseIdProvider>(context, listen: false).firebaseId;
    final categoryvalue =
        Provider.of<LocationProvider>(context, listen: false).category;
    final optionValue =
        Provider.of<LocationProvider>(context, listen: false).options;

    // int count = 1;
    // final addressresult =
    //     Provider.of<LocationProvider>(context, listen: false).address;
    var userProvider = Provider.of<UserNameAndNumber>(context);
    userProvider.get_user_name_and_number();
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: CustomScrollView(
          slivers: <Widget>[
            UploadBillAppBar(
                screenHeight: screenHeight,
                userProvider: userProvider,
                screenWidth: screenWidth),
            SliverList(
              delegate: SliverChildListDelegate(
                [
                  SizedBox(
                    height: screenHeight / 13,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left:10.0,right: 10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text("Category",style: mainTextStyleBlack.copyWith(
                            fontSize: 16),),
                        Container(
                          width: screenWidth / 2,
                          height: screenHeight / 15,
                          padding: EdgeInsets.all(5),
                          decoration: BoxDecoration(
                            // border: Border.all(color: Colors.grey),
                            borderRadius: BorderRadius.circular(5),
                            color: Colors.grey[200],
                          ),
                          child: Center(
                            child: DropdownButtonHideUnderline(
                              
                              child: DropdownButton<String>(
                                value: dropdownValue,style: mainTextStyleBlack.copyWith(
                            fontSize: 16),
                                onChanged: (String? newValue) {
                                  setState(() {
                                    dropdownValue = newValue!;
                                    optionList = categoryToOptions[dropdownValue]!;
                                    space();
                                  });
                                  Provider.of<LocationProvider>(context,
                                          listen: false)
                                      .setCategory(newValue);
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
                  ),
                  optionList.isNotEmpty
                      ? Padding(
                          padding: EdgeInsets.only(top: screenHeight / 35,left: 10,right: 10),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text("Options",style: mainTextStyleBlack.copyWith(
                          fontSize: 16),),
                              Center(
                                child: Container(
                                  width: screenWidth / 2,
                                  height: screenHeight / 18,
                                  decoration: BoxDecoration(
                                    // border: Border.all(color: Colors.grey),
                                    borderRadius: BorderRadius.circular(5),
                                    color: Colors.grey[200],
                                  ),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      // Text("Select"),
                                      DropdownButtonHideUnderline(
                                        child: DropdownButton<String>(
                                          value: selectedOption,style: mainTextStyleBlack.copyWith(
                          fontSize: 16),
                                          onChanged: (newValue) {
                                            setState(() {
                                              // print(dropdownValue);
                                              selectedOption = newValue!;
                                            });
                                            Provider.of<LocationProvider>(context,
                                                    listen: false)
                                                .setOptions(newValue);
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
                      : const SizedBox(),
                  SizedBox(
                    height: screenHeight / 35,
                  ),
                  Center(
                    child: Padding(
                      padding: const EdgeInsets.only(left:10.0,right: 10),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text("Amount",style: mainTextStyleBlack.copyWith(
                            fontSize: 16),),
                          SizedBox(
                            height: 50,
                            width: screenWidth / 2,
                            child: Container(
                              color: Colors.grey[200],
                              child: TextField(
                                  controller: Amount_Controller,
                                  onChanged: (value) {
                                    Provider.of<LocationProvider>(context,
                                            listen: false)
                                        .setUploadAmount(value);
                                  },
                                  decoration: InputDecoration(
                                    border: InputBorder.none,
                                    hintText: "Enter Amount",
                                     contentPadding: EdgeInsets.all(20.0),
                                    hintStyle: mainTextStyleBlack.copyWith(
                            fontSize: 16)
                                  )),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(
                    height: screenHeight / 35,
                  ),
                  Center(
                    child: Padding(
                       padding: const EdgeInsets.only(left:10.0,right: 10),
                      child: Row(
                        mainAxisAlignment:MainAxisAlignment.spaceBetween,
                        children: [
                          Text("Description",style: mainTextStyleBlack.copyWith(
                            fontSize: 16),),
                          SizedBox(
                            // height: screenHeight/6,
                            width: screenWidth / 2,
                            child: Container(
                              color: Colors.grey[200],
                              child: TextField(
                                  maxLines: 4,
                                  controller: Description_Controller,
                                  onChanged: (value) {
                                    Provider.of<LocationProvider>(context,
                                            listen: false)
                                        .setUploadDescription(value);
                                  },
                                  decoration: InputDecoration(
                                      contentPadding: EdgeInsets.only(left:20.0,top: 5),
                                    border: InputBorder.none,
                                    hintText: "Enter Description",hintStyle: mainTextStyleBlack.copyWith(
                            fontSize: 16)
                                  )),
                            ),
                          ),
                        ],
                      ),
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
                              pickImage(ImageSource.camera, context);
                            },
                            child: Container(
                              height: screenHeight / 12,
                              width: screenWidth / 5.5,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(2),
                                color: mainThemeColor,
                              ),
                              child: const Icon(
                                Icons.camera_alt_rounded,
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
                              pickImage(ImageSource.gallery, context);
                            },
                            child: Container(
                              height: screenHeight / 12,
                              width: screenWidth / 5.5,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(2),
                                color: mainThemeColor,
                              ),
                              child: const Icon(
                                CupertinoIcons.photo_fill,
                                size: 45,
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
                          isRadius: false,
                          buttonaction: () async {
                            Provider.of<LocationProvider>(context, listen: false)
                                .getLocationAndAddress();
                            final prefs = await SharedPreferences.getInstance();
      // ignore: unused_local_variable
                            String? Firebase_Id = prefs.getString('Firebase_Id');
                            Upload(
                                context,
                                Firebase_Id,
                                curretService!.id,
                                addresSResult,
                                categoryvalue,
                                optionValue,
                                descriptioncontroller,
                                currentTime,
                                amountcontroller,
                                filepath);
                            //function not assigned need function
                            Amount_Controller.clear();
                            Description_Controller.clear();
                          }),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

space() {
  if (categoryToOptions[0] == 0) {
    optionList.first;
  } else {
    null;
  }
}
