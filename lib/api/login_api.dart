import 'package:flutter/material.dart';
import 'package:mentegoz_technologies/controller/Provider/shared_pref_provider.dart';
import 'package:mentegoz_technologies/home_page.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:dio/dio.dart';

final TextEditingController emailController = TextEditingController();
final TextEditingController passwordController = TextEditingController();

Future<void> login(BuildContext context) async {
  bool isStartButtonTapped = false; // Initially, assume the button is not tapped

  final String apiUrl = 'https://antes.meduco.in/api/applogin';
  final String email = emailController.text;
  final String password = passwordController.text;

  try {
    final dio = Dio();
    final options = Options(
      headers: {
        "Content-Type": "application/x-www-form-urlencoded; charset=UTF-8",
      },
    );
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
                Navigator.of(context).pop();
              },
              child: Text('OK'),
            ),
          ],
        );
      },
    );
  }
