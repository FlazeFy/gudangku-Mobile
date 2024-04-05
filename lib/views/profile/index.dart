import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:gudangku/modules/global/style.dart';
import 'package:gudangku/views/history/index.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  StateProfilePageState createState() => StateProfilePageState();
}

class StateProfilePageState extends State<ProfilePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: ListView(
      padding: const EdgeInsets.only(top: spaceJumbo),
      children: [
        Container(
          margin: const EdgeInsets.symmetric(horizontal: spaceMD),
          decoration: BoxDecoration(
              border: Border.all(color: primaryColor, width: spaceMini / 2),
              borderRadius: const BorderRadius.all(Radius.circular(roundedLG))),
          child: ListTile(
            onTap: () => Get.to(const HistoryPage()),
            leading: const FaIcon(FontAwesomeIcons.clockRotateLeft,
                color: whiteColor),
            title: const Text('History',
                style:
                    TextStyle(color: whiteColor, fontWeight: FontWeight.w500)),
          ),
        )
      ],
    ));
  }
}
