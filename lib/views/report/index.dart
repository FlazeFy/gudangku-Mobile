import 'package:flutter/material.dart';
import 'package:gudangku/modules/component/appbar.dart';

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
        body: SizedBox());
  }
}
