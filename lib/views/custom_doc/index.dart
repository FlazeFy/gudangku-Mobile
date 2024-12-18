import 'package:flutter/material.dart';
import 'package:gudangku/modules/component/appbar.dart';
import 'package:gudangku/modules/component/dialog/rest_time_dialog.dart';
import 'package:gudangku/modules/global/global.dart';
import 'package:gudangku/views/custom_doc/usecases/editor.dart';

class CustomDocPage extends StatefulWidget {
  const CustomDocPage({Key? key, required this.id, required this.type})
      : super(key: key);
  final String id;
  final String type;

  @override
  StateCustomDocPageState createState() => StateCustomDocPageState();
}

class StateCustomDocPageState extends State<CustomDocPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: ComponentAppBar(
          title: 'Document Preview',
          isSubMenu: true,
          extraButton: [getRestTimeDialog('Dictionary', dctFetchRestTime)],
        ),
        body: ListView(
          children: [GenerateDocSection(id: widget.id, type: widget.type)],
        ));
  }
}
