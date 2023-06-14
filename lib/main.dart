import 'dart:developer';

import 'package:diasporacare/bootstrap.dart';
import 'package:diasporacare/diaspocare/diaspocare.dart';
import 'package:diasporacare/utils/_index.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:device_preview/device_preview.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  FlutterError.onError = (details) {
    log(details.exceptionAsString(), stackTrace: details.stack);
  };
  await Firebase.initializeApp();
  initialiseFirebaseMessaging();
  SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
    systemNavigationBarColor: Colors.white70,
    systemNavigationBarIconBrightness: Brightness.dark,
    statusBarColor: Color(0x1A145DA0),
  ));
  Bloc.observer = AppBlocObserver();

  // runApp(MultiBlocProvider(
  //     providers: Singletons.registerCubits(),
  //     child: DevicePreview(
  //       enabled: true,
  //       builder: (context) => const Diaspocare(),
  //     )));

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

Future<void> receivedMessage(RemoteMessage remoteMessage) async {}

Future<void> receivedMessageTwo(
  RemoteMessage remoteMessage,
) async {}

Future<void> firebaseMessagingBackgroundHandler(RemoteMessage message) async {}
