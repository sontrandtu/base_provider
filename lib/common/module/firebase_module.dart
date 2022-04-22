import 'dart:convert';

import 'package:achitecture_weup/common/core/sys/base_function.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

/*
 * firebase_messaging: ^11.2.4
 * firebase_core: ^1.10.6
 * flutter_local_notifications: ^9.1.5
 * firebase_remote_config: ^1.0.3
*/

class FirebaseInterface {
  // Press notification when app opened
  Function(String? jsonEncode)? onSelectNotification;

  // Press notification when off app
  Function(RemoteMessage? remoteMessage)? onSelectNotificationOpenedApp;

  FirebaseInterface({this.onSelectNotification, this.onSelectNotificationOpenedApp});
}

class FirebaseModule {
  FirebaseModule._internal();

  static FirebaseModule get instance => FirebaseModule._internal();

  FirebaseInterface? interface;

  // Khởi tạo module firebase
  Future<void> installSDK() async {
    WidgetsFlutterBinding.ensureInitialized();
    await Firebase.initializeApp();
    FirebaseMessaging.onBackgroundMessage((RemoteMessage message) async {
      await Firebase.initializeApp();
    });
  }

  // Lấy fcm token
  Future<void> getFcmToken() async {
    String? fcmToken = await FirebaseMessaging.instance.getToken();
    if (fcmToken != null) {
      showLog(fcmToken);
    }
  }

  // Khi app đang mở
  void pushNotification() {
    InitializationSettings initSetting = const InitializationSettings(
        android: AndroidInitializationSettings('@mipmap/ic_launcher'), iOS: IOSInitializationSettings());
    FlutterLocalNotificationsPlugin fltNotification = FlutterLocalNotificationsPlugin();
    fltNotification.initialize(initSetting,
        onSelectNotification: (s) => interface?.onSelectNotification?.call(s));

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
        fltNotification.show(
            notification.hashCode, notification.title, notification.body, generalNotificationDetails,
            payload: jsonEncode(message.data));
      }
    });
  }

  //Khi app đóng và mở app
  void pushNotificationOpenedApp() {
    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) async {
      interface?.onSelectNotificationOpenedApp?.call(message);
    });
  }

  //Khi app đóng và mở app
  void initialMessage() {
    FirebaseMessaging.instance.getInitialMessage().then((RemoteMessage? message) {
      if (message != null) {
        interface?.onSelectNotificationOpenedApp?.call(message);
      }
    });
  }


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
