import 'dart:async';
import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_timezone/flutter_timezone.dart';
import 'package:task_app/feature/task/model/task_model.dart';
import 'package:timezone/data/latest_all.dart' as tz;
import 'package:timezone/timezone.dart' as tz;

class LocalNotificationService {
  static FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();
  static StreamController<NotificationResponse> streamController =
      StreamController();
  static onTap(NotificationResponse notificationResponse) {
    streamController.add(notificationResponse);
  }

  static Future<void> init() async {
    InitializationSettings settings = const InitializationSettings(
      android: AndroidInitializationSettings('@mipmap/ic_launcher'),
      iOS: DarwinInitializationSettings(),
    );

    // Request permissions for iOS
    await flutterLocalNotificationsPlugin
        .resolvePlatformSpecificImplementation<
            IOSFlutterLocalNotificationsPlugin>()
        ?.requestPermissions(
          alert: true,
          badge: true,
          sound: true,
        );

    // Request permissions for macOS
    await flutterLocalNotificationsPlugin
        .resolvePlatformSpecificImplementation<
            MacOSFlutterLocalNotificationsPlugin>()
        ?.requestPermissions(
          alert: true,
          badge: true,
          sound: true,
        );

    await flutterLocalNotificationsPlugin.initialize(
      settings,
      onDidReceiveNotificationResponse: onTap,
      onDidReceiveBackgroundNotificationResponse: onTap,
    );
  }

  // Basic Notification Methods omitted for brevity

  // Scheduled Notification
  static Future<void> showScheduledNotification({
    required DateTime currentDate,
    required TimeOfDay scheduledTime,
    required TaskModel taskModel,
  }) async {
    const AndroidNotificationDetails android = AndroidNotificationDetails(
      'scheduled_notification',
      'Scheduled Notification',
      importance: Importance.max,
      priority: Priority.high,
    );
    NotificationDetails details = const NotificationDetails(
      android: android,
    );

    tz.initializeTimeZones();
    final String currentTimeZone = await FlutterTimezone.getLocalTimezone();
    tz.setLocalLocation(tz.getLocation(currentTimeZone));

    tz.TZDateTime scheduledDateTime = tz.TZDateTime(
      tz.local,
      currentDate.year,
      currentDate.month,
      currentDate.day,
      scheduledTime.hour,
      scheduledTime.minute,
    ).subtract(const Duration(minutes: 1));

    if (scheduledDateTime.isBefore(tz.TZDateTime.now(tz.local))) {
      // If the scheduled time is before the current time, add a day to ensure it's in the future
      scheduledDateTime = scheduledDateTime.add(const Duration(days: 1));
    }

    final tz.TZDateTime now = tz.TZDateTime.now(tz.local);

    log('Current Time: $now');
    log('Scheduled Time: $scheduledDateTime');

    await flutterLocalNotificationsPlugin.zonedSchedule(
      taskModel.title.hashCode,
      taskModel.title,
      taskModel.description,
      scheduledDateTime,
      details,
      payload: 'Title: ${taskModel.title}, Note: ${taskModel.description}',
      uiLocalNotificationDateInterpretation:
          UILocalNotificationDateInterpretation.absoluteTime,
    );
  }

  static Future<void> cancelNotification(int id) async {
    await flutterLocalNotificationsPlugin.cancel(id);
  }
}
