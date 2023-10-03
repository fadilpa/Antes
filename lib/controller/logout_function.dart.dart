import 'package:flutter/material.dart';
import 'package:mentegoz_technologies/controller/styles.dart';
import 'package:mentegoz_technologies/view/login_page.dart';
import 'package:shared_preferences/shared_preferences.dart';

Future<void> logout(BuildContext context) async {
  try {
    final prefs = await SharedPreferences.getInstance();
    prefs.clear();
    Navigator.of(context).pushReplacement(MaterialPageRoute(
      builder: (context) => LoginPage(),
    ));
  } catch (error) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Error'),
          content: Text('An error occurred. Please try again later.'),
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
}

class LogoutConfirmationDialog extends StatelessWidget {
  final Function onConfirm;

  LogoutConfirmationDialog({required this.onConfirm, this.isRadius = true});

  bool isRadius;
  
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text('Confirm Logout'),
      content: Text('Are you sure you want to\nLog out?'),
      actions: <Widget>[
        // No button
        ElevatedButton(
          child: Text('No'),
          style: ElevatedButton.styleFrom(
            backgroundColor: (mainThemeColor),
            shape: isRadius
                ? RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(32.0))
                : RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(2.0)),
          ),
          onPressed: () {
            Navigator.of(context).pop(); // Close the dialog
          },
        ),
        // Yes button
        ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: (mainThemeColor),
            shape: isRadius
                ? RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(32.0))
                : RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(2.0)),
          ),
          child: Text('Yes'),
          onPressed: () {
            // Execute the logout logic here
            onConfirm();
            Navigator.of(context).pop(); // Close the dialog
          },
        ),
      ],
    );
  }
}
