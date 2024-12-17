import 'package:flutter/material.dart';
import 'package:gudangku/modules/component/appbar.dart';
import 'package:gudangku/modules/component/footerbar.dart';
import 'package:gudangku/modules/global/style.dart';
import 'package:gudangku/views/about/abouts.dart';

class AboutPage extends StatefulWidget {
  const AboutPage({Key? key}) : super(key: key);

  @override
  StateAboutPageState createState() => StateAboutPageState();
}

class StateAboutPageState extends State<AboutPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: const ComponentAppBar(
          title: 'About',
          isSubMenu: true,
        ),
        body: ListView(
          padding: const EdgeInsets.only(
              left: spaceMD, right: spaceMD, top: spaceMD),
          children: const [AboutList(), FooterBar()],
        ));
  }
}
