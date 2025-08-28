import 'package:flutter/material.dart';
import 'package:gudangku/modules/component/appbar.dart';
import 'package:gudangku/modules/component/footerbar.dart';
import 'package:gudangku/modules/global/style.dart';
import 'package:gudangku/views/lend/usecases/post_qr_lend.dart';

class LendPage extends StatefulWidget {
  const LendPage({Key? key}) : super(key: key);

  @override
  StateLendPageState createState() => StateLendPageState();
}

class StateLendPageState extends State<LendPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: const ComponentAppBar(
          title: 'Lend',
          isSubMenu: true,
        ),
        body: ListView(
          padding: const EdgeInsets.only(
              left: spaceMD, right: spaceMD, top: spaceMD),
          children: const [PostQRCode(), FooterBar()],
        ));
  }
}
