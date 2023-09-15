// Implement your logout function here
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:mentegoz_technologies/loginpage.dart';

Future<void> _logout(BuildContext context) async {
  final String apiUrl =
      'https://antes.meduco.in/api/applogin'; // Replace with your API logout URL

  try {
    final response = await http.post(
      Uri.parse(apiUrl),
      // Add any necessary headers or parameters for your API call
    );

    if (response.statusCode == 200) {
      // Successfully logged out, navigate to the login page
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(
          builder: (context) => LoginPage(), // Replace with your login page
        ),
      );
    } else {
      // Handle API error cases
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Logout Failed'),
            content: Text('Unable to logout. Please try again.'),
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
  } catch (error) {
    // Handle any exceptions that occur during the API call
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Error'),
          content: Text('An error occurred. Please try again later.'),
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
