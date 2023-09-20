import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:mentegoz_technologies/homepage.dart';
import 'package:mentegoz_technologies/providerclass.dart';
import 'dart:math' as math;
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

// ignore: must_be_immutable
class LoginPage extends StatefulWidget {
  LoginPage({Key? key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  LocationPermission? permission;

  @override
  void initState() {
    super.initState();
    _requestLocationPermission();
  }

  Future<void> _requestLocationPermission() async {
    LocationPermission permissionResult;
    try {
      permissionResult = await Geolocator.requestPermission();
      setState(() {
        permission = permissionResult;
      });
    } catch (e) {
      // Handle any errors related to location permission
      print("Error requesting location permission: $e");
    }
  }

  final TextEditingController emailController = TextEditingController();

  final TextEditingController passwordController = TextEditingController();

  // final AuthService _authService = AuthService();
  void _showWrongPasswordAlert(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Wrong Password'),
          content:
              Text('The provided credentials are incorrect. Please try again.'),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // Close the alert
              },
              child: Text('OK'),
            ),
          ],
        );
      },
    );
  }

  Future<void> _login(BuildContext context) async {
    final String apiUrl = 'https://antes.meduco.in/api/applogin';
    final String email = emailController.text;
    final String password = passwordController.text;

    try {
      final dio = Dio();
      // final response = await dio.post(
      //   apiUrl,
      final options = Options(
        headers: {
          "Content-Type": "application/x-www-form-urlencoded; charset=UTF-8",
        },
      );

      // Define the request data (body)
      final data = {
        'email': email,
        'password': password,
      };

      final response = await dio.post(apiUrl, data: data, options: options);

      if (response.statusCode == 200) {
        final data = response.data;

        if (data is List) {
          for (var userData in data) {
            final status = userData['data'][0]['status'];

            if (status == 'pending') {
              final firebaseId = data[0]["data"][0]["firebase_id"].toString();
              final userName = data[0]["data"][0]["name"].toString();
              final mobileNumber = data[0]["data"][0]["mobile"].toString();
              print(firebaseId);
              final firebaseIdProvider =
                  Provider.of<FirebaseIdProvider>(context, listen: false);
              firebaseIdProvider.setFirebaseId(firebaseId);
              final nameProvider =
                  Provider.of<NameProvider>(context, listen: false);
              nameProvider.setuserName(userName);
              final mobileProvider =
                  Provider.of<MobileProvider>(context, listen: false);
              mobileProvider.setmobileNumber(mobileNumber);
              final prefs = await SharedPreferences.getInstance();
              prefs.setBool('isLoggedIn', true);
              prefs.setString('Firebase_Id', firebaseId);
              prefs.setString('Name', userName);
              prefs.setString('Mobile', mobileNumber);
              
              // print(userName);
              // print(mobileNumber);         
                   Navigator.of(context)
                  .push(MaterialPageRoute(builder: (context) => HomePage()));
              emailController.clear();
              passwordController.clear();
              return;
            }
          }
          _showWrongPasswordAlert(context);
        }
      } else {
        _showWrongPasswordAlert(context);
      }
    } catch (e) {
      print('Error: $e');
      _showWrongPasswordAlert(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    // final _formKey = GlobalKey<FormState>();
    final screenHeight = MediaQuery.of(context).size.height;

    final headerHeight = math.min(screenHeight * 0.5, 300.0);
    final containerHeight = math.min(screenHeight * 0.4, 400.0);

    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Stack(
        children: [
          Positioned(
            top: containerHeight * 0.001,
            right: containerHeight * 0.001,
            left: containerHeight * 0.001,
            child: Container(
              height: headerHeight * 1.1,
              decoration: const BoxDecoration(
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(20),
                  bottomRight: Radius.circular(20),
                ),
                color: Color.fromARGB(255, 61, 169, 231),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  SizedBox(
                    height: containerHeight / 5,
                  ),
                  CircleAvatar(
                    radius: headerHeight / 8.5,
                    backgroundColor: Colors.white,
                    child: CircleAvatar(
                      backgroundColor: Color.fromARGB(255, 61, 169, 231),
                      radius: containerHeight / 8.5,
                      child: Icon(
                        Icons.emoji_people_rounded,
                        color: Colors.white,
                        size: headerHeight / 6,
                      ),
                    ),
                  ),
                  SizedBox(
                    height: containerHeight / 20,
                  ),
                  Text(
                    'WELCOME!!',
                    style: TextStyle(
                      fontSize: 32,
                      fontWeight: FontWeight.w700,
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
            ),
          ),
          Positioned(
            top: headerHeight / 1.3,
            left: headerHeight * 0.01,
            right: headerHeight * 0.01,
            bottom: headerHeight / 3.7,
            child: Container(
              padding: const EdgeInsets.all(20),
              height: headerHeight,
              width: MediaQuery.of(context).size.width,
              margin: const EdgeInsets.symmetric(horizontal: 20.0),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(25.0),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.2),
                    blurRadius: 10,
                    spreadRadius: 5,
                  ),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: headerHeight / 8,
                  ),
                  TextFormField(
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter the email';
                      }
                      return null;
                    },
                    keyboardType: TextInputType.emailAddress,
                    cursorColor: Colors.black,
                    controller: emailController,
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: Color.fromARGB(255, 233, 233, 233),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(30),
                          borderSide: BorderSide.none),
                      prefixIcon: IconButton(
                        onPressed: () {},
                        icon: const Icon(Icons.email_outlined),
                        color: Colors.grey,
                      ),
                      hintText: 'Username/Email',
                      hintStyle: const TextStyle(color: Colors.grey),
                    ),
                    style: const TextStyle(color: Colors.black),
                  ),
                  SizedBox(
                    height: headerHeight / 15,
                  ),
                  TextFormField(
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter the password';
                      }
                      return null;
                    },
                    obscureText: true,
                    keyboardType: TextInputType.text,
                    cursorColor: Colors.black,
                    controller: passwordController,
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: Color.fromARGB(255, 233, 233, 233),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(30),
                          borderSide: BorderSide.none),
                      prefixIcon: IconButton(
                        onPressed: () {},
                        icon: const Icon(Icons.key_rounded),
                        color: Colors.grey,
                      ),
                      hintText: 'Passsword',
                      hintStyle: const TextStyle(color: Colors.grey),
                    ),
                    style: const TextStyle(color: Colors.black),
                  ),
                  SizedBox(
                    height: headerHeight / 15,
                  ),
                  Align(
                    alignment: AlignmentDirectional.center,
                    child: Text(
                      "Forgot password?",
                      style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.w400,
                        color: Colors.grey,
                      ),
                    ),
                  ),
                  SizedBox(
                    height: headerHeight / 10,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Column(
                        children: [
                          SizedBox(
                            height: 50,
                            width: 200,
                            child: ElevatedButton(
                              onPressed: () {
                                _login(context);

                                // if (_formKey.currentState!.validate()) {
                                //   ScaffoldMessenger.of(context).showSnackBar(
                                //     const SnackBar(
                                //         content: Text('Processing Data')),
                                //   );
                                // }
                              },
                              style: ElevatedButton.styleFrom(
                                elevation: 10,
                                backgroundColor:
                                    Color.fromARGB(255, 60, 180, 229),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(30.0),
                                ),
                              ),
                              child: Text(
                                ' Login'.toUpperCase(),
                              ),
                            ),
                          ),
                          SizedBox(
                            height: headerHeight / 15,
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
