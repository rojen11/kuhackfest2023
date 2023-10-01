import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:flutter/material.dart';

import 'package:application/map/domain/usecases/notification.dart' as noti;

class NotificationImpl extends noti.Notification {
  NotificationImpl() {
    AwesomeNotifications().initialize(
        // set the icon to null if you want to use the default app icon
        null,
        [
          NotificationChannel(
              channelGroupKey: 'basic_channel_group',
              channelKey: 'basic_channel',
              channelName: 'Basic notifications',
              channelDescription: 'Notification channel',
              defaultColor: const Color(0xFF9D50DD),
              ledColor: Colors.white),
          NotificationChannel(
              channelGroupKey: 'scheduled',
              channelKey: 'scheduled',
              channelName: 'Scheduled notifications',
              channelDescription: 'Scheduled channel',
              defaultColor: const Color(0xFF9D50DD),
              ledColor: Colors.white)
        ],
        // Channel groups are only visual and are not required
        channelGroups: [
          NotificationChannelGroup(
              channelGroupKey: 'basic_channel_group',
              channelGroupName: 'Basic group'),
          NotificationChannelGroup(
              channelGroupKey: 'scheduled', channelGroupName: 'Scheduled group')
        ],
        debug: true);

    AwesomeNotifications().isNotificationAllowed().then((isAllowed) {
      if (!isAllowed) {
        // This is just a basic example. For real apps, you must show some
        // friendly dialog box before call the request method.
        // This is very important to not harm the user experience
        AwesomeNotifications().requestPermissionToSendNotifications();
      }
    });

    AwesomeNotifications().setListeners(
        onActionReceivedMethod: NotificationImpl.onActionReceivedMethod,
        onNotificationCreatedMethod:
            NotificationImpl.onNotificationCreatedMethod,
        onNotificationDisplayedMethod:
            NotificationImpl.onNotificationDisplayedMethod,
        onDismissActionReceivedMethod:
            NotificationImpl.onDismissActionReceivedMethod);
  }

  @override
  void sendNotification(String title, String description) {
    AwesomeNotifications().createNotification(
        content: NotificationContent(
          id: 10,
          channelKey: 'basic_channel',
          title: title,
          body: description,
        ),
        actionButtons: [
          NotificationActionButton(
              key: "Snooze",
              label: "Snooze",
              actionType: ActionType.DismissAction)
        ]);
  }

  /// Use this method to detect when a new notification or a schedule is created
  @pragma("vm:entry-point")
  static Future<void> onNotificationCreatedMethod(
      ReceivedNotification receivedNotification) async {
    // Your code goes here
  }

  /// Use this method to detect every time that a new notification is displayed
  @pragma("vm:entry-point")
  static Future<void> onNotificationDisplayedMethod(
      ReceivedNotification receivedNotification) async {
    // Your code goes here
  }

  /// Use this method to detect if the user dismissed a notification
  @pragma("vm:entry-point")
  static Future<void> onDismissActionReceivedMethod(
      ReceivedAction receivedAction) async {
    if (receivedAction.buttonKeyPressed == "Snooze") {
      debugPrint("Snoozing Notificatiion");

      String localTimeZone =
          await AwesomeNotifications().getLocalTimeZoneIdentifier();

      await AwesomeNotifications().createNotification(
        content: NotificationContent(
          id: 0,
          channelKey: 'scheduled',
          title: receivedAction.title,
          body: receivedAction.body,
        ),
        actionButtons: [
          NotificationActionButton(
              key: "Snooze",
              label: "Snooze",
              actionType: ActionType.DismissAction)
        ],
        schedule: NotificationInterval(interval: 60, timeZone: localTimeZone),
      );
    }
    // Your code goes here
  }

  /// Use this method to detect when the user taps on a notification or action button
  @pragma("vm:entry-point")
  static Future<void> onActionReceivedMethod(
      ReceivedAction receivedAction) async {
    // Your code goes here

    // Navigate into pages, avoiding to open the notification details page over another details page already opened
  }
}
