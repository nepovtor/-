import 'package:flutter_local_notifications/flutter_local_notifications.dart';

/// Service handling local notifications for reminders.
class NotificationService {
  NotificationService();

  final FlutterLocalNotificationsPlugin _plugin =
      FlutterLocalNotificationsPlugin();

  Future<void> init() async {
    const android = AndroidInitializationSettings('@mipmap/ic_launcher');
    const ios = DarwinInitializationSettings();
    const settings = InitializationSettings(android: android, iOS: ios);
    await _plugin.initialize(settings);
  }

  Future<void> scheduleReminder(
    int id,
    String title,
    String body,
    DateTime scheduledDate,
  ) async {
    const androidDetails = AndroidNotificationDetails(
      'reminders',
      'Reminders',
      importance: Importance.max,
      priority: Priority.high,
    );
    const iosDetails = DarwinNotificationDetails();
    const details = NotificationDetails(
      android: androidDetails,
      iOS: iosDetails,
    );
    await _plugin.schedule(
      id,
      title,
      body,
      scheduledDate,
      details,
      androidAllowWhileIdle: true,
    );
  }

  Future<void> scheduleRepeatingReminder(
    int id,
    String title,
    String body,
    RepeatInterval interval,
  ) async {
    const androidDetails = AndroidNotificationDetails(
      'reminders',
      'Reminders',
      importance: Importance.max,
      priority: Priority.high,
    );
    const iosDetails = DarwinNotificationDetails();
    const details = NotificationDetails(
      android: androidDetails,
      iOS: iosDetails,
    );
    await _plugin.periodicallyShow(
      id,
      title,
      body,
      interval,
      details,
      androidAllowWhileIdle: true,
    );
  }
}

