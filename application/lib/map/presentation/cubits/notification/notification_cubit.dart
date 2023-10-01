import 'package:application/map/domain/usecases/notification.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'notification_state.dart';

class NotificationCubit extends Cubit<NotificationState> {
  final Notification notification;

  NotificationCubit({required this.notification})
      : super(NotificationInitial());

  void sendNotification(String title, String description) {
    notification.sendNotification(title, description);
  }
}
