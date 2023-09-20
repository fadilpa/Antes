import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CustmButton extends StatelessWidget {
  const CustmButton(
      {super.key, required this.butoontext, required this.buttonaction});
  final String butoontext;

  final Function() buttonaction;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
        style: ElevatedButton.styleFrom(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(32.0)),
            minimumSize: const Size(143, 42),
            backgroundColor: (const Color.fromARGB(255, 60, 180, 229))),
        onPressed: buttonaction,
        child: Text(
          butoontext,
          style: GoogleFonts.montserrat(
              fontSize: 15, fontWeight: FontWeight.w400, color: Colors.white),
        ));
  }
}