import 'dart:async';
import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:firebase_core/firebase_core.dart';

/// Define a top-level named handler which background/terminated messages will
/// call.
///
/// To verify things are working, check out the native platform logs.
Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  // If you're going to use other Firebase services in the background, such as Firestore,
  // make sure you call `initializeApp` before using other Firebase services.
  await Firebase.initializeApp();
  print('Handling a background message ${message.messageId}');
}

class PushNotificationService {
  FirebaseMessaging messaging = FirebaseMessaging.instance;

  Future initialise() async {
    await Firebase.initializeApp();

     NotificationSettings settings = await messaging.requestPermission();
    print('Permission granted: ${settings.authorizationStatus}');

    // Handle foreground messages
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      print('Foreground message: ${message.notification?.title}');
      // You can show a dialog or a notification here
    });

    // Handle background and terminated app state
    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
      print('Message tapped!');
    });

    FirebaseMessaging.instance.getInitialMessage().then((RemoteMessage? message) {
      if (message != null) {
        print('App opened from terminated state!');
      }
    });

    // Get device token for sending notifications later
    String? token = await messaging.getToken();
    print('FCM Token: $token');

  }

  
}
