import 'package:application/screens/camera_view.dart';
import 'package:application/screens/login_view.dart';
import 'package:application/widgets/login.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

void main() async {
  await dotenv.load(fileName: ".env");
  runApp(CameraView());

}
