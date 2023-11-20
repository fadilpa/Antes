import 'package:flutter/material.dart';
import 'package:mentegoz_technologies/controller/Provider/shared_pref_provider.dart';
import 'package:mentegoz_technologies/home_page.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:dio/dio.dart';
import 'dart:io';

final TextEditingController emailController = TextEditingController();
final TextEditingController passwordController = TextEditingController();

Future<void> login(BuildContext context) async {
//   try {
//   final result = await InternetAddress.lookup('example.com');
//   if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
//     print('connected');
//   }
// } on SocketException catch (_) {
//   print('not connected');
// }
  bool isStartButtonTapped = false; // Initially, assume the button is not tapped

  final String apiUrl = 'http://antesapp.com/api/applogin';
  final String email = emailController.text;
  final String password = passwordController.text;

  try {
    final dio = Dio();
    // final options = Options(
    //   headers: {
    //     "Content-Type": "multipart/form-data; charset=UTF-8",
    //   },
    // );
    final data = FormData.fromMap({
      'email': email,
      'password': password,
    });

    final response = await dio.post(apiUrl, data: data);

    if (response.statusCode == 200) {
      print(response.data);
      print("fghj,nk");
      final data = response.data;

      if (data is List) {
        for (var userData in data) {
          print("gfhjkl;");
          final status =  data[0]["data"][0]['status'];

          if (status == 'active') {
            final firebaseId = data[0]["data"][0]["firebase_id"].toString();
           
            final userName = data[0]["data"][0]["name"].toString();
            final mobileNumber = data[0]["data"][0]["emp_no"]??"".toString();
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
            Navigator.of(context)
                .pushReplacement(MaterialPageRoute(builder: (context) => HomePage(initialButtonStatus: isStartButtonTapped,)));
            emailController.clear();
            passwordController.clear();
            return;
          }
        }
        _showNetworkError(context);
      }
    } else {
      _showNetworkError(context);
    }
  } catch (e) {
    print('Error: $e');
    _showWrongPasswordAlert(context);
  }
}

void _showNetworkError(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Network Error'),
          content:
              Text('Poor Network Connection or No Internet!'),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('OK'),
            ),
          ],
        );
      },
    );
  }

void _showWrongPasswordAlert(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Wrong Password or No Network'),
          content:
              Text('Check Your Credentials.\nOr No Internet!'),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('OK'),
            ),
          ],
        );
      },
    );
  }
