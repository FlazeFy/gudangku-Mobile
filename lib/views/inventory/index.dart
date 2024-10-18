import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:gudangku/modules/component/appbar.dart';
import 'package:gudangku/modules/component/button.dart';
import 'package:gudangku/modules/global/style.dart';
import 'package:gudangku/views/add_inventory/index.dart';
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
        appBar: const ComponentAppBar(title: 'My Inventory', isSubMenu: false),
        body: ListView(
          padding: const EdgeInsets.symmetric(horizontal: spaceMD),
          children: [
            Wrap(
              children: [
                InkWell(
                  onTap: () {
                    Get.to(const StatsPage());
                  },
                  child: const ComponentButton(
                    type: 'button_primary',
                    text: 'Stats',
                    icon: FaIcon(
                      FontAwesomeIcons.chartPie,
                      color: whiteColor,
                      size: textMD,
                    ),
                  ),
                ),
                const SizedBox(width: spaceXXSM),
                InkWell(
                  onTap: () {
                    Get.to(const AddInventoryPage());
                  },
                  child: const ComponentButton(
                    type: 'button_primary',
                    text: 'Add Inventory',
                    icon: FaIcon(
                      FontAwesomeIcons.plus,
                      color: whiteColor,
                      size: textMD,
                    ),
                  ),
                )
              ],
            ),
            const SizedBox(height: spaceMD),
            const GetAllInventory()
          ],
        ));
  }
}
