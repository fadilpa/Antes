import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:mentegoz_technologies/api/login_api.dart';
import 'package:mentegoz_technologies/controller/request_location_permissions.dart';
import 'dart:math' as math;

import 'package:mentegoz_technologies/controller/styles.dart';

// ignore: must_be_immutable
class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  ReqLocation reqlocation = ReqLocation();
  LocationPermission? permission;

  @override
  void initState() {
    super.initState();
    reqlocation.requestLocationPermission();
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
              decoration:  BoxDecoration(
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(20),
                  bottomRight: Radius.circular(20),
                ),
                color: mainThemeColor,
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
                      backgroundColor: mainThemeColor,
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
                  Text('WELCOME!!',
                      style: mainTextStyleBlack.copyWith(
                          fontWeight: FontWeight.bold,
                          fontSize: 34,
                          color: Colors.white)),
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
                          hintStyle: mainTextStyleBlack.copyWith(fontSize: 12)),
                      style: mainTextStyleBlack.copyWith(fontSize: 12)),
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
                          hintStyle: mainTextStyleBlack.copyWith(fontSize: 12)),
                      style: mainTextStyleBlack.copyWith(fontSize: 12)),
                  SizedBox(
                    height: headerHeight / 15,
                  ),
                  Align(
                    alignment: AlignmentDirectional.center,
                    child: Text("Forgot password?",
                        style: mainTextStyleBlack.copyWith(fontSize: 12)),
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
                                login(context);
                              },
                              style: ElevatedButton.styleFrom(
                                elevation: 10,
                                backgroundColor:
                                    mainThemeColor,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(30.0),
                                ),
                              ),
                              child: Text(
                                ' Login'.toUpperCase(),
                                style: mainTextStyle.copyWith(
                                    fontWeight: FontWeight.bold, fontSize: 13),
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
