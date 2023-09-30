import 'package:application/widgets/button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:url_launcher/url_launcher.dart';

class Starting extends StatelessWidget {
  const Starting({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: Container(
          decoration: const BoxDecoration(
              gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Color.fromRGBO(29, 25, 43, 0.0), // Transparent color at the top
              Color(0xFF1D192B), // Your desired color at the bottom
            ],
          )),
          child: Column(
            children: [
              const Row(
                children: [RoundedButton(), RoundedButton()],
              ),
              FlutterMap(
                options: MapOptions(
                  center: const LatLng(51.509364, -0.128928),
                  zoom: 9.2,
                ),
                nonRotatedChildren: [
                  RichAttributionWidget(
                    attributions: [
                      TextSourceAttribution(
                        'OpenStreetMap contributors',
                        onTap: () => launchUrl(
                            Uri.parse('https://openstreetmap.org/copyright')),
                      ),
                    ],
                  ),
                ],
                children: [
                  TileLayer(
                    urlTemplate:
                        'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
                    userAgentPackageName: 'com.example.app',
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
