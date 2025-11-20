import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gudangku/modules/component/button.dart';
import 'package:gudangku/modules/component/others.dart';
import 'package:gudangku/modules/global/style.dart';
import 'package:gudangku/views/about/index.dart';
import 'package:gudangku/views/features/index.dart';
import 'package:gudangku/views/help/index.dart';
import 'package:gudangku/views/login/index.dart';

class FooterBar extends StatefulWidget {
  const FooterBar({key}) : super(key: key);

  @override
  FooterBarState createState() => FooterBarState();
}

class FooterBarState extends State<FooterBar> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin:
          const EdgeInsets.symmetric(vertical: spaceLG, horizontal: spaceXMD),
      child: Column(children: [
        getDivider(),
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            InkWell(
              child:
                  const ComponentButton(type: 'button_text', text: 'Features'),
              onTap: () {
                Get.to(const FeaturePage());
              },
            ),
            InkWell(
              child: const ComponentButton(type: 'button_text', text: 'Help'),
              onTap: () {
                Get.to(const HelpPage());
              },
            ),
            InkWell(
              child: const ComponentButton(type: 'button_text', text: 'About'),
              onTap: () {
                Get.to(const AboutPage());
              },
            ),
          ],
        )
      ]),
    );
  }
}
