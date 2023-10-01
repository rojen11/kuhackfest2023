import 'dart:io';

import 'package:application/constants.dart';
import 'package:application/widgets/top_navigation.dart';
import 'package:camera/camera.dart';
import 'package:flutter/material.dart';

class ShareView extends StatelessWidget {
  const ShareView({super.key, required this.xFile});

  final XFile xFile;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromRGBO(29, 25, 43, 1),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(16),
        child: ElevatedButton(
          onPressed: () {

            // call api


            Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => ShareView(xFile: xFile),
                ));
          },
          style: ElevatedButton.styleFrom(
              padding: const EdgeInsets.only(
                  left: 20, right: 20, top: 10, bottom: 10),
              backgroundColor: buttonColor,
              shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(100)))),
          child: const Text(
            "Share",
            style: TextStyle(color: Colors.white, fontSize: 20),
          ),
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Container(
            padding: const EdgeInsets.all(16),
            child: Column(
              children: [
                TopNavigation(),
                const SizedBox(
                  height: 55,
                ),
                ClipRRect(
                  clipBehavior: Clip.hardEdge,
                  borderRadius: const BorderRadius.all(Radius.circular(30)),
                  child: Image.file(File(xFile.path), height: 400),
                ),
                SizedBox(
                  height: 24,
                ),
                const TextField(
                  style: TextStyle(
                    color: Colors.white,
                  ),
                  decoration: InputDecoration(
                    fillColor: Color.fromRGBO(51, 45, 65, 1),
                      hintText: "Enter your caption here....",
                      hintStyle: TextStyle(color: Colors.white)),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
