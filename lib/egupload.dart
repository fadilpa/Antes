// // ignore_for_file: file_names, camel_case_types, use_build_context_synchronously, depend_on_referenced_packages
// import 'package:dio/dio.dart';
// import 'package:flutter/material.dart';
// import 'package:image_picker/image_picker.dart';
// import 'package:provider/provider.dart';
// import 'package:shared_preferences/shared_preferences.dart';
// import 'dart:io';


// class Photo_Upload extends StatefulWidget {
//   const Photo_Upload({super.key, this.image});
//   final image;

//   @override
//   State<Photo_Upload> createState() => _Photo_UploadState();
// }

// class _Photo_UploadState extends State<Photo_Upload> {
//   File? _image;
//   late String cropimage;
//   String? _title, _caption, phone;
//   // OverlayType _overlayType = OverlayType.grid;
//   final _discription = TextEditingController();
//   final _titleController = TextEditingController();
//   final GlobalKey<FormState> _formkey = GlobalKey<FormState>();

//   bool isLoading = false;
//   late String progress;
//   // Uint8List? _croppedImage;

//   final _picker = ImagePicker();
//   // Implementing the image picker
//   Future<void> _openImagePicker() async {
//     final XFile? pickedImage =
//         await _picker.pickImage(source: ImageSource.gallery);
//     if (pickedImage != null) {
//       final imageBytes = await pickedImage.readAsBytes();
//       setState(() {
//         _image = File(pickedImage.path);
//       });
//     }
//   }

//   Future<void> _opencamera() async {
//     final XFile? pickedImage =
//         await _picker.pickImage(source: ImageSource.camera);
//     if (pickedImage != null) {
//       setState(() {
//         _image = File(pickedImage.path);
//       });
//     }
//   }

 

//   final dio = Dio();
//   // ignore: body_might_complete_normally_nullable, non_constant_identifier_names
//   Future<UploadImageModal?> Upload(
//     String caption,
//     String title,
//     filepath,
//   ) async {
//     print(caption + title + filepath);
//     print('aaaaaaaaaaaaaaaaaaaaa');
//     SharedPreferences prefs = await SharedPreferences.getInstance();
//     final retrieve = prefs.getString('access_token');
//     final formData = FormData.fromMap({
//       'description': caption,
//       'title': title,
//       'image': await MultipartFile.fromFile(filepath, filename: 'image'),
//     });
//     final response = await dio.post(
//       'https://thewhytalks.com/api/upload_post/image',
//       data: formData,
//       options: Options(headers: {'Authorization': 'Bearer $retrieve'}),
//       onSendProgress: (int sent, int total) {
//         String percentage = (sent / total * 100).toStringAsFixed(2);
//         setState(() {
//           progress = "$percentage % uploaded";
//           //update the progress
//         });
//       },
//     );
//     print(response.statusCode);
//     print('yyyyyyyyyyyyyy');
//     if (response.statusCode == 200) {
//       setState(() {
//         isLoading = false;
//       });
//       // getuserdetails();
//       context.read<FeedProvider>().updatePhotopost();
//       // context.read<FeedProvider>().updateUserdetails();

//       Navigator.push(context,
//           MaterialPageRoute(builder: ((context) => const ProfileBaseScreen())));
//       // Navigator.pop(context);
//       ScaffoldMessenger.of(context)
//           .showSnackBar(const SnackBar(content: Text('Upload Succesful')));
//     } else {
//       setState(() {
//         isLoading = false;
//       });
//       ScaffoldMessenger.of(context)
//           .showSnackBar(const SnackBar(content: Text('Check Your Internet')));
//       throw Exception();
//       // ignore: prefer_const_constructors
//     }
//   }

