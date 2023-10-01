import 'package:application/map/data/repositories/database_repository_impl.dart';
import 'package:application/map/domain/models/task.dart';
import 'package:application/map/domain/repositories/database_repository.dart';
import 'package:application/map/infrastructure/usecases/notification_impl.dart';
import 'package:application/map/utils/extensions/calculate_distance.dart';
import 'package:application/map/utils/extensions/isTimeBetween.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:application/map/domain/usecases/notification.dart' as noti;

void checkLocation(Position location) async {
  DatabaseRepository databaseRepository = DatabaseRepositoryImpl();

  List<Task> tasks = await databaseRepository.fetchAllTask();

  noti.Notification notification = NotificationImpl();

  for (var task in tasks) {
    double distance = calculateDistance(
        task.lat, task.long, location.latitude, location.longitude);

    if (distance < (task.radius ?? 0)) {
      if (task.from == null || task.to == null) {
        notification.sendNotification(task.location ?? "", task.memo ?? "");
        return;
      }

      TimeOfDay current =
          TimeOfDay(hour: DateTime.now().hour, minute: DateTime.now().minute);

      if (isTimeBetween(task.from ?? current, task.to ?? current)) {
        notification.sendNotification(task.location ?? "", task.memo ?? "");
      }
    }
  }
}
