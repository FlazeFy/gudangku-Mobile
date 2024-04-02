import 'package:flutter/material.dart';
import 'package:gudangku/modules/global/style.dart';
import 'package:gudangku/views/inventory/usecase/get_all_inventory.dart';

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
        GetAllInventory()
      ],
    ));
  }
}
