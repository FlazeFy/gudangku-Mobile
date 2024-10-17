import 'package:flutter/material.dart';
import 'package:gudangku/modules/component/appbar.dart';

class CalendarPage extends StatefulWidget {
  const CalendarPage({Key? key}) : super(key: key);

  @override
  StateCalendarPageState createState() => StateCalendarPageState();
}

class StateCalendarPageState extends State<CalendarPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: const ComponentAppBar(title: 'Calendar', isSubMenu: false),
        body: SizedBox());
  }
}
