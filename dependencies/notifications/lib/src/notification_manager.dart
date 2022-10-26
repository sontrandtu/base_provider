import 'package:awesome_notifications/awesome_notifications.dart';


import 'constants.dart';

class NotificationManager {
  NotificationManager._internal();

  static final NotificationManager _i = NotificationManager._internal();

  factory NotificationManager() => _i;

  Future<void> push({
    String? title,
    String? body,
    Map<String, String>? data,
  }) async {
    NotificationContent content = NotificationContent(
      id: 1,
      channelKey: ChanelKeyConstants.LOCAL_NOTIFY,
      title: title,
      body: body ?? '',
      displayOnForeground: true,
      displayOnBackground: true,
      ticker: 'WeUp Platform Notification',
      autoDismissible: true,
      criticalAlert: true,
      notificationLayout: NotificationLayout.BigText,
      locked: false,
      category: NotificationCategory.Message,
      payload: data,
    );

    AwesomeNotifications().createNotification(content: content);

  }

  void dismiss(int? id){
    if(id == null) return;
    AwesomeNotifications().dismiss(id);
  }
  // void getNotificationCount(int? id){
  //   if(id == null) return;
  //   AwesomeNotifications().(id);
  // }

  Future<void> pushProgress({String? title, String? body, Map<String, String>? data, int? progress}) async {
    NotificationContent content = NotificationContent(
      id: 1,
      channelKey: ChanelKeyConstants.LOCAL_NOTIFY,
      title: title,
      body: body ?? '',
      displayOnForeground: true,
      displayOnBackground: true,
      ticker: 'WeUp Platform Notification',
      autoDismissible: true,
      criticalAlert: true,
      notificationLayout: NotificationLayout.ProgressBar,
      locked: false,
      category: NotificationCategory.Progress,
      progress: progress,
      payload: data,
    );

    AwesomeNotifications().createNotification(content: content);
  }
}
