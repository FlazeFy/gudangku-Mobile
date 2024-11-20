import 'package:flutter/material.dart';
import 'package:gudangku/modules/component/appbar.dart';
import 'package:gudangku/modules/component/footerbar.dart';
import 'package:gudangku/modules/global/style.dart';
import 'package:gudangku/views/features/features.dart';

class FeaturePage extends StatefulWidget {
  const FeaturePage({Key? key}) : super(key: key);

  @override
  StateFeaturePageState createState() => StateFeaturePageState();
}

class StateFeaturePageState extends State<FeaturePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: const ComponentAppBar(
          title: 'Features',
          isSubMenu: true,
        ),
        body: ListView(
          padding: const EdgeInsets.symmetric(horizontal: spaceMD),
          children: const [FeatureList(), FooterBar()],
        ));
  }
}
