import 'package:application/map/utils/extensions/location_checker.dart';
import 'package:flutter_background_service/flutter_background_service.dart';
import 'package:geolocator/geolocator.dart';

void startLocationService(ServiceInstance instance) async {
  instance.on('stopService').listen((event) {
    instance.stopSelf();
  });

  const LocationSettings locationSettings = LocationSettings(
    accuracy: LocationAccuracy.high,
    distanceFilter: 10,
  );

  // StreamSubscription<Position> positionStream =
  Geolocator.getPositionStream(locationSettings: locationSettings)
      .listen((Position? position) {
    if (position != null) {
      checkLocation(position);
    }
  });
}
