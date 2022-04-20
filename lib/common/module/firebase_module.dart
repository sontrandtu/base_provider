import 'dart:convert';

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:achitech_weup/common/core/base_function.dart';

/*
 * firebase_messaging: ^11.2.4
 * firebase_core: ^1.10.6
 * flutter_local_notifications: ^9.1.5
 * firebase_remote_config: ^1.0.3
*/
class FirebaseModule {
  // Khởi tạo module firebase
  static Future<void> installSDK() async {
    WidgetsFlutterBinding.ensureInitialized();
    await Firebase.initializeApp();
    FirebaseMessaging.onBackgroundMessage((RemoteMessage message) async {
      WidgetsFlutterBinding.ensureInitialized();
      await Firebase.initializeApp();
    });
  }

  // Lấy fcm token
  static Future<void> getFcmToken() async {
    String? fcmToken = await FirebaseMessaging.instance.getToken();
    if (fcmToken != null) {
      showLog(fcmToken);
    }
  }

  // Khi app đang mở
  static void pushNotification() {
    InitializationSettings initSetting = const InitializationSettings(
        android: AndroidInitializationSettings('@mipmap/ic_launcher'),
        iOS: IOSInitializationSettings());
    FlutterLocalNotificationsPlugin fltNotification = FlutterLocalNotificationsPlugin();
    fltNotification.initialize(initSetting,
        onSelectNotification: (s) => onSelectNotification?.call(s));

    var generalNotificationDetails = const NotificationDetails(
        android: AndroidNotificationDetails('1', 'push_notify_channel',
            channelDescription: 'your channel description',
            importance: Importance.max,
            priority: Priority.high,
            ticker: 'ticker'),
        iOS: IOSNotificationDetails());

    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      RemoteNotification? notification = message.notification;
      AndroidNotification? android = message.notification?.android;
      if (notification != null && android != null) {
        fltNotification.show(notification.hashCode, notification.title, notification.body,
            generalNotificationDetails,
            payload: jsonEncode(message.data));
      }
    });
  }

  //Khi app đóng và mở app
  static void pushNotificationOpenedApp() {
    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) async {
      onSelectNotificationOpenedApp?.call();
    });
  }

  //Khi app đóng và mở app
  static void initialMessage() {
    FirebaseMessaging.instance.getInitialMessage().then((RemoteMessage? message) {
      if (message != null) {
        onSelectNotificationOpenedApp?.call();
      }
    });
  }

  // Thực hiện một tác vụ nào đó khi app đang mở
  static Function(String? string)? onSelectNotification;

  // Thực hiện một tác vụ nào đó khi app từ background
  static Function? onSelectNotificationOpenedApp;

  // // Khởi tạo remote config
  // static Future<RemoteConfig> installRemoteConfig() async {
  //   final RemoteConfig remoteConfig = RemoteConfig.instance;
  //   RemoteConfigValue(null, ValueSource.valueStatic);
  //   await remoteConfig.setConfigSettings(RemoteConfigSettings(
  //       fetchTimeout: const Duration(seconds: 1), minimumFetchInterval: Duration.zero));
  //   await remoteConfig.fetchAndActivate();
  //   return remoteConfig;
  // }
  //
  // // lấy về data dạng json
  // Future<Map<String, dynamic>> getAllValue() async {
  //   final RemoteConfig remoteConfig = await installRemoteConfig();
  //   Map<String, dynamic> remoteData = remoteConfig.getAll();
  //   showLog("Remote config all data: " + jsonDecode(remoteData['data'].asString()).toString());
  //   return remoteData;
  // }
}
