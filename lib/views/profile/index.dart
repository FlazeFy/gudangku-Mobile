import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:gudangku/modules/component/appbar.dart';
import 'package:gudangku/modules/component/button.dart';
import 'package:gudangku/modules/component/dialog/rest_time_dialog.dart';
import 'package:gudangku/modules/global/global.dart';
import 'package:gudangku/modules/global/style.dart';
import 'package:gudangku/views/about/index.dart';
import 'package:gudangku/views/history/index.dart';
import 'package:gudangku/views/lend/index.dart';
import 'package:gudangku/views/profile/usecases/get_my_profile.dart';
import 'package:gudangku/views/profile/usecases/post_sign_out.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  StateProfilePageState createState() => StateProfilePageState();
}

class StateProfilePageState extends State<ProfilePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: ComponentAppBar(
            title: 'My Profile',
            isSubMenu: false,
            extraButton: [
              getRestTimeDialog('My Profile', historyFetchRestTime)
            ]),
        body: ListView(
          padding: const EdgeInsets.only(top: spaceJumbo),
          children: [
            const GetMyProfile(),
            ComponentButton(
                type: "button_tile",
                text: "Lend Inventory",
                icon: FontAwesomeIcons.handshakeSimple,
                action: () => Get.to(const LendPage())),
            ComponentButton(
                type: "button_tile",
                text: "History",
                icon: FontAwesomeIcons.clockRotateLeft,
                action: () => Get.to(const HistoryPage())),
            ComponentButton(
                type: "button_tile",
                text: "About",
                icon: FontAwesomeIcons.circleInfo,
                action: () => Get.to(const AboutPage())),
            const PostSignOut()
          ],
        ));
  }
}
