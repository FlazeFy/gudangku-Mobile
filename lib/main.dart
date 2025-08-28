import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:gudangku/modules/api/user/model/commands.dart';
import 'package:gudangku/modules/api/user/service/commands.dart';
import 'package:gudangku/modules/component/background/loading.dart';
import 'package:gudangku/modules/component/navbar.dart';
import 'package:gudangku/modules/global/global.dart';
import 'package:gudangku/modules/global/style.dart';
import 'package:gudangku/modules/helpers/generator.dart';
import 'package:gudangku/views/login/index.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

bool shouldUseFirestoreEmulator = false;

Future<void> fireFCMHandler(RemoteMessage message) async {
  // await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp();
}

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  FirebaseMessaging.onBackgroundMessage(fireFCMHandler);
  await FlutterLocalNotificationsPlugin()
      .resolvePlatformSpecificImplementation<
          AndroidFlutterLocalNotificationsPlugin>()
      ?.createNotificationChannel(channel);

  await FirebaseMessaging.instance.setForegroundNotificationPresentationOptions(
    alert: true,
    badge: true,
    sound: true,
  );

  //FlutterError.onError = FirebaseCrashlytics.instance.recordFlutterFatalError;
  FlutterError.onError = (errorDetails) {
    FirebaseCrashlytics.instance.recordFlutterFatalError(errorDetails);
  };
  PlatformDispatcher.instance.onError = (error, stack) {
    FirebaseCrashlytics.instance.recordError(error, stack, fatal: true);
    return true;
  };

  final prefs = await SharedPreferences.getInstance();
  if (prefs.containsKey("token_key")) {
    runApp(const MyApp(signed: true));
  } else {
    runApp(const MyApp(signed: false));
  }
}

class MyApp extends StatefulWidget {
  const MyApp({super.key, required this.signed});
  final bool signed;

  @override
  MyAppState createState() => MyAppState();
}

class MyAppState extends State<MyApp> {
  UserCommandsService? userService;

  @override
  void initState() {
    super.initState();
    userService = UserCommandsService();

    var initializationSettingsAndroid =
        const AndroidInitializationSettings('@mipmap/ic_launcher');
    var initializationSettings =
        InitializationSettings(android: initializationSettingsAndroid);
    FlutterLocalNotificationsPlugin().initialize(initializationSettings);

    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      RemoteNotification? notification = message.notification;
      AndroidNotification? android = message.notification?.android;
      if (notification != null && android != null) {
        FlutterLocalNotificationsPlugin().show(
            notification.hashCode,
            notification.title,
            notification.body,
            NotificationDetails(
              android: AndroidNotificationDetails(
                channel.id,
                channel.name,
                channelDescription: channel.description,
                color: primaryColor,
                enableLights: true,
                icon: "@mipmap/ic_launcher",
              ),
            ));
      }
    });

    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
      RemoteNotification? notification = message.notification;
      AndroidNotification? android = message.notification?.android;
      if (notification != null && android != null) {
        showDialog(
          context: context,
          builder: (_) {
            return AlertDialog(
              title: Text(notification.title ?? ""),
              content: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [Text(notification.body ?? "")],
                ),
              ),
            );
          },
        );
      }
    });

    getToken();
  }

  getToken() async {
    token = await FirebaseMessaging.instance.getToken();
  }

  @override
  Widget build(BuildContext context) {
    //Lock device on portrait
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);

    Widget getApp(Widget destination) {
      return GetMaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'GudangKu',
        theme: ThemeData(
          scaffoldBackgroundColor: darkColor,
          textTheme: const TextTheme(
            bodyLarge: TextStyle(color: whiteColor),
            bodyMedium: TextStyle(color: whiteColor),
          ),
          iconTheme: const IconThemeData(
            color: whiteColor,
          ),
          dialogTheme: const DialogTheme(
            backgroundColor: darkColor,
            titleTextStyle: TextStyle(
              color: whiteColor,
            ),
            contentTextStyle: TextStyle(
              color: whiteColor,
            ),
          ),
          dataTableTheme: const DataTableThemeData(
              dataTextStyle: TextStyle(color: whiteColor),
              headingTextStyle: TextStyle(
                  color: primaryColor,
                  fontWeight: FontWeight.w600,
                  letterSpacing: spaceMini / 2.2,
                  fontSize: textLG)),
          inputDecorationTheme: InputDecorationTheme(
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(roundedMD),
              borderSide: const BorderSide(color: primaryColor),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(roundedMD),
              borderSide: const BorderSide(color: successBG, width: 1.5),
            ),
          ),
        ),
        home: const LoginPage(),
      );
    }

    if (widget.signed) {
      return FutureBuilder<String?>(
        future: FirebaseMessaging.instance.getToken(),
        builder: (BuildContext context, AsyncSnapshot<String?> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const LoadingScreen(text: "Loading...");
          }
          if (snapshot.hasData) {
            String tokens = snapshot.data!;
            String timezone = getDeviceTimeZoneOffset();
            TimezoneFCMModel data =
                TimezoneFCMModel(firebaseFCMToken: tokens, timezone: timezone);
            userService?.putFirebase(data);

            return getApp(const BottomBar());
          } else {
            return const LoadingScreen(text: "Fetching token...");
          }
        },
      );
    } else {
      return getApp(const LoginPage());
    }
  }
}
