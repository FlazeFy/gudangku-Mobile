import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:gudangku/modules/component/appbar.dart';
import 'package:gudangku/modules/component/dialog/rest_time_dialog.dart';
import 'package:gudangku/modules/component/footerbar.dart';
import 'package:gudangku/modules/global/global.dart';
import 'package:gudangku/modules/global/style.dart';
import 'package:gudangku/views/about/index.dart';
import 'package:gudangku/views/history/index.dart';
import 'package:gudangku/views/profile/usecases/get_my_profile.dart';

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
            Container(
              margin: const EdgeInsets.only(
                  left: spaceMD, right: spaceMD, bottom: spaceMD),
              decoration: BoxDecoration(
                  border: Border.all(color: primaryColor, width: spaceMini / 2),
                  borderRadius:
                      const BorderRadius.all(Radius.circular(roundedLG))),
              child: ListTile(
                onTap: () => Get.to(const HistoryPage()),
                leading: const FaIcon(FontAwesomeIcons.clockRotateLeft,
                    color: whiteColor),
                title: const Text('History',
                    style: TextStyle(
                        color: whiteColor, fontWeight: FontWeight.w500)),
              ),
            ),
            Container(
              margin: const EdgeInsets.only(
                  left: spaceMD, right: spaceMD, bottom: spaceMD),
              decoration: BoxDecoration(
                  border: Border.all(color: primaryColor, width: spaceMini / 2),
                  borderRadius:
                      const BorderRadius.all(Radius.circular(roundedLG))),
              child: ListTile(
                onTap: () => Get.to(const AboutPage()),
                leading: const FaIcon(FontAwesomeIcons.circleInfo,
                    color: whiteColor),
                title: const Text('About',
                    style: TextStyle(
                        color: whiteColor, fontWeight: FontWeight.w500)),
              ),
            ),
          ],
        ));
  }
}
