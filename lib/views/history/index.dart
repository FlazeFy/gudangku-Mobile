import 'package:flutter/material.dart';
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
        body: ListView(
      padding:
          const EdgeInsets.only(top: spaceJumbo, left: spaceMD, right: spaceMD),
      children: [
        const Text(
          "History",
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: textXLG),
        ),
        GetAllHistory()
      ],
    ));
  }
}
