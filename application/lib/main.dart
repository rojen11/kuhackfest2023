import 'package:application/screens/login_view.dart';
import 'package:application/screens/onboarding_view.dart';
import 'package:application/screens/splash_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

void main() async {
  await dotenv.load(fileName: ".env");
  runApp(const Onboarding(
    title: "Title 1",
    description: "description 1",
  ));
}
