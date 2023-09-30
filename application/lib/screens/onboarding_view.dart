import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class Onboarding extends StatelessWidget {
  const Onboarding({super.key, required this.title, required this.description});

  final String title;
  final String description;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(fontFamily: GoogleFonts.poppins().fontFamily),
      home: Scaffold(
        backgroundColor: const Color(0xff1D192B),
        body: SingleChildScrollView(
          child: Column(
            children: [
              Image.asset("images/Rectangle 1.png"),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 30),
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(bottom: 8.0),
                      child: Text(
                        title ?? "",
                        textAlign: TextAlign.left,
                        style: const TextStyle(
                            fontWeight: FontWeight.w700,
                            color: Color(0xff9483FF),
                            fontSize: 32,
                            letterSpacing: 0.1),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8.0),
                      child: Text(
                        description ?? " ",
                        style: const TextStyle(
                            color: Color(0xffD2CBFF),
                            fontSize: 20,
                            fontWeight: FontWeight.w400,
                            letterSpacing: 0.1),
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
        bottomNavigationBar: const Padding(
          padding: EdgeInsets.all(20.0),
          child: SizedBox(width: 348, height: 48, child: NextButton()),
        ),
      ),
    );
  }
}

class NextButton extends StatelessWidget {
  const NextButton({super.key});

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
        onPressed: () => print("Clicked"),
        style: ElevatedButton.styleFrom(
          backgroundColor:
              Colors.transparent, // Set button background color to transparent
          shadowColor: Colors.transparent, // Set shadow color to transparent
        ),
        child: Text(
          "Next",
          style: TextStyle(
              fontSize: 24, fontFamily: GoogleFonts.poppins().fontFamily),
        ),
      ),
    );
  }
}
