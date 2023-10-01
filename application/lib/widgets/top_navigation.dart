import 'package:application/screens/camera_view.dart';
import 'package:flutter/material.dart';

class TopNavigation extends StatelessWidget {
  const TopNavigation({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        CircleAvatar(
          backgroundColor: const Color.fromRGBO(125, 72, 249, 1),
          child: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: const Icon(Icons.arrow_back, color: Colors.white),
          ),
        ),
        CircleAvatar(
          backgroundColor: const Color.fromRGBO(125, 72, 249, 1),
          child: IconButton(
            onPressed: () {
              Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(
                    builder: (context) => CameraView(),
                  ),
                  (route) => false);
            },
            icon: const Icon(Icons.home, color: Colors.white),
          ),
        )
      ],
    );
  }
}
