import 'package:application/widgets/camera_container.dart';
import 'package:camera/camera.dart';
import 'package:flutter/material.dart';

class CameraView extends StatefulWidget {
  const CameraView({super.key});

  @override
  State<CameraView> createState() => _CameraViewState();
}

class _CameraViewState extends State<CameraView> {
  late List<CameraDescription> _availableCameras;
  late CameraController _cameraController;
  bool initialized = false;

  @override
  void initState() {
    super.initState();

    startCamera();
  }

  void startCamera() async {
    _availableCameras = await availableCameras();

    _cameraController =
        CameraController(_availableCameras[0], ResolutionPreset.ultraHigh);

    _cameraController.initialize().then((value) {
      if (context.mounted) {
        setState(() {
          initialized = true;
        });
      }
    }).catchError((e) {
      print(e);
    });
  }

  @override
  void dispose() {
    super.dispose();
    _cameraController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        backgroundColor: const Color.fromRGBO(29, 25, 43, 1),
        body: Center(
          child: Padding(
            padding:
                const EdgeInsets.only(left: 16, top: 56, right: 16, bottom: 56),
            child: initialized
                ? CameraContainer(cameraController: _cameraController)
                : const Center(
                    child: CircularProgressIndicator(
                      color: Colors.white,
                    ),
                  ),
          ),
        ),
      ),
    );
  }
}
