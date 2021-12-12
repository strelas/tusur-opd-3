class NotificationService {
  static NotificationService? _shared;

  static NotificationService get shared {
    final value = _shared ?? NotificationService._();
    _shared = value;
    return value;
  }

  NotificationService._();

  void setLocalNotification(DateTime time, String text) {

  }
}