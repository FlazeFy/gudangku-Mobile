import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:gudangku/modules/component/appbar.dart';
import 'package:gudangku/modules/component/button.dart';
import 'package:gudangku/modules/component/footerbar.dart';
import 'package:gudangku/modules/component/navbar.dart';
import 'package:gudangku/modules/global/style.dart';
import 'package:gudangku/modules/helpers/converter.dart';
import 'package:gudangku/views/add_inventory/index.dart';
import 'package:gudangku/views/inventory/usecase/filter.dart';
import 'package:gudangku/views/inventory/usecase/get_all_inventory.dart';
import 'package:gudangku/views/stats/index.dart';
import 'package:shared_preferences/shared_preferences.dart';

class InventoryPage extends StatefulWidget {
  const InventoryPage({Key? key}) : super(key: key);

  @override
  StateInventoryPageState createState() => StateInventoryPageState();
}

class StateInventoryPageState extends State<InventoryPage> {
  bool isLoading = false;
  String viewType = "catalog";

  @override
  void initState() {
    super.initState();
    loadConfig();
  }

  Future<void> loadConfig() async {
    setState(() {
      isLoading = true;
    });
    final prefs = await SharedPreferences.getInstance();
    viewType = prefs.getString('toogle_view_inventory') ?? "catalog";
    setState(() {
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      maintainBottomViewPadding: false,
      child: isLoading
          ? const Center(child: CircularProgressIndicator(color: primaryColor))
          : _buildListView(),
    );
  }

  Widget _buildListView() {
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
                ),
                const SizedBox(width: spaceXXSM),
                InkWell(
                  onTap: () async {
                    final prefs = await SharedPreferences.getInstance();
                    await prefs.setString('toogle_view_inventory',
                        viewType == 'catalog' ? 'table' : 'catalog');
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const BottomBar()),
                    );
                  },
                  child: ComponentButton(
                    type: 'button_primary',
                    text: ucFirst(viewType),
                    icon: FaIcon(
                      viewType == 'catalog'
                          ? FontAwesomeIcons.boxArchive
                          : FontAwesomeIcons.table,
                      color: whiteColor,
                      size: textMD,
                    ),
                  ),
                )
              ],
            ),
            const SizedBox(height: spaceMD),
            const FilterInventory(),
            const SizedBox(height: spaceMD),
            GetAllInventory(
              viewType: viewType,
            ),
            const FooterBar()
          ],
        ));
  }
}
