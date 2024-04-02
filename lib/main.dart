import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gudangku/modules/component/navbar.dart';
import 'package:gudangku/modules/global/style.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

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
      home: const BottomBar(),
    );
  }
}
