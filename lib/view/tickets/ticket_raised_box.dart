import 'dart:convert';
import 'dart:io';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mentegoz_technologies/controller/Provider/location_provider.dart';
import 'package:mentegoz_technologies/controller/select_image_source.dart';
import 'package:mentegoz_technologies/controller/styles.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

String? name;
String? number;

class RaisedTicket extends StatefulWidget {
  const RaisedTicket({super.key});

  @override
  State<RaisedTicket> createState() => _RaisedTicketState();
}

class _RaisedTicketState extends State<RaisedTicket> {
  final _formKey = GlobalKey<FormState>();
  File? image;
  // var path;
  // final _picker = ImagePicker();
  // Implementing the image picker
  // Future<void> _openImagePicker() async {
  //   final XFile? pickedImage =
  //       await _picker.pickImage(source: ImageSource.gallery);
  //   if (pickedImage != null) {
  //     final imageBytes = await pickedImage.readAsBytes();
  //     setState(() {
  //       path = pickedImage.path;
  //       image = File(pickedImage.path);
  //     });
  //   }
  // }

  TextEditingController SubjectController = TextEditingController();
  TextEditingController DescriptionController = TextEditingController();

  final dio = Dio();

  Future UploadTicket(
    firbase_id,
    id,
    addressresult,
    subject,
    description,
    currentTime,
    filepath,
  ) async {
    // print(caption + title + filepath);
    print('aaaaaaaaaaaaaaaaaaaaa');
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final firebaseId = prefs.getString('Firebase_Id');
    final addresSResult =
        Provider.of<LocationProvider>(context, listen: false).currentLocation;
            final adress =
        Provider.of<LocationProvider>(context, listen: false).address;
    final curretService =
        Provider.of<LocationProvider>(context, listen: false).currentService;
    final subjectcontroller =
        Provider.of<LocationProvider>(context, listen: false)
            .ticketSubjectController;
    final descriptioncontroller =
        Provider.of<LocationProvider>(context, listen: false)
            .ticketDescriptionController;

    var bytes =
        (await rootBundle.load('assets/null.jpeg')).buffer.asUint8List();
    var mpFile = MultipartFile.fromBytes(bytes, filename: 'image.jpeg');

    String? currentTime = DateTime.now().toString();
    final formData = FormData.fromMap({
      "firebase_id": firebaseId,
      "service_id": id,
      "geolocation": adress ?? "Address Not Found",
      "coordinates": addresSResult!.latitude.toString()+","+addresSResult.longitude.toString() ?? "No Options",
      "subject": subject,
      "description": description,
      "date_time": currentTime,
      'image': filepath != null
          ? await MultipartFile.fromFile(filepath.toString(),
              filename: 'image.png' //change this'filepath'
              )
          : mpFile,
    });
    print(firebaseId);
    print(id);
    print(addressresult);
    print(subject);
    print(description);
    print(currentTime);
    print(filepath);

    final response = await dio.post(
      'http://antesapp.com/api/ticket_submit',
      data: formData,
    );
    print(response.statusCode);
    print(jsonEncode(response.data));
    if (response.statusCode == 200) {
      // Navigator.pop(context);

      ScaffoldMessenger.of(context)
          .showSnackBar(const SnackBar(content: Text('Ticket Raised!')));
    } else {
      ScaffoldMessenger.of(context)
          .showSnackBar(const SnackBar(content: Text('Check Your Internet')));
      throw Exception();
      // ignore: prefer_const_constructors
    }
    return response.statusCode;
  }

