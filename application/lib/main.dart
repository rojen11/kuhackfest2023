import 'package:application/screens/home_view.dart';
import 'package:application/screens/login_view.dart';
import 'package:application/screens/onboarding_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

void main() async {
  await dotenv.load(fileName: ".env");
  runApp(
    OnboardingInit(),
  );
}

class OnboardingInit extends StatelessWidget {
  const OnboardingInit({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Onboarding(
      title: "Title 1",
      description: "description 1",
      onNext: (context) {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => Onboarding(
              title: "Title 2",
              description: "description 2",
              onNext: (context) {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => Onboarding(
                      title: "title 3",
                      description: "Description 3",
                      onNext: (context) {
                        Navigator.pushAndRemoveUntil(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const LoginView()
                            ),
                            (route) => false);
                      },
                    ),
                  ),
                );
              },
            ),
          ),
        );
      },
    );
  }
}
