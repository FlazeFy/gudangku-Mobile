import 'package:flutter/material.dart';
import 'package:gudangku/modules/component/appbar.dart';
import 'package:gudangku/modules/component/footerbar.dart';
import 'package:gudangku/modules/global/style.dart';
import 'package:gudangku/views/help/usecase/data_constraint.dart';

class HelpPage extends StatefulWidget {
  const HelpPage({Key? key}) : super(key: key);

  @override
  StateHelpPageState createState() => StateHelpPageState();
}

class StateHelpPageState extends State<HelpPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: const ComponentAppBar(
          title: 'Help',
          isSubMenu: true,
        ),
        body: ListView(
          padding: const EdgeInsets.only(
              top: spaceJumbo, left: spaceMD, right: spaceMD),
          children: const [DataConstraint(), FooterBar()],
        ));
  }
}
