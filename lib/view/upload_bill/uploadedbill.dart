import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:mentegoz_technologies/api/upload_bill_api.dart';
import 'package:mentegoz_technologies/controller/Provider/image_picker_provider.dart';
import 'package:mentegoz_technologies/controller/Provider/location_provider.dart';
import 'package:mentegoz_technologies/controller/Provider/name_and_num_provider.dart';
import 'package:mentegoz_technologies/controller/Provider/shared_pref_provider.dart';
import 'package:mentegoz_technologies/controller/custom_button.dart';
import 'package:mentegoz_technologies/controller/styles.dart';
import 'package:mentegoz_technologies/view/app_bars/upload_bill_app_bar.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

Map<String, List<String>> categoryToOptions = {
  'Food': ['Breakfast', 'Lunch', 'Dinner'],
  'Accomodation': [],
  "Purchases": []
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
  final _formKey = GlobalKey<FormState>();
  final _formKey1 = GlobalKey<FormState>();
  final _formKeyimage = GlobalKey<FormState>();

  String? currentTime = DateTime.now().toString();
  TextEditingController Description_Controller = TextEditingController();
  TextEditingController Amount_Controller = TextEditingController();
  String? name;
  String? number;

  Future<void> pickImage(
    ImageSource source,
    context,
    filepath,
  ) async {
    final pickedImage = await ImagePicker().pickImage(source: source);
    final addresSResult =
        Provider.of<LocationProvider>(context, listen: false).address;
    final selectedTarvelMode = context
        .read<LocationProvider>(context, listen: false)
        .selectedTravelMode;
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
      return;
    }

    setState(() {
      filepath = File(pickedImage.path);
    });
    final imageSizeInBytes = filepath!.lengthSync();
    final double imageSizeInMb = imageSizeInBytes / (1024 * 1024);

    if (imageSizeInBytes > 100) {
      final compressedImage = await FlutterImageCompress.compressWithFile(
        filepath,
        quality: 70,
      );
      try {
        final response = await http.post(
          Uri.parse('https://antes.meduco.in/api/upload_bill'),
          body: {
            "firebase_id": firebase_id,
            "service_id": curretService!.id,
            "geolocation": addresSResult ?? "No address fetched",
            "category": categoryvalue,
            "option": optionValue,
            "description": descriptioncontroller,
            "date_time": currentTime,
            "amount": amountcontroller,
            "image": await MultipartFile.fromFile(filepath.toString(),
                filename: 'image.png' //change this'filepath'
                ),
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
      try {
        final response = await http.post(
          Uri.parse(
              'https://antes.meduco.in/api/upload_bill'), // Replace with your API endpoint
          body: {
            "firebase_id": firebase_id,
            "service_id": curretService!.id,
            "geolocation": addresSResult ?? "No data",
            "travel_mode": selectedTarvelMode,
            "date_time": currentTime,
            'image': await MultipartFile.fromFile(filepath.toString(),
                filename: 'image.png' //change this'filepath'
                ),
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
    // Provider.of<OpenGalleyProvider>(context,
    //                               listen: false)
    //                           .emptyImage();
    //                           Provider.of<OpenCameraProvider>(context,
    //                               listen: false)
    //                           .emptyImage();
    Provider.of<LocationProvider>(context, listen: false)
        .getLocationAndAddress();
    getusername_and_number();
  }

  @override
  Widget build(BuildContext context) {
    bool validateForms() {
      bool isValid = true;

      // Validate form 1
      if (!_formKey.currentState!.validate()) {
        isValid = false;
      }

      // Validate form 2
      if (!_formKey1.currentState!.validate()) {
        isValid = false;
      }

      return isValid;
    }

    final addresSResult =
        Provider.of<LocationProvider>(context, listen: false).address;
    final selectedTarvelMode =
        context.read<LocationProvider>().selectedTravelMode;
    final amountcontroller =
        Provider.of<LocationProvider>(context, listen: false)
            .uploadAmountController;
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
    var userProvider = Provider.of<UserNameAndNumber>(context);

    userProvider.get_user_name_and_number();
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      body: CustomScrollView(
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
                  padding: const EdgeInsets.only(left: 10.0, right: 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Category",
                        style: mainTextStyleBlack.copyWith(fontSize: 16),
                      ),
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
                              alignment: Alignment.center,
                              value: dropdownValue,
                              style: mainTextStyleBlack.copyWith(fontSize: 16),
                              onChanged: (String? newValue) {
                                setState(() {
                                  dropdownValue = newValue!;
                                  optionList =
                                      categoryToOptions[dropdownValue]!;
                                  space();
                                });
                                Provider.of<LocationProvider>(context,
                                        listen: false)
                                    .setCategory(newValue);
                              },
                              items: categoryToOptions.keys
                                  .map<DropdownMenuItem<String>>(
                                      (String value) {
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
                        padding: EdgeInsets.only(
                            top: screenHeight / 35, left: 10, right: 10),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "Options",
                              style: mainTextStyleBlack.copyWith(fontSize: 16),
                            ),
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
                                        value: selectedOption,
                                        style: mainTextStyleBlack.copyWith(
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
                    padding: const EdgeInsets.only(left: 10.0, right: 10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Amount",
                          style: mainTextStyleBlack.copyWith(fontSize: 16),
                        ),
                        SizedBox(
                          height: 50,
                          width: screenWidth / 2,
                          child: Container(
                            color: Colors.grey[200],
                            ////////////////////////////////
                            child: Form(
                              key: _formKey,
                              child: TextFormField(
                                validator: (value) =>
                                    value!.isEmpty ? 'Enter the Amount' : null,
                                keyboardType: TextInputType.number,
                                controller: Amount_Controller,
                                onChanged: (value) {
                                  Provider.of<LocationProvider>(context,
                                          listen: false)
                                      .setUploadAmount(value);
                                },
                                decoration: InputDecoration(
                                    contentPadding:
                                        EdgeInsets.only(left: 20.0, top: 5),
                                    border: InputBorder.none,
                                    hintText: "Enter Amount",
                                    hintStyle: mainTextStyleBlack.copyWith(
                                        fontSize: 16)),
                              ),
                              ///////////////
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
                SizedBox(
                  height: screenHeight / 35,
                ),
                Center(
                  child: Padding(
                    padding: const EdgeInsets.only(left: 10.0, right: 10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Description",
                          style: mainTextStyleBlack.copyWith(fontSize: 16),
                        ),
                        SizedBox(
                          // height: screenHeight/6,
                          width: screenWidth / 2,
                          child: Container(
                            color: Colors.grey[200],
                            ///////////////////////
                            child: Form(
                              key: _formKey1,
                              child: TextFormField(
                                  validator: (value) => value!.isEmpty
                                      ? 'Enter the Description'
                                      : null,
                                  maxLines: 4,
                                  controller: Description_Controller,
                                  onChanged: (value) {
                                    Provider.of<LocationProvider>(context,
                                            listen: false)
                                        .setUploadDescription(value);
                                  },
                                  decoration: InputDecoration(
                                      contentPadding:
                                          EdgeInsets.only(left: 20.0, top: 5),
                                      border: InputBorder.none,
                                      hintText: "Enter Description",
                                      hintStyle: mainTextStyleBlack.copyWith(
                                          fontSize: 16))),
                            ),
                            ///////////////////////
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Form(
                  key: _formKeyimage,
                  child: Column(
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
                              Provider.of<OpenCameraProvider>(context,
                                      listen: false)
                                  .openImagePicker();
                              Provider.of<OpenCameraProvider>(context,
                                      listen: false)
                                  .path;
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
                              Provider.of<OpenGalleyProvider>(context,
                                      listen: false)
                                  .OpenGalleryPicker();

                              Provider.of<OpenGalleyProvider>(context,
                                      listen: false)
                                  .gallpick;
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
                      Provider.of<LocationProvider>(context)
                              .uploadBillCameraError
                          ? Text(
                              'Image is required!!',
                              style: TextStyle(color: Colors.red),
                            )
                          : SizedBox(height: 0),
                      SizedBox(
                        height: screenHeight / 35,
                      ),
                      CustmButton(
                          buttontext: 'Upload',
                          isRadius: false,
                          buttonaction: () async {
                            if (validateForms()) {
                              if (Provider.of<OpenCameraProvider>(context,
                                              listen: false)
                                          .path ==
                                      null &&
                                  Provider.of<OpenGalleyProvider>(context,
                                              listen: false)
                                          .gallpick ==
                                      null) {
                                // print("kmk");
                                Provider.of<LocationProvider>(context,
                                        listen: false)
                                    .updateUploadBillCameraError(true);
                              } else {
                                Provider.of<LocationProvider>(context,
                                        listen: false)
                                    .updateUploadBillCameraError(false);
                                Provider.of<LocationProvider>(context,
                                        listen: false)
                                    .getLocationAndAddress();
                                final prefs =
                                    await SharedPreferences.getInstance();
                                // ignore: unused_local_variable
                                String? Firebase_Id =
                                    prefs.getString('Firebase_Id');
                                await Upload(
                                    context,
                                    Firebase_Id,
                                    curretService!.id,
                                    addresSResult,
                                    categoryvalue,
                                    optionValue,
                                    descriptioncontroller,
                                    currentTime,
                                    amountcontroller,
                                    Provider.of<OpenCameraProvider>(context,
                                                    listen: false)
                                                .path ==
                                            null
                                        ? Provider.of<OpenGalleyProvider>(
                                                context,
                                                listen: false)
                                            .gallpick
                                        : Provider.of<OpenCameraProvider>(
                                                context,
                                                listen: false)
                                            .path);
                                //function not assigned need function
                                Amount_Controller.clear();
                                Description_Controller.clear();
                                Provider.of<OpenGalleyProvider>(context,
                                        listen: false)
                                    .emptyImage();
                                Provider.of<OpenCameraProvider>(context,
                                        listen: false)
                                    .emptyImage();
                                // _formKey.currentState!.reset();
                                // _formKey1.currentState!.reset();
                              }
                            }
                          }),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
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
