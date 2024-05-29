import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:http/http.dart' as http;
import 'package:googleapis_auth/auth_io.dart' as auth;

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    super.initState();
    setupFirebaseMessaging();
  }

  void setupFirebaseMessaging() {
    FirebaseMessaging.onMessage.listen((RemoteMessage message) async {
      await handleNotification(message);
    });

    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
      print('Notification clicked!');
    });
  }

  Future<void> handleNotification(RemoteMessage message) async {
    String? title = message.notification?.title ?? 'Default Title';
    String? body = message.notification?.body ?? 'Default Body';
    String channelKey = message.data['channel_key'] ?? 'default_channel';

    if (channelKey == 'call_channel') {
      await AwesomeNotifications().createNotification(
        content: NotificationContent(
          id: 123,
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
          id: 124,
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
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            InkWell(
              onTap: () async {
                String? token = await FirebaseMessaging.instance.getToken();
                print('FCM Token -> $token');
              },
              child: Container(
                width: 100,
                height: 100,
                decoration: BoxDecoration(
                  color: Colors.blue,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: const Center(child: Text("Get Token")),
              ),
            ),
            InkWell(
              onTap: () {
                sendNotification('message_channel');
              },
              child: Container(
                width: 100,
                height: 100,
                decoration: BoxDecoration(
                  color: Colors.blue,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: const Center(child: Text("Send Message Notification")),
              ),
            ),
            InkWell(
              onTap: () {
                sendNotification('call_channel');
              },
              child: Container(
                width: 100,
                height: 100,
                decoration: BoxDecoration(
                  color: Colors.green,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: const Center(child: Text("Send Call Notification")),
              ),
            ),
          ],
        ),
      ),
    );
  }

  final _scopes = ['https://www.googleapis.com/auth/firebase.messaging'];

  Future<void> sendNotification(String channelKey) async {
    try {
      final accountCredentials = auth.ServiceAccountCredentials.fromJson({
        'type': 'service_account',
        'project_id': '***',
        'private_key_id': '**',
        "private_key":
            "-----BEGIN PRIVATE KEY-----\***\n-----END PRIVATE KEY-----\n",
        'client_email':
            '**',
        'client_id': '***',
        'auth_uri': 'https://accounts.google.com/o/oauth2/auth',
        'token_uri': 'https://oauth2.googleapis.com/token',
        'auth_provider_x509_cert_url':
            'https://www.googleapis.com/oauth2/v1/certs',
        'client_x509_cert_url':
            'https://www.googleapis.com/robot/v1/metadata/x509/your-client-email'
      });

      final authClient =
          await auth.clientViaServiceAccount(accountCredentials, _scopes);
      final accessToken = await authClient.credentials.accessToken;

      final response = await http.post(
        Uri.parse(
            'https://fcm.googleapis.com/v1/projects/push-notification-34e5c/messages:send'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'Authorization': 'Bearer ${accessToken.data}',
        },
        body: jsonEncode({
          "message": {
            "token":
                "eX4yzcWxT3WPnItVcA7BQT:APA91bEftRk3A4oLHpZu7OCgyc9vc7II89W3rgGIXgb3UgVRIqc3yWVB2yI704DEiuolSTx81A-Gm1-8YmYLX5mcg9drR4tNZQ_AaPXH4VN76N0HSvOpewPXXT_-blpFS4njf3bJhVlC",
            "data": {
              "click_action": "FLUTTER_NOTIFICATION_CLICK",
              "id": "1",
              "status": "done",
              "channel_key": channelKey
            }
          }
        }),
      );

      print('Response status: ${response.statusCode}');
      print('Response body: ${response.body}');
    } catch (e) {
      print('Error sending notification: $e');
    }
  }
}
