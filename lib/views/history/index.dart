import 'package:flutter/material.dart';
import 'package:gudangku/modules/component/appbar.dart';
import 'package:gudangku/modules/component/dialog/rest_time_dialog.dart';
import 'package:gudangku/modules/component/footerbar.dart';
import 'package:gudangku/modules/global/global.dart';
import 'package:gudangku/modules/global/style.dart';
import 'package:gudangku/views/history/usecase/get_all_history.dart';

class HistoryPage extends StatefulWidget {
  const HistoryPage({Key? key}) : super(key: key);

  @override
  StateHistoryPageState createState() => StateHistoryPageState();
}

class StateHistoryPageState extends State<HistoryPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: ComponentAppBar(
          title: 'History',
          isSubMenu: true,
          extraButton: [getRestTimeDialog('History', historyFetchRestTime)],
        ),
        body: ListView(
          padding: const EdgeInsets.only(
              top: spaceJumbo, left: spaceMD, right: spaceMD),
          children: const [GetAllHistory(), FooterBar()],
        ));
  }
}
