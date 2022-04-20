import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class NotificationModule {
  static NotificationModule? _module;
  Function? onSelectNotification;
  late FlutterLocalNotificationsPlugin _fltNotification;
  late NotificationDetails _generalNotificationDetails;

  static NotificationModule get instance => _getInstance();

  static NotificationModule _getInstance() {
    _module ??= NotificationModule();
    _module?.initNotification();
    return _module!;
  }

  void initNotification() {
    InitializationSettings initSetting = const InitializationSettings(
        android: AndroidInitializationSettings('@mipmap/ic_launcher'),
        iOS: IOSInitializationSettings());
    _fltNotification = FlutterLocalNotificationsPlugin();
    _fltNotification.initialize(initSetting,
        onSelectNotification: (s) => onSelectNotification?.call(s));

    _generalNotificationDetails = const NotificationDetails(
        android: AndroidNotificationDetails('1', 'push_notify_channel',
            channelDescription: 'your channel description',
            importance: Importance.max,
            priority: Priority.high,
            ticker: 'ticker'),
        iOS: IOSNotificationDetails());
  }

  void show(int id, String? title, String? body, {String? payload}) {
    _fltNotification.show(id, title, body, _generalNotificationDetails, payload: payload);
  }
}
