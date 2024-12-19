import 'package:flutter/material.dart';
import 'package:gudangku/modules/component/appbar.dart';
import 'package:gudangku/modules/component/footerbar.dart';
import 'package:gudangku/modules/global/style.dart';
import 'package:gudangku/views/report/usecases/filter.dart';
import 'package:gudangku/views/report/usecases/get_all_report.dart';

class ReportPage extends StatefulWidget {
  const ReportPage({Key? key}) : super(key: key);

  @override
  StateReportPageState createState() => StateReportPageState();
}

class StateReportPageState extends State<ReportPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: const ComponentAppBar(title: 'Report', isSubMenu: false),
        body: ListView(
          padding: const EdgeInsets.only(
              top: spaceJumbo, left: spaceMD, right: spaceMD),
          children: const [
            SizedBox(height: spaceMD),
            FilterReport(),
            SizedBox(height: spaceMD),
            GetAllReport(),
            FooterBar()
          ],
        ));
  }
}
