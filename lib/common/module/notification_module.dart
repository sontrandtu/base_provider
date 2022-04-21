import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:timezone/data/latest_all.dart' as tz;
import 'package:timezone/timezone.dart' as tz;

class NotificationModule {
  NotificationModule._internal();

  static NotificationModule get instance => NotificationModule._internal();

  Function? onSelectNotification;

  late FlutterLocalNotificationsPlugin _fltNotification;
  late NotificationDetails _generalNotificationDetails;

  void initNotification() {
    InitializationSettings initSetting = const InitializationSettings(
        android: AndroidInitializationSettings('@mipmap/ic_launcher'), iOS: IOSInitializationSettings());
    _fltNotification = FlutterLocalNotificationsPlugin();
    _fltNotification.initialize(initSetting, onSelectNotification: (s) => onSelectNotification?.call(s));

    _generalNotificationDetails = const NotificationDetails(
        android: AndroidNotificationDetails('1', 'push_notify_channel',
            channelDescription: 'your channel description',
            importance: Importance.max,
            priority: Priority.high,
            ticker: 'ticker'),
        iOS: IOSNotificationDetails());
  }

  Future<void> schedule({String? id, String? title, String? body, tz.TZDateTime? scheduledTime}) async {
    tz.initializeTimeZones();
    tz.setLocalLocation(tz.local);

    var androidSpecifics = AndroidNotificationDetails(id ?? '-1', 'Scheduled notification',
        channelDescription: 'A scheduled notification', icon: 'icon');

    var iOSSpecifics = const IOSNotificationDetails();
    var platformChannelSpecifics = NotificationDetails(android: androidSpecifics, iOS: iOSSpecifics);

    await _fltNotification.zonedSchedule(int.parse(id ?? '-1'), title, body,
        scheduledTime ?? tz.TZDateTime.now(tz.local), platformChannelSpecifics,
        androidAllowWhileIdle: true,
        uiLocalNotificationDateInterpretation: UILocalNotificationDateInterpretation.absoluteTime);

  }

  void show(int id, String? title, String? body, {String? payload}) {
    _fltNotification.show(id, title, body, _generalNotificationDetails, payload: payload);
  }
}
