import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gudangku/modules/component/navbar.dart';
import 'package:gudangku/modules/global/style.dart';
import 'package:gudangku/views/stats/usecases/get_total_inventory_by_category.dart';

class StatsPage extends StatefulWidget {
  const StatsPage({Key? key}) : super(key: key);

  @override
  StateStatsPageState createState() => StateStatsPageState();
}

class StateStatsPageState extends State<StatsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: ListView(
      padding:
          const EdgeInsets.only(top: spaceJumbo, left: spaceMD, right: spaceMD),
      children: [
        const Text(
          "Stats",
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: textXLG),
        ),
        const SizedBox(height: spaceMD),
        Wrap(
          children: [
            ElevatedButton.icon(
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all(Colors.transparent),
                foregroundColor: MaterialStateProperty.all(whiteColor),
                side: MaterialStateProperty.all(
                    const BorderSide(color: dangerBG, width: 1.5)),
              ),
              icon: const Icon(Icons.arrow_back),
              onPressed: () {
                Get.to(const BottomBar());
              },
              label: const Text('Back'),
            ),
          ],
        ),
        TotalInventoryByCategory()
      ],
    ));
  }
}
