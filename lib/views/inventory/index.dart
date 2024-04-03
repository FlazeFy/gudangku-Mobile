import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:gudangku/modules/global/style.dart';
import 'package:gudangku/views/inventory/usecase/get_all_inventory.dart';
import 'package:gudangku/views/stats/index.dart';

class InventoryPage extends StatefulWidget {
  const InventoryPage({Key? key}) : super(key: key);

  @override
  StateInventoryPageState createState() => StateInventoryPageState();
}

class StateInventoryPageState extends State<InventoryPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: ListView(
      padding:
          const EdgeInsets.only(top: spaceJumbo, left: spaceMD, right: spaceMD),
      children: [
        const Text(
          "My Inventory",
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
                    const BorderSide(color: primaryColor, width: 1.5)),
              ),
              icon: const Icon(Icons.pie_chart),
              onPressed: () {
                Get.to(const StatsPage());
              },
              label: const Text('Stats'),
            ),
          ],
        ),
        GetAllInventory()
      ],
    ));
  }
}
