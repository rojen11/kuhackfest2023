import 'package:application/screens/home_view.dart';
import 'package:application/screens/login_view.dart';
import 'package:application/screens/onboarding_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

void main() async {
  await dotenv.load(fileName: ".env");
  WidgetsFlutterBinding.ensureInitialized();

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
      title: "Location Reminder",
      description: "Our app empowers you to effortlessly set location reminders. Never forget important tasks again; get notified when you're in the right place with our intuitive location reminder feature. ",
      onNext: (context) {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => Onboarding(
              title: "Explore Snaps",
              description: "Discover the world through a new lens! Our app lets you explore captivating snaps tied to your location reminders. Immerse yourself in the moment and relive memories with ease.",
              onNext: (context) {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => Onboarding(
                      title: "Experience",
                      description: "Experience endless fun and excitement while exploring our app! Dive into a world of captivating content, interactive features, and surprises that will keep you entertained.",
                      onNext: (context) {
                        Navigator.pushAndRemoveUntil(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const LoginView()),
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
