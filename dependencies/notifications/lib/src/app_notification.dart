import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:flutter/foundation.dart';

import 'constants.dart';
import 'i_notification_listener.dart';


class AppNotification {
  AppNotification._i();

  static AppNotification i = AppNotification._i();

  factory AppNotification() => i;
  INotificationListener? listener;

  Future<void> initialize() async {
    if (kIsWeb) return;
    await AwesomeNotifications().initialize(
      null,
      [
        NotificationChannel(
          channelGroupKey: ChanelGroupKeyConstants.ALARM,
          channelKey: ChanelKeyConstants.ALARM,
          channelName: ChanelNameConstants.ALARM,
          channelShowBadge: true,
          enableVibration: true,
          playSound: true,
          locked: true,
          importance: NotificationImportance.Max,
          channelDescription: 'Alarm notification',
          soundSource: SoundConstants.ALARM_SOUND_1,
          defaultRingtoneType: DefaultRingtoneType.Alarm,
        ),
        NotificationChannel(
          channelGroupKey: ChanelGroupKeyConstants.LOCAL_NOTIFY,
          channelKey: ChanelKeyConstants.LOCAL_NOTIFY,
          channelName: ChanelNameConstants.LOCAL_NOTIFY,
          channelShowBadge: false,
          playSound: true,
          enableVibration: false,
          locked: false,
          importance: NotificationImportance.Max,
          channelDescription: 'App notification',
        ),
        NotificationChannel(
          channelGroupKey: ChanelGroupKeyConstants.LOCAL_NOTIFY,
          channelKey: ChanelKeyConstants.QUOTE_NOTIFY,
          channelName: ChanelNameConstants.QUOTE_NOTIFY,
          channelShowBadge: false,
          playSound: true,
          enableVibration: false,
          locked: false,
          importance: NotificationImportance.Max,
          channelDescription: 'Quote notification',
          soundSource: SoundConstants.ALARM_SOUND_1,
        ),
      ],
      channelGroups: [
        NotificationChannelGroup(
            channelGroupkey: ChanelGroupKeyConstants.ALARM, channelGroupName: ChanelGroupNameConstants.ALARM),
        NotificationChannelGroup(
            channelGroupkey: ChanelGroupKeyConstants.LOCAL_NOTIFY,
            channelGroupName: ChanelGroupNameConstants.LOCAL_NOTIFY),
      ],
      debug: kDebugMode,
    );
  }

  Future requestNotifyPermission() async {
    bool? isNotifyAllow = await AwesomeNotifications().isNotificationAllowed();
    if (isNotifyAllow == true) return;
    AwesomeNotifications().requestPermissionToSendNotifications();
  }

  Future requestNotifyFullScreen() async {
    // AwesomeNotifications()
    //     .requestPermissionToSendNotifications(channelKey: ChanelKeyConstants.ALARM, permissions: [
    //   NotificationPermission.FullScreenIntent,
    //   NotificationPermission.Vibration,
    //   NotificationPermission.CriticalAlert
    // ]);
  }

  void setDisplayListener(INotificationListener l) {
    if (listener != null) return;
    listener = l;
    AwesomeNotifications().displayedStream.listen((ReceivedNotification received) {

      l.onDisplayed(received);
      l.saveListNotification(received);
    });

    AwesomeNotifications().createdStream.listen((event) {

    });

    AwesomeNotifications().dismissedStream.listen((event) {

    });


    AwesomeNotifications().actionStream.listen((ReceivedNotification received) {

      l.onAction(received);
    });
  }

  Future<void> logout() async {
    await AwesomeNotifications().cancelAllSchedules();
  }

  Future<void> removeBadge() async {
    await AwesomeNotifications().resetGlobalBadge();
  }
}
