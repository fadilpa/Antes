// Implement your logout function here
import 'package:flutter/material.dart';
import 'package:mentegoz_technologies/login_functions.dart';
import 'package:mentegoz_technologies/loginpage.dart';
import 'package:shared_preferences/shared_preferences.dart';

Future<void> logout(BuildContext context) async {

  final String apiUrl =
      'https://antes.meduco.in/api/applogin'; // Replace with your API logout URL
  final String email = emailController.text;
  final String password = passwordController.text;
  try {
 
    final prefs = await SharedPreferences.getInstance();
    prefs.clear();
     Navigator.of(context).pushReplacement(
        MaterialPageRoute(
          builder: (context) => LoginPage(), // Replace with your login page
      ) );

  //  final dio = Dio();
  //   final options = Options(
  //     headers: {
  //       "Content-Type": "application/x-www-form-urlencoded; charset=UTF-8",
  //     },
  //   );
  //   final data = {
  //     'email': email,
  //     'password': password,
  //   };

  //   final response = await dio.post(apiUrl, data: data, options: options);

  //   if (response.statusCode == 200) {
  //     // Successfully logged out, navigate to the login page
  //     Navigator.of(context).pushReplacement(
  //       MaterialPageRoute(
  //         builder: (context) => LoginPage(), // Replace with your login page
  // //       ),
  // //     );
  //   } else {
  //     // Handle API error cases
  //     showDialog(
  //       context: context,
  //       builder: (BuildContext context) {
  //         return AlertDialog(
  //           title: Text('Logout Failed'),
  //           content: Text('Unable to logout. Please try again.'),
  //           actions: <Widget>[
  //             TextButton(
  //               onPressed: () {
  //                 Navigator.of(context).pop(); // Close the alert
  //               },
  //               child: Text('OK'),
  //             ),
  //           ],
  //         );
  //       },
  //     );
  //   }
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
