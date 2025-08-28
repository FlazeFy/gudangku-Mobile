import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gudangku/modules/global/style.dart';

class LoadingScreen extends StatelessWidget {
  const LoadingScreen({Key? key, required this.text}) : super(key: key);

  final String text;

  @override
  Widget build(BuildContext context) {
    double fullHeight = Get.height;
    double fullWidth = Get.width;

    return WillPopScope(
        onWillPop: () async {
          return Future.value(false);
        },
        child: Container(
            height: fullHeight,
            width: fullWidth,
            decoration: const BoxDecoration(color: darkColor),
            child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ClipRRect(
                    child: Image.asset('assets/icon/Logo.png', height: 75),
                  ),
                  const SizedBox(height: 40),
                  const CircularProgressIndicator(color: primaryColor)
                ])));
  }
}
