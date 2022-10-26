import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:flutter/material.dart';

abstract class INotificationListener {
  BuildContext? context;

  INotificationListener({this.context});

  void onDisplayed(ReceivedNotification msg);

  void saveListNotification(ReceivedNotification msg);

  void onAction(ReceivedNotification msg) {}
}
