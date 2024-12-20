import 'package:flutter/material.dart';
import 'package:gudangku/modules/component/appbar.dart';
import 'package:gudangku/modules/component/dialog/rest_time_dialog.dart';
import 'package:gudangku/modules/component/footerbar.dart';
import 'package:gudangku/modules/global/global.dart';
import 'package:gudangku/modules/global/style.dart';
import 'package:gudangku/views/notification/usecase/get_all_notification.dart';

class NotificationPage extends StatefulWidget {
  const NotificationPage({Key? key}) : super(key: key);

  @override
  StateNotificationPageState createState() => StateNotificationPageState();
}

class StateNotificationPageState extends State<NotificationPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: ComponentAppBar(
          title: 'Notification',
          isSubMenu: true,
          extraButton: [
            getRestTimeDialog('Notification', notificationFetchRestTime)
          ],
        ),
        body: ListView(
          padding: const EdgeInsets.only(
              top: spaceMD, left: spaceMD, right: spaceMD),
          children: const [GetAllNotification(), FooterBar()],
        ));
  }
}
