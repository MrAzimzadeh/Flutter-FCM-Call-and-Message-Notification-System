import 'dart:math';

import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'firebase_options.dart';
import 'home_page.dart';

int getUniqueNotificationId() {
  var randomNumber = Random();
  var resultOne = randomNumber.nextInt(2000);
  var resultTwo = randomNumber.nextInt(100);
  if (resultTwo >= resultOne) resultTwo += 1;
  return resultTwo;
}

Future<void> backgroundHandler(RemoteMessage message) async {
  await handleNotification(message);
  return;
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  await AwesomeNotifications().initialize(
    null,
    [
      NotificationChannel(
        channelKey: 'call_channel',
        channelName: 'Calls',
        channelDescription: 'Notification channel for calls',
        defaultColor: Colors.orange,
        importance: NotificationImportance.High,
        ledColor: Colors.white,
        channelShowBadge: true,
      ),
      NotificationChannel(
        channelKey: 'message_channel',
        channelName: 'Messages',
        channelDescription: 'Notification channel for messages',
        defaultColor: Colors.blue,
        importance: NotificationImportance.Default,
        ledColor: Colors.white,
        channelShowBadge: true,
      ),
    ],
  );

  FirebaseMessaging.onBackgroundMessage(backgroundHandler);

  runApp(const MyApp());
}

Future<void> handleNotification(RemoteMessage message) async {
  String? title = message.notification?.title ?? 'Default Title';
  String? body = message.notification?.body ?? 'Default Body';
  String channelKey = message.data['channel_key'] ?? 'default_channel';

  if (channelKey == 'call_channel') {
    await AwesomeNotifications().createNotification(
      content: NotificationContent(
        id: getUniqueNotificationId(),
        channelKey: channelKey,
        color: Colors.white,
        title: title,
        body: body,
        category: NotificationCategory.Call,
        wakeUpScreen: true,
        fullScreenIntent: true,
        autoDismissible: false,
        backgroundColor: Colors.orange,
      ),
      actionButtons: [
        NotificationActionButton(
          key: 'ACCEPT',
          label: 'Accept Call',
          color: Colors.green,
          autoDismissible: true,
        ),
        NotificationActionButton(
          key: 'REJECT',
          label: 'Reject Call',
          color: Colors.redAccent,
          autoDismissible: true,
        ),
      ],
    );
  } else if (channelKey == 'message_channel') {
    await AwesomeNotifications().createNotification(
      content: NotificationContent(
        id: getUniqueNotificationId(),
        channelKey: channelKey,
        color: Colors.blue,
        title: title,
        body: body,
        category: NotificationCategory.Message,
        backgroundColor: Colors.blue,
        autoDismissible: true,
      ),
      actionButtons: [
        NotificationActionButton(
          key: 'READ',
          label: 'Read Message',
          color: Colors.green,
          autoDismissible: true,
        ),
        NotificationActionButton(
          key: 'DISMISS',
          label: 'Dismiss',
          color: Colors.red,
          autoDismissible: true,
        ),
      ],
    );
  }
  return;
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter FCM',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const HomePage(),
    );
  }
}
