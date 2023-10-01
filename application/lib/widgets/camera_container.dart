import 'package:application/screens/picture_view.dart';
import 'package:camera/camera.dart';
import 'package:flutter/material.dart';

class CameraContainer extends StatelessWidget {
  const CameraContainer({
    super.key,
    required CameraController cameraController,
  }) : _cameraController = cameraController;

  final CameraController _cameraController;

  @override
  Widget build(BuildContext context) {
    return Container(
      clipBehavior: Clip.hardEdge,
      decoration: const BoxDecoration(
        borderRadius: BorderRadius.all(
          Radius.circular(30),
        ),
      ),
      child: Stack(
        alignment: Alignment.center,
        clipBehavior: Clip.hardEdge,
        children: [
          CameraPreview(_cameraController),
          Positioned(
            bottom: 12,
            child: GestureDetector(
              onTap: () async {
                // capture the image
                var pic = await _cameraController.takePicture();
                if (context.mounted) {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => PictureView(xFile: pic),
                    ),
                  );
                }
              },
              child: Container(
                clipBehavior: Clip.hardEdge,
                width: 82,
                height: 82,
                padding: EdgeInsets.all(10),
                decoration: BoxDecoration(
                    color: Colors.transparent,
                    shape: BoxShape.circle,
                    border: Border.all(width: 6, color: Colors.white)),
                child: Container(
                  decoration: const BoxDecoration(
                      shape: BoxShape.circle, color: Colors.white),
                ),
              ),
            ),
          ),
          Positioned(
            bottom: 24,
            right: 30,
            child: GestureDetector(
              child: const Column(
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Icon(Icons.grid_view, color: Colors.white, size: 40),
                  Text(
                    "Explore",
                    style: TextStyle(color: Colors.white),
                  )
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
