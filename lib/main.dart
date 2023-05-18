import 'dart:developer';
import 'dart:io';

import 'package:diasporacare/bootstrap.dart';
import 'package:diasporacare/diaspocare/diaspocare.dart';
import 'package:diasporacare/utils/_index.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  FlutterError.onError = (details) {
    log(details.exceptionAsString(), stackTrace: details.stack);
  };
  await Firebase.initializeApp();
  initialiseFirebaseMessaging();
  Bloc.observer = AppBlocObserver();
  runApp(MultiBlocProvider(
    providers: Singletons.registerCubits(),
    child: const Diaspocare(),
  ));
}

Future initialiseFirebaseMessaging() async {
  FirebaseMessaging messaging = FirebaseMessaging.instance;

  await messaging.requestPermission(
    alert: true,
    announcement: false,
    badge: true,
    carPlay: false,
    criticalAlert: false,
    provisional: false,
    sound: true,
  );

  FirebaseMessaging.onMessage.listen(receivedMessage);

  FirebaseMessaging.onMessageOpenedApp.listen(receivedMessageTwo);

  FirebaseMessaging.onBackgroundMessage(firebaseMessagingBackgroundHandler);
}

Future<void> receivedMessage(RemoteMessage remoteMessage) async {
  FlutterLocalNotificationsPlugin fltNotification;
  var androiInit =
      const AndroidInitializationSettings('@mipmap/ic_launcher'); //for logo
  var iosInit = const DarwinInitializationSettings();
  var initSetting = InitializationSettings(android: androiInit, iOS: iosInit);
  fltNotification = FlutterLocalNotificationsPlugin();
  fltNotification.initialize(
    initSetting,
  );
  var androidDetails = const AndroidNotificationDetails('1', 'channelName',
      channelDescription: 'channel Description');
  var iosDetails = const DarwinNotificationDetails();
  var generalNotificationDetails =
      NotificationDetails(android: androidDetails, iOS: iosDetails);

  final FirebaseMessaging firebaseMessaging = FirebaseMessaging.instance;
  if (Platform.isIOS) {
    await firebaseMessaging.requestPermission(
      alert: true,
      announcement: false,
      badge: true,
      carPlay: false,
      criticalAlert: false,
      provisional: false,
      sound: true,
    );
  }

  fltNotification.show(
      remoteMessage.notification.hashCode,
      remoteMessage.notification!.title,
      remoteMessage.notification!.body,
      generalNotificationDetails);
}

Future<void> receivedMessageTwo(
  RemoteMessage remoteMessage,
) async {
  // navigatorKey.currentState!.pushNamed('/homepage');
  // await BackgroundFunctions.getChannelAndPostCount();
}

Future<void> firebaseMessagingBackgroundHandler(RemoteMessage message) async {}