//   String dropdownvalue = 'Ystories';
//   var items = ['Ystories', 'Ynews'];
//   @override
//   Widget build(BuildContext context) {
//     return isLoading != true
//         ? SingleChildScrollView(
//             child: Form(
//               key: _formkey,
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   Row(
//                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                     children: [
//                       Row(
//                         children: const [
//                           Text(
//                             'Create Post',
//                             style: TextStyle(
//                                 fontSize: 20,
//                                 fontWeight: FontWeight.w400,
//                                 color: Colors.white),
//                           ),
//                         ],
//                       ),
//                       GestureDetector(
//                           onTap: () {
                            
//                             showModalBottomSheet(
//                               context: context,
//                               builder: (BuildContext context) {
//                                 return Container(
//                                   height: 200,
//                                   color: Colors.black,
//                                   child: Center(
//                                     child: Column(
//                                       crossAxisAlignment:
//                                           CrossAxisAlignment.start,
//                                       mainAxisAlignment:
//                                           MainAxisAlignment.center,
//                                       mainAxisSize: MainAxisSize.min,
//                                       children: <Widget>[
//                                         Center(
//                                           child: Container(
//                                               height: 10,
//                                               width: 50,
//                                               decoration: BoxDecoration(
//                                                   borderRadius:
//                                                       BorderRadius.circular(20),
//                                                   color: const Color.fromRGBO(
//                                                       47, 47, 47, 1))),
//                                         ),
//                                         Row(
//                                           children: [
//                                             const SizedBox(
//                                               width: 10,
//                                             ),
//                                             SizedBox(
//                                               height: 20,
//                                               width: 30,
//                                               child: Image.asset(
//                                                   'assets/Groupadd post.png'),
//                                             ),
//                                             const SizedBox(
//                                               width: 10,
//                                             ),
//                                             TextButton(
//                                               child: const Text(
//                                                 'Ystories',
//                                                 style: TextStyle(
//                                                     color: Colors.white),
//                                               ),
//                                               onPressed: () {
//                                                 print('1111111111111111111111111111');
                         
//                             if (_croppedFile != null) {
//                               print(_croppedFile);
//                               String caption = _discription.text;
//                               String title = _titleController.text;
//                               setState(() {
//                                 isLoading = true;
//                               });
//                               Upload(
//                                 title,
//                                 caption,
//                                 _croppedFile!.path,
//                               );
//                               _titleController.clear();
//                               _discription.clear();
//                               _image!.path;
//                               Navigator.pop(context);
//                             } else {
//                               String caption = _discription.text;
//                               String title = _titleController.text;

//                               Upload(
//                                 title,
//                                 caption,
//                                 _image!.path,
//                               );
//                               _titleController.clear();
//                               _discription.clear();
//                               _image!.path;
//                               Navigator.pop(context);
//                             }
//                                                 // String caption =
//                                                 //     _discription.text;
//                                                 // String title =
//                                                 //     _titleController.text;
//                                                 // setState(() {
//                                                 //   isLoading = true;
//                                                 // });
//                                                 // Upload(
//                                                 //   title,
//                                                 //   caption,
//                                                 //   _image!.path,
//                                                 // );
//                                                 // _titleController.clear();
//                                                 // _discription.clear();
//                                                 // _image!.path;
//                                                 // Navigator.pop(context);
//                                               },
//                                             ),
//                                           ],
//                                         ),
//                                         Row(
//                                           children: [
//                                             const SizedBox(
//                                               width: 10,
//                                             ),
//                                             SizedBox(
//                                               height: 20,
//                                               width: 30,
//                                               child: Image.asset(
//                                                   'assets/Groupadd post.png'),
//                                             ),
//                                             const SizedBox(
//                                               width: 10,
//                                             ),
//                                             TextButton(
//                                               child: const Text(
//                                                 'Ynews',
//                                                 style: TextStyle(
//                                                     color: Colors.white),
//                                               ),
//                                               onPressed: () =>
//                                                   Navigator.pop(context),
//                                             ),
//                                           ],
//                                         ),
//                                       ],
//                                     ),
//                                   ),
//                                 );
//                               },
//                             ).then((value) => value ?? false);
//                             // Map<String, String> body = {
//                             //   'description': _discription.text,
//                             //   'title': _titleController.text
//                             //   //'bio': _bioController.text,
//                             // };

//                             // setState(() {
//                             //   isLoading = true;
//                             // });
//                             // ImageUploadPost(
//                             //   body,
//                             //   _image!.path,
//                             // );
//                             // _titleController.clear();
//                             // _discription.clear();
//                           },
//                           child: Container(
//                             decoration: BoxDecoration(
//                                 borderRadius: BorderRadius.circular(15),
//                                 gradient: const LinearGradient(
//                                   begin: Alignment.topLeft,
//                                   end: Alignment(0.8, 1),
//                                   colors: <Color>[
//                                     Color.fromRGBO(25, 212, 182, 1),
//                                     Color.fromRGBO(38, 121, 193, 1),
//                                   ],
//                                 )),
//                             height: 40,
//                             width: 86,
//                             child: const Center(
//                               child: Text('Post'),
//                             ),
//                           ))
//                     ],
//                   ),
//                   const SizedBox(
//                     height: 25,
//                   ),
//                   Container(
//                     decoration: BoxDecoration(
//                       borderRadius: BorderRadius.circular(15),
//                       color: const Color.fromRGBO(47, 47, 47, 1),
//                     ),
//                     child: Padding(
//                       padding: const EdgeInsets.all(8.0),
//                       child: TextFormField(
//                         validator: (String? value) {
//                           if (value!.isEmpty) {
//                             return 'Please enter title';
//                           }
//                           return null;
//                         },
//                         onSaved: (String? value) {
//                           _title = value;
//                         },
//                         controller: _titleController,
//                         //maxLines: 5,
//                         style: const TextStyle(
//                             color: Color.fromRGBO(114, 114, 114, 1)),
//                         decoration: const InputDecoration(
//                           hintStyle: TextStyle(
//                               color: Color.fromRGBO(114, 114, 114, 1)),
//                           hintText: 'Enter your title',
//                           border: InputBorder.none,
//                         ),
//                       ),
//                     ),
//                   ),
//                   const SizedBox(
//                     height: 10,
//                   ),
//                   Container(
//                     decoration: BoxDecoration(
//                       borderRadius: BorderRadius.circular(15),
//                       color: const Color.fromRGBO(47, 47, 47, 1),
//                     ),
//                     height: 131,
//                     width: double.infinity,
//                     child: Padding(
//                       padding: const EdgeInsets.all(8.0),
//                       child: TextFormField(
//                         validator: (String? value) {
//                           if (value!.isEmpty) {
//                             return 'Please enter caption';
//                           }
//                           return null;
//                         },
//                         onSaved: (String? value) {
//                           _caption = value;
//                         },
//                         controller: _discription,
//                         maxLines: 5,
//                         style: const TextStyle(
//                             color: Color.fromRGBO(114, 114, 114, 1)),
//                         decoration: const InputDecoration(
//                           hintStyle: TextStyle(
//                               color: Color.fromRGBO(114, 114, 114, 1)),
//                           hintText: 'What do you want to talk about ?',
//                           border: InputBorder.none,
//                         ),
//                       ),
//                     ),
//                   ),
//                   const SizedBox(height: 10),
//                   GestureDetector(
//                     onTap: () {
//                       _openImagePicker();
//                     },
//                     child: Container(
//                         decoration: BoxDecoration(
//                           borderRadius: BorderRadius.circular(15),
//                           color: const Color.fromRGBO(47, 47, 47, 1),
//                         ),
//                         height: 300,
//                         width: double.infinity,
//                         // child: Image.file(image!.path)
//                         child: _croppedFile != null
//                             ? Image.file(File(_croppedFile!.path))
//                             : _image != null
//                                 ? Image.file(
//                                     _image!,
//                                     fit: BoxFit.cover,
//                                   )
//                                 : const Center(
//                                     child: Icon(
//                                       Icons.add,
//                                       size: 100,
//                                     ),
//                                   )),
//                   ),
//                   _image != null
//                       ? ElevatedButton(
//                           child: const Text('Crop image'),
//                           onPressed: () async {
//                             _cropImage();
//                           },
//                         )
//                       : const SizedBox(),
//                   Row(
//                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                     children: [
//                       IconButton(
//                           onPressed: (() {
//                             _opencamera();
//                           }),
//                           icon: const Icon(
//                             Icons.camera_alt_sharp,
//                             color: Colors.white,
//                           )),
//                     ],
//                   ),
//                 ],
//               ),
//             ),
//           )
//         : AlertDialog(
//             elevation: 5,
//             backgroundColor: Colors.black,
//             title: Column(
//               children: [
//                 const Icon(
//                   Icons.image,
//                   color: Colors.white,
//                   size: 40,
//                 ),
//                 const Text(
//                   'Uploading....',
//                   style: TextStyle(color: Colors.amber),
//                 ),
//                 const SizedBox(
//                   height: 5,
//                 ),
//                 Text(
//                   progress,
//                   style: const TextStyle(color: Colors.amber),
//                 ),

//                 // const LinearProgressIndicator()
//               ],
//             ),
//             //  content: CircularProgressIndicator(),
//           );
//   }

// }