import 'package:flutter_app/services/app_storage.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:timezone/timezone.dart' as tz;

class NotificationService {
  static NotificationService? _shared;
  late final _storage = AppStorage.shared;
  final _notifications = FlutterLocalNotificationsPlugin();
  final _details = const NotificationDetails(
    android: AndroidNotificationDetails(
      "OPD Channel id",
      "End of task notification",
    ),
    iOS: IOSNotificationDetails(threadIdentifier: "OPD Channel id"),
  );

  static NotificationService get shared {
    if (_shared == null) {
      final value = NotificationService._();
      value._notifications.initialize(const InitializationSettings(
        android: AndroidInitializationSettings("@mipmap/ic_launcher"),
        iOS: IOSInitializationSettings(),
      ));
      _shared = value;
    }
    return _shared!;
  }

  NotificationService._();

  void setLocalNotification(DateTime time, String text) async {
    if (await _storage.getIsNotificationEnabled()) {
      _notifications.zonedSchedule(
        text.hashCode,
        "Таймер истек",
        text,
        tz.TZDateTime.from(time, tz.local),
        _details,
        androidAllowWhileIdle: true,
        uiLocalNotificationDateInterpretation:
        UILocalNotificationDateInterpretation.absoluteTime,
      );
    }
  }
}
