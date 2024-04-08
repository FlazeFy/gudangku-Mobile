import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gudangku/modules/component/navbar.dart';
import 'package:gudangku/modules/global/style.dart';
import 'package:gudangku/views/login/index.dart';
import 'package:shared_preferences/shared_preferences.dart';

bool shouldUseFirestoreEmulator = false;

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  final prefs = await SharedPreferences.getInstance();
  if (prefs.containsKey("token_key")) {
    runApp(MyApp(signed: true));
  } else {
    runApp(MyApp(signed: false));
  }
}

class MyApp extends StatelessWidget {
  MyApp({required this.signed});
  bool signed;

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'GudangKu',
      theme: ThemeData(
          scaffoldBackgroundColor: darkColor,
          textTheme: const TextTheme(
            bodyText1: TextStyle(color: whiteColor),
            bodyText2: TextStyle(color: whiteColor),
          ),
          dataTableTheme: const DataTableThemeData(
              dataTextStyle: TextStyle(color: whiteColor),
              headingTextStyle: TextStyle(
                  color: primaryColor,
                  fontWeight: FontWeight.w600,
                  letterSpacing: spaceMini / 2.2,
                  fontSize: textLG))),
      home: const LoginPage(),
    );
  }
}
