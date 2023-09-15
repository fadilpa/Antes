import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:mentegoz_technologies/homepage.dart';
import 'package:mentegoz_technologies/providerclass.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthService {
  Future<void> login(
      String email, String password, BuildContext context) async {
    final String apiUrl = 'https://antes.meduco.in/api/applogin';

    final response = await http.post(
      Uri.parse(apiUrl),
      body: {
        'email': email,
        'password': password,
      },
    );

    if (response.statusCode == 200) {
      final data = json.decode(response.body);

      if (data is List) {
        for (var userData in data) {
          final status = userData['data'][0]['status'];

          if (status == 'pending') {
            final firebaseId = data[0]["data"][0]["firebase_id"].toString();
            final firebaseIdProvider =
                Provider.of<FirebaseIdProvider>(context, listen: false);
            firebaseIdProvider.setFirebaseId(firebaseId);

            // Save login status using SharedPreferences
            final prefs = await SharedPreferences.getInstance();
            prefs.setBool('isLoggedIn', true);

            Navigator.of(context)
                .push(MaterialPageRoute(builder: (context) => HomePage()));
            return;
          }
        }
        _showWrongPasswordAlert(context);
      }
    } else {
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
                Navigator.of(context).pop(); // Close the alert
              },
              child: Text('OK'),
            ),
          ],
        );
      },
    );
  }
}
