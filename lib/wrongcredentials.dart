import 'package:flutter/material.dart';

class WrongPasswordPopup extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text('Wrong Password'),
      content: Text('The provided credentials are incorrect. Please try again.'),
      actions: <Widget>[
        TextButton(
          onPressed: () {
            Navigator.of(context).pop(); // Close the popup
          },
          child: Text('OK'),
        ),
      ],
    );
  }
}
