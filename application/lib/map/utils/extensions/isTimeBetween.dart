import 'package:flutter/material.dart';

bool isTimeBetween(TimeOfDay from, TimeOfDay to) {
  if (from == to) {
    return true;
  }

  double fromDeg = ((from.hour * 60 * 60 + from.minute * 60) / 86400) * 360;
  double toDeg = ((to.hour * 60 * 60 + to.minute * 60) / 86400) * 360;

  if (fromDeg > toDeg) {
    toDeg += 360;
  }

  DateTime currentTime = DateTime.now();

  double currentTimeDeg =
      ((currentTime.hour * 60 * 60 + currentTime.minute * 60) / 86400) * 360;

  if (currentTimeDeg > fromDeg && currentTimeDeg < toDeg) {
    return true;
  }

  return false;
}
