import 'dart:math';

import 'package:latlong2/latlong.dart';

double calculateDistance(lat1, long1, lat2, long2) {
  // calculate distance in meter

  lat1 = degToRadian(lat1);
  lat2 = degToRadian(lat2);
  long1 = degToRadian(long1);
  long2 = degToRadian(long2);

  return 1609.344 * (3963.0 *
      acos((sin(lat1) * sin(lat2)) +
          cos(lat1) * cos(lat2) * cos(long2 - long1))); // 1609.344 is to convert miles into meters
}
