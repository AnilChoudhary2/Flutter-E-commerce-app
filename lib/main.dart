import 'dart:developer';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:yahmart/splash_screen.dart';
import 'package:yahmart/utils/app_theme.dart';
import 'package:yahmart/utils/shared_preferences.dart';
import 'firebase_options.dart';

SpUtil? sp;

///it's trigger when app in the background and killed(terminate)
Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  await Firebase.initializeApp();
  log('A Background message just showed up :  ${message.messageId}');
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  sp = await SpUtil.getInstance();
  SystemChannels.textInput.invokeMethod('TextInput.hide');

  ///it's trigger when app in the background and killed(terminate)
  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);

  ///given firebase foreground notification presentation
  FirebaseMessaging.instance.setForegroundNotificationPresentationOptions(
      alert: true, badge: false, sound: true);

  ///create flutter firebase notification instance
  FirebaseMessaging messaging = FirebaseMessaging.instance;

  ///requesting permission for fcm notification
  NotificationSettings settings = await messaging.requestPermission(
    alert: true,
    announcement: false,
    badge: false,
    carPlay: false,
    criticalAlert: false,
    provisional: false,
    sound: true,
  );

  ///print log of user current notification permission
  if (settings.authorizationStatus == AuthorizationStatus.authorized) {
    log('User granted permission');
  } else if (settings.authorizationStatus == AuthorizationStatus.provisional) {
    log('User granted provisional permission');
  } else {
    log('User declined or has not accepted permission');
  }

  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp])
      .then((_) {
    runApp(const MyApp());
  });
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    Future.delayed(Duration.zero, () {
      setupFirebase();
    });
    super.initState();
  }

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Yahmart',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.lightTheme,
      home: const SplashScreen(),
    );
  }

  setupFirebase() async {
    ///getting firebase fcm token
    FirebaseMessaging.instance.getToken().then((value) {
      if (value != null) {
        log("Device Token $value");
        sp!.putString(SpUtil.deviceFcmToken, value);
      }
    });

    ///it's trigger when app in the foreground
    FirebaseMessaging.onMessage.listen((RemoteMessage? message) {
      // RemoteNotification notification = message!.notification!;
    });

    ///it's trigger when app in the background mode and user click on notification plate
    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage? message) {});

    ///get initial message when app is lunch
    FirebaseMessaging.instance
        .getInitialMessage()
        .then((RemoteMessage? message) {
      if (message != null) {
        log("get initial message data  ====>  ${message.data.toString()}");
      }
    });
  }
}
