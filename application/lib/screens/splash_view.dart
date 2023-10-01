import 'package:flutter/material.dart';

class Splash extends StatelessWidget {
  const Splash({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        home: Scaffold(
      body: Container(
          width: double.infinity,
          height: double.infinity,
          decoration: const BoxDecoration(
            gradient: LinearGradient(
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
          ),
          child: const Align(
            alignment: Alignment.center,
            child: Column(
              children: [],
            ),
          )),
    ));
  }
}
