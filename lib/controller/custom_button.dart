import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mentegoz_technologies/controller/styles.dart';

class CustmButton extends StatelessWidget {
  const CustmButton(
      {super.key, required this.buttontext, required this.buttonaction});
  final String buttontext;

  final Function() buttonaction;

  @override
  Widget build(BuildContext context) {
        final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;
    return SizedBox(
      height: screenHeight/17,
      width: screenWidth/2.7,
      child: ElevatedButton(
    
          style: ElevatedButton.styleFrom(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(32.0)),
              
              backgroundColor: (mainThemeColor)),
          onPressed: buttonaction,
          child: Text(
            buttontext,
           style: mainTextStyleBlack.copyWith(color: Colors.white,
                        fontSize: 12)
          )),
    );
  }
}