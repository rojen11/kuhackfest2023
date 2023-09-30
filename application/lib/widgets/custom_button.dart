import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CustomButton extends StatelessWidget {
  const CustomButton(
      {super.key, required this.loginAction, required this.text});
  final String text;
  final Future<void> Function() loginAction;

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            Color(
                0xFF8A47F6), // Hex color code for Color.fromRGBO(138, 71, 246, 1)
            Color(
                0xFF644AFF), // Hex color code for Color.fromRGBO(100, 74, 255, 1)
            // Add more colors if needed
          ],
        ),
        borderRadius: BorderRadius.circular(30),
        boxShadow: const <BoxShadow>[],
      ),
      child: ElevatedButton(
        onPressed: () async {
          await loginAction();
        },
        style: ElevatedButton.styleFrom(
          backgroundColor:
              Colors.transparent, // Set button background color to transparent
          shadowColor: Colors.transparent, // Set shadow color to transparent
        ),
        child: Text(
          text,
          style: TextStyle(
              fontSize: 24, fontFamily: GoogleFonts.poppins().fontFamily),
        ),
      ),
    );
  }
}
