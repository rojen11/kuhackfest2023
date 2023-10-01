import 'package:flutter/material.dart';

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