  var path;
  var gallpick;
  // bool isTicketSubmitted = false; // Add a flag to track ticket submission
  Future<void> showImageSourceDialog(BuildContext context) async {
    return showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Select Image Source'),
          actions: <Widget>[
            TextButton(
              onPressed: () async {
                Navigator.of(context).pop();
                final pickedImage = await ImagePicker().pickImage(
                  source: ImageSource.camera,
                );
                // Handle the selected image from the camera
                if (pickedImage != null) {
                  final imagebytes = await pickedImage.readAsBytes();
                  setState(() {
                    // path = pickedImage.path;
                    image = File(pickedImage.path);
                  });
                  path = pickedImage.path;
                  // setState(() {
                  //   isTicketSubmitted = true;
                  // });
                }
              },
              child: const Text('Camera'),
            ),
            TextButton(
              onPressed: () async {
                Navigator.of(context).pop();
                final pickedImage = await ImagePicker().pickImage(
                  source: ImageSource.gallery,
                );
                // Handle the selected image from the gallery
                if (pickedImage != null) {
                  final imagebytes = await pickedImage.readAsBytes();
                  setState(() {
                    image = File(pickedImage.path);
                  });
                  gallpick = pickedImage.path;
                  // setState(() {
                  //   isTicketSubmitted = true;
                  // });
                  // Process the image here
                }
              },
              child: const Text('Gallery'),
            ),
          ],
        );
      },
    );
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
    Provider.of<LocationProvider>(context, listen: false)
        .getLocationAndAddress();
        //  Provider.of<LocationProvider>(context, listen: false)
        // .updateIsTicketSubmitted(false);
    final addresSResult =
        Provider.of<LocationProvider>(context, listen: false).address;

    final subjectcontroller =
        Provider.of<LocationProvider>(context, listen: false)
            .ticketSubjectController;
    final descriptioncontroller =
        Provider.of<LocationProvider>(context, listen: false)
            .ticketDescriptionController;
    final curretService =
        Provider.of<LocationProvider>(context, listen: false).currentService;
    String? currentTime = DateTime.now().toString();
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;
    // if ( Provider.of<LocationProvider>(context, listen: false)
    //         .isTicketSubmitted) {
    //   // Display the success card/container if the ticket is submitted
    //   return Scaffold(
    //     body: CustomScrollView(
    //       slivers: <Widget>[
    //         SliverAppBar(
    //           pinned: true,
    //           floating: true,
    //           expandedHeight: 100,
    //           forceElevated: true,
    //           elevation: 3,
    //           backgroundColor: Colors.white70,
    //           flexibleSpace: FlexibleSpaceBar(
    //             centerTitle: true,
    //             title: Text("Raise a Ticket",
    //                 style: mainTextStyleBlack.copyWith(
    //                     fontWeight: FontWeight.bold, fontSize: 20)),
    //           ),
    //           leading: IconButton(
    //             icon: const Icon(
    //               Icons.arrow_back_ios_outlined,
    //               color: Colors.black,
    //             ),
    //             tooltip: 'Back',
    //             onPressed: () {
    //               Navigator.of(context).pop();
    //             },
    //           ),
    //           actions: <Widget>[
    //             Row(
    //               children: [
    //                 Column(
    //                   mainAxisAlignment: MainAxisAlignment.center,
    //                   children: [
    //                     Text(name!.split(' ').first ?? "User Name",
    //                         style: mainTextStyleBlack.copyWith(
    //                             fontSize: 12, fontWeight: FontWeight.bold)),
    //                     Text(number ?? "",
    //                         style: mainTextStyleBlack.copyWith(fontSize: 12)),
    //                   ],
    //                 ),
    //                 SizedBox(
    //                   width: MediaQuery.of(context).size.width / 30,
    //                 ),
    //                 Padding(
    //                   padding: EdgeInsets.only(right: screenWidth / 30),
    //                   child: CircleAvatar(
    //                     backgroundColor: mainThemeColor,
    //                   ),
    //                 ),
    //               ],
    //             )
    //           ],
    //         ),
    //         SliverToBoxAdapter(
    //           child: Center(
    //             child: Padding(
    //               padding: EdgeInsets.only(top: screenHeight / 10),
    //               child: Container(
    //                 height: screenHeight / 2,
    //                 width: screenWidth / 1.2,
    //                 decoration: BoxDecoration(
    //                   color: Colors.white70,
    //                   borderRadius: BorderRadius.circular(15),
    //                   boxShadow: [
    //                     BoxShadow(
    //                       color: Colors.black.withOpacity(0.2),
    //                       blurRadius: 10,
    //                       spreadRadius: 5,
    //                     ),
    //                   ],
    //                 ),
    //                 child: Column(
    //                   children: [
    //                     Container(
    //                       height: screenHeight / 6.7,
    //                       width: screenWidth / 1.2,
    //                       decoration: BoxDecoration(
    //                         color: mainThemeColor,
    //                         borderRadius: BorderRadius.only(
    //                           topRight: Radius.circular(15),
    //                           topLeft: Radius.circular(15),
    //                         ),
    //                       ),
    //                       child: Column(
    //                         children: [
    //                           Container(
    //                             height: screenHeight / 6.7,
    //                             width: screenWidth / 1.2,
    //                             decoration: BoxDecoration(
    //                               color: mainThemeColor,
    //                               borderRadius: BorderRadius.only(
    //                                 topRight: Radius.circular(15),
    //                                 topLeft: Radius.circular(15),
    //                               ),
    //                             ),
    //                             child: Column(
    //                               children: [
    //                                 Row(
    //                                   mainAxisAlignment: MainAxisAlignment.end,
    //                                   children: [
    //                                     IconButton(
    //                                       onPressed: () {
    //                                         Navigator.of(context).pop();
    //                                       },
    //                                       icon: const Icon(Icons.close),
    //                                     ),
    //                                   ],
    //                                 ),
    //                                 const Text(
    //                                   'Ticket Raised',
    //                                   style: TextStyle(
    //                                     color: Colors.white70,
    //                                     fontSize: 20,
    //                                   ),
    //                                 ),
    //                               ],
    //                             ),
    //                           ),
    //                         ],
    //                       ),
    //                     ),
    //                     Column(
    //                       children: [
    //                         SizedBox(height: screenHeight / 20),
    //                         SizedBox(
    //                           width: screenWidth / 1.6,
    //                           height: screenHeight / 6.7,
    //                           child: Card(
    //                             shape: RoundedRectangleBorder(
    //                               borderRadius: BorderRadius.circular(10),
    //                             ),
    //                             color: const Color.fromARGB(255, 210, 254, 166),
    //                             child: Padding(
    //                               padding: const EdgeInsets.all(8.0),
    //                               child: Column(
    //                                 crossAxisAlignment:
    //                                     CrossAxisAlignment.start,
    //                                 mainAxisAlignment:
    //                                     MainAxisAlignment.spaceEvenly,
    //                                 children: const [
    //                                   Text(
    //                                     'Hello!',
    //                                     style: TextStyle(fontSize: 15),
    //                                   ),
    //                                   Text(
    //                                     'Your Ticket accepted!',
    //                                     style: TextStyle(fontSize: 15),
    //                                   ),
    //                                 ],
    //                               ),
    //                             ),
    //                           ),
    //                         ),
    //                         SizedBox(height: screenHeight / 40),
    //                         CircleAvatar(
    //                           radius: screenWidth / 13.5,
    //                           backgroundColor:
    //                               Color.fromARGB(255, 210, 254, 166),
    //                           child: Icon(
    //                             Icons.done,
    //                             size: 28,
    //                             color: Colors.white70,
    //                           ),
    //                         )
    //                       ],
    //                     ),
    //                   ],
    //                 ),
    //               ),
    //             ),
    //           ),
    //         ),
    //       ],
    //     ),
    //   );
    // } else {
   

    return  Scaffold(
      body: Consumer<LocationProvider>(
        builder: (context, value, child) {
       
          return value.loaderStarted?
          
          Center(child: CircularProgressIndicator()): CustomScrollView(
            slivers: <Widget>[
              SliverAppBar(
                pinned: true,
                floating: true,
                expandedHeight: 100,
                forceElevated: true,
                elevation: 3,
                backgroundColor: Colors.white,
                flexibleSpace: FlexibleSpaceBar(
                  centerTitle: true,
                  title: Text("Raise a Ticket",
                      style: mainTextStyleBlack.copyWith(
                          fontWeight: FontWeight.bold, fontSize: 15)),
                ),
                leading: IconButton(
                  icon: const Icon(
                    Icons.arrow_back_ios_outlined,
                    color: Colors.black,
                  ),
                  tooltip: 'Back',
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
                            name!.split(' ').first ?? "User Name",
                            style: mainTextStyleBlack.copyWith(
                                fontSize: 12, fontWeight: FontWeight.bold),
                          ),
                          Text(
                            number ?? "",
                            style: mainTextStyleBlack.copyWith(fontSize: 12),
                          ),
                        ],
                      ),
                      SizedBox(
                        width: MediaQuery.of(context).size.width / 30,
                      ),
                      Padding(
                        padding: EdgeInsets.only(right: screenWidth / 30),
                        child: CircleAvatar(
                          backgroundColor: mainThemeColor,
                        ),
                      ),
                    ],
                  )
                ],
              ),
              SliverToBoxAdapter(
                child: Center(
                  child: Padding(
                    padding: EdgeInsets.only(top: screenHeight / 10),
                    child: Container(
                      height: screenHeight / 1.8, // Adjusted height
                      width: screenWidth / 1.2, // Adjusted width
                      decoration: BoxDecoration(
                        color: Colors.white70,
                        borderRadius: BorderRadius.circular(15),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.2),
                            blurRadius: 20,
                            spreadRadius: 5,
                          ),
                        ],
                      ),
                      child: Column(
                        children: [
                          // SizedBox(height: screenWidth*0.1,),
                          Container(
                            height: screenHeight / 9, // Adjusted height
                            width: screenWidth / 1.2,
                            decoration: BoxDecoration(
                              color: mainThemeColor,
                              borderRadius: BorderRadius.only(
                                topRight: Radius.circular(15),
                                topLeft: Radius.circular(15),
                              ),
                            ),
                            child: Column(
                              
                              children: [
                                Row(
                                  // mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    GestureDetector(
                                      onTap: () {
                                        Navigator.of(context).pop();
                                      },
                                      child:  Padding(
                                        padding:  EdgeInsets.only(top: screenHeight/75,left: screenWidth/1.38),
                                        child: Icon(Icons.close),
                                      ),
                                    ),
                                  ],
                                ),
                                Center(
                                  child: Text('Raise a Ticket',
                                      style: mainTextStyle.copyWith(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 20)),
                                ),
                              ],
                            ),
                          ),
                          !value.isTicketSubmitted?
                            Padding(
                              padding: const EdgeInsets.all(20.0),
                              child: Column(
                                children: [
                                  //////////
                                  Form(
                                    key: _formKey,
                                    child: Column(children: [
                                      SizedBox(
                                        height: screenHeight/13,
                                        width: screenWidth/1.2,
                                        child: TextFormField(
                                          validator: (value) => value!.isEmpty
                                              ? '*Required'
                                              : null,
                                          controller: SubjectController,
                                          onChanged: (value) {
                                            Provider.of<LocationProvider>(context,
                                                    listen: false)
                                                .setTicketSubject(value);
                                          },
                                          decoration: InputDecoration(
                                              hintText: 'Subject',
                                              enabledBorder:
                                                  const UnderlineInputBorder(
                                                borderSide: BorderSide(
                                                    color: Color.fromARGB(
                                                        255, 218, 216, 216)),
                                              ),
                                              hintStyle: mainTextStyleBlack
                                                  .copyWith(fontSize: 16)),
                                        ),
                                      ),
                                      SizedBox(
                                        height: screenHeight/13,
                                        width: screenWidth/1.2,
                                        child: TextFormField(
                                          validator: (value) => value!.isEmpty
                                              ? '*Required'
                                              : null,
                                          controller: DescriptionController,
                                          onChanged: (value) {
                                            Provider.of<LocationProvider>(context,
                                                    listen: false)
                                                .setTicketDescription(value);
                                          },
                                          decoration: InputDecoration(
                                              hintText: 'Description',
                                              enabledBorder:
                                                  const UnderlineInputBorder(
                                                borderSide: BorderSide(
                                                    color: Color.fromARGB(
                                                        255, 218, 216, 216)),
                                              ),
                                              hintStyle: mainTextStyleBlack
                                                  .copyWith(fontSize: 16)),
                                        ),
                                      ),
                                    ]),
                                  ),
                                  ///////////////
                                  InkWell(
                                    onTap: () {
                                      showImageSourceDialog(context);
                                    },
                                    child: Container(
                                      alignment: Alignment.centerLeft,
                                      height: screenHeight /
                                          12.5, // Adjusted height
                                      width: screenWidth / 1.3,
                                      decoration: BoxDecoration(

                                          // border: Border(
                                          //   bottom: BorderSide(
                                          //     color: Colors.grey.shade600,
                                          //   ),
                                          // ),
                                          ),
                                      // padding: const EdgeInsets.symmetric(
                                      //     horizontal: ),
                                      child: Row(
                                        children: [
                                          Text('Upload Image',
                                              style: mainTextStyleBlack
                                                  .copyWith(fontSize: 16)),
                                          const Spacer(),
                                        image !=
                                    null
                                ? Image.file(
                                  image!,
                                    height: 45,
                                  )
                                : SizedBox(),
                                          IconButton(
                                            onPressed: () {
                                              showImageSourceDialog(context);
                                            },
                                            icon: Icon(
                                              Icons.camera_alt,
                                              color: Colors.grey,
                                            ),

                                            // size: 30,
                                            color: Colors.grey.shade600,
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                  Divider(
                                      thickness: 1,
                                      color:
                                          Color.fromARGB(255, 218, 216, 216)),
                                  SizedBox(
                                    height:
                                        screenHeight / 20, // Adjusted height
                                  ),
                                  SizedBox(
                                    height:
                                        screenHeight / 18, // Adjusted height
                                    width: screenWidth / 3.5, // Adjusted width
                                    child: ElevatedButton(
                                      onPressed: () async {
                                        
                                        if (_formKey.currentState!.validate()) {
                                          value.updateLoader(true,context);
                                          final prefs = await SharedPreferences
                                              .getInstance();
                                          // ignore: unused_local_variable
                                          String? firebase_Id =
                                              prefs.getString('Firebase_Id');
                                          var status = await UploadTicket(
                                              firebase_Id,
                                              curretService?.id,
                                              addresSResult,
                                              SubjectController.text,
                                              DescriptionController.text,
                                              currentTime,
                                              path == null ? gallpick : path);

                                          if (status == 200) {
                                            value.updateIsTicketSubmitted(true);
                                          }
                                           value.updateLoader(false,context);
                                        }
                                      },
                                      style: ElevatedButton.styleFrom(
                                        backgroundColor: mainThemeColor,
                                        elevation: 10,
                                        shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(30.0),
                                        ),
                                      ),
                                      child: Text(
                                        'Submit',
                                        style: mainTextStyleBlack.copyWith(
                                            color: Colors.white, fontSize: 16),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            )
                          :
                            Column(
                              children: [
                                SizedBox(height: screenHeight / 20),
                                SizedBox(
                                  width: screenWidth / 1.6,
                                  height: screenHeight / 6.7,
                                  child: Card(
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    color: const Color.fromARGB(
                                        255, 210, 254, 166),
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceEvenly,
                                        children: const [
                                          Text(
                                            'Hello!',
                                            style: TextStyle(fontSize: 15),
                                          ),
                                          Text(
                                            'Your Ticket has been accepted!',
                                            style: TextStyle(fontSize: 15),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                                SizedBox(height: screenHeight / 40),
                                CircleAvatar(
                                  radius: screenWidth / 13.5,
                                  backgroundColor:
                                      Color.fromARGB(255, 210, 254, 166),
                                  child: Icon(
                                    Icons.done,
                                    size: 28,
                                    color: Colors.white70,
                                  ),
                                )
                              ],
                            ),

                          ///////////////////////
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
// }

// class RaiseTicketAppBar extends StatelessWidget {
//    RaiseTicketAppBar({
//     super.key,
//     required this.screenWidth,
//   });

//   final double screenWidth;
// // String? name;
// // String? number;
//   @override
//   Widget build(BuildContext context) {
//     return 
//   }
// }
