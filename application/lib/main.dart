/// -----------------------------------
///          External Packages
/// -----------------------------------

import 'package:application/screens/starting.dart';
import 'package:flutter/material.dart';

import 'package:auth0_flutter/auth0_flutter.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:google_fonts/google_fonts.dart';

const appScheme = 'flutterdemo';

/// -----------------------------------
///           Profile Widget
/// -----------------------------------

class Profile extends StatelessWidget {
  final Future<void> Function() logoutAction;
  final UserProfile? user;

  const Profile(this.logoutAction, this.user, {final Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Container(
          width: 150,
          height: 150,
          decoration: BoxDecoration(
            border: Border.all(color: Colors.blue, width: 4),
            shape: BoxShape.circle,
            image: DecorationImage(
              fit: BoxFit.fill,
              image: NetworkImage(user?.pictureUrl.toString() ?? ''),
            ),
          ),
        ),
        const SizedBox(height: 24),
        Text('Name: ${user?.name}'),
        const SizedBox(height: 48),
        ElevatedButton(
          onPressed: () async {
            await logoutAction();
          },
          child: const Text('Logout'),
        ),
      ],
    );
  }
}

/// -----------------------------------
///            Login Widget
/// -----------------------------------

class Login extends StatelessWidget {
  final Future<void> Function() loginAction;
  final String loginError;

  const Login(this.loginAction, this.loginError, {final Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        SizedBox(
          width: 360,
          height: 48,
          child: DecoratedBox(
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
              onPressed: () async {
                await loginAction();
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors
                    .transparent, // Set button background color to transparent
                shadowColor:
                    Colors.transparent, // Set shadow color to transparent
              ),
              child: const Text(
                "Login/SignUp",
                style: TextStyle(
                  fontSize: 24,
                ),
              ),
            ),
          ),
        )
      ],
    );
  }
}

/// -----------------------------------
///                 App
/// -----------------------------------

void main() async {
  await dotenv.load(fileName: ".env");
  runApp(const Starting());
}

class MyApp extends StatefulWidget {
  const MyApp({final Key? key}) : super(key: key);

  @override
  _MyAppState createState() => _MyAppState();
}

/// -----------------------------------
///              App State
/// -----------------------------------

class _MyAppState extends State<MyApp> {
  Credentials? _credentials;
  late Auth0 auth0;

  bool isBusy = false;
  late String errorMessage;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Auth0 Demo',
      home: Scaffold(
        backgroundColor: const Color(0xff1D192B),
        body: Center(
          child: isBusy
              ? const CircularProgressIndicator()
              : _credentials != null
                  ? Profile(logoutAction, _credentials?.user)
                  : Login(loginAction, errorMessage),
        ),
      ),
    );
  }

  Future<void> loginAction() async {
    setState(() {
      isBusy = true;
      errorMessage = '';
    });

    try {
      final Credentials credentials =
          await auth0.webAuthentication(scheme: "application").login();

      print(credentials);

      setState(() {
        isBusy = false;
        _credentials = credentials;
      });
    } on Exception catch (e, s) {
      debugPrint('login error: $e - stack: $s');

      setState(() {
        isBusy = false;
        errorMessage = e.toString();
      });
    }
  }

  Future<void> logoutAction() async {
    await auth0.webAuthentication(scheme: "application").logout();

    setState(() {
      _credentials = null;
    });
  }

  @override
  void initState() {
    super.initState();

    auth0 = Auth0(dotenv.env['AUTH0_DOMAIN']!, dotenv.env['AUTH0_CLIENT_ID']!);
    errorMessage = '';
  }
}
