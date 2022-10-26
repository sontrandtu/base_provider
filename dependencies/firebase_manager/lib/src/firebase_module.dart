import 'dart:convert';
import 'dart:developer';

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:notifications/notifications.dart';


import '../firebase_options.dart';

/*
 * firebase_messaging: ^11.2.4
 * firebase_core: ^1.10.6
 * firebase_remote_config: ^1.0.3
*/
Future<void> _installBackground(RemoteMessage message) async {
  await Firebase.initializeApp();

  print(jsonEncode(message.data));
  // NotificationManager().push(
  //     title: notification?.title,
  //     body: notification?.body,
  //     data: {ChanelKeyConstants.LOCAL_NOTIFY: jsonEncode(message.data)});
  // showLog('_installBackground: $_installBackground');
}

class FirebaseModule {
  FirebaseModule._internal();

  static FirebaseModule i = FirebaseModule._internal();

  factory FirebaseModule() => i;

  // Khởi tạo module firebase
  Future<void> installSDK() async {
    await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

    await FirebaseMessaging.instance.requestPermission(alert: true, sound: true, criticalAlert: true);
    await FirebaseMessaging.instance
        .setForegroundNotificationPresentationOptions(alert: true, sound: true, badge: true);
    FirebaseMessaging.onBackgroundMessage(_installBackground);
  }

  // Lấy fcm token
  Future<String> getFCMToken() async {
    try {
      String? fcmToken = await FirebaseMessaging.instance.getToken();

      if (fcmToken == null) return '';
      log('FCM Authentication: $fcmToken');
      return fcmToken;
    } catch (e) {
      log('getFCMToken: Đã có lỗi xảy ra khi lấy FCM token.\n$e');
      return '';
    }
  }

  // Khi app đang mở [Foreground message]
  void listenForegroundNotification() {
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      RemoteNotification? notification = message.notification;
      log('onMessage');
      NotificationManager().push(
          title: notification?.title,
          body: notification?.body,
          data: {ChanelKeyConstants.LOCAL_NOTIFY: jsonEncode(message.data)});
    });
  }

  //Khi app đã bị kill và mở lại app, thực hiện các điều hướng
  void initialMessage({Function(RemoteMessage message)? onInitialMsg}) {
    FirebaseMessaging.instance.getInitialMessage().then((RemoteMessage? message) {
      if (message == null) return;
      log(message.toString());
      onInitialMsg?.call(message);
    });
    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage? message) {
      if (message == null) return;
      log(message.toString());
      onInitialMsg?.call(message);
    });
  }

}
