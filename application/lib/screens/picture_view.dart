import 'package:application/constants.dart';
import 'package:application/screens/share_view.dart';
import 'package:camera/camera.dart';
import 'package:flutter/material.dart';

import 'dart:io';

class PictureView extends StatelessWidget {
  final XFile xFile;
  const PictureView({super.key, required this.xFile});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromRGBO(29, 25, 43, 1),
      body: Center(
        child: Stack(
          alignment: Alignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 16, right: 16),
              child: ClipRRect(
                borderRadius: const BorderRadius.all(Radius.circular(30)),
                child: Image.file(File(xFile.path)),
              ),
            ),
            Positioned(
              top: 10,
              left: 30,
              child: CircleAvatar(
                backgroundColor: buttonColor,
                child: IconButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  icon: const Icon(Icons.close, color: Colors.white),
                ),
              ),
            ),
            Positioned(
              bottom: 20,
              right: 30,
              child: ElevatedButton(
                  onPressed: () {
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
                          borderRadius:
                              BorderRadius.all(Radius.circular(100)))),
                  child: const Text(
                    "Share",
                    style: TextStyle(color: Colors.white, fontSize: 20),
                  )),
            )
          ],
        ),
      ),
    );
  }
}
