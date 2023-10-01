import 'package:geolocator/geolocator.dart';

Future<bool> handleLocationPermission() async {
  bool serviceEnabled;
  LocationPermission permission;
  
  serviceEnabled = await Geolocator.isLocationServiceEnabled();
  if (!serviceEnabled) {
    return false;
  }
  permission = await Geolocator.checkPermission();
  if (permission == LocationPermission.denied) {
    permission = await Geolocator.requestPermission();
    if (permission == LocationPermission.denied) {   
      return false;
    }
  }
  if (permission == LocationPermission.deniedForever) {
    return false;
  }

  if (permission != LocationPermission.always) {
    permission = await Geolocator.requestPermission();
  }

  if (permission != LocationPermission.always) {
    return false;
  }

  return true;
}